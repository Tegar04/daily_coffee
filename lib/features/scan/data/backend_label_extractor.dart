import 'dart:async';
import 'dart:convert';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:http/http.dart' as http;

import '../domain/label_extractor.dart';

class BackendLabelExtractor implements LabelExtractor {
  BackendLabelExtractor(
    this.client,
    this.endpoint, {
    this.timeout = const Duration(seconds: 55),
    this.token,
  });
  final http.Client client;
  final Uri? endpoint;
  final Duration timeout;
  final String? token;

  static const fields = {
    'name': CoffeeField.name,
    'roastery': CoffeeField.roastery,
    'origin_country': CoffeeField.originCountry,
    'region': CoffeeField.region,
    'producer': CoffeeField.producer,
    'process': CoffeeField.process,
    'roast_date': CoffeeField.roastDate,
    'roast_level': CoffeeField.roastLevelKey,
    'roast_level_custom': CoffeeField.roastLevelCustom,
    'altitude_min_meters': CoffeeField.altitudeMinMeters,
    'altitude_max_meters': CoffeeField.altitudeMaxMeters,
    'package_weight_grams': CoffeeField.packageWeightGrams,
  };

  @override
  Future<Result<CoffeeFormValues>> extract(String rawText) async {
    if (endpoint == null) {
      return const Err(
        ExternalServiceFailure(diagnosticContext: {'reason': 'not_configured'}),
      );
    }
    if (rawText.trim().isEmpty || rawText.runes.length > 12000) {
      return const Err(ValidationFailure());
    }
    try {
      final request = http.Request('POST', endpoint!)
        ..followRedirects = false
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        })
        ..body = jsonEncode({'raw_text': rawText});
      final response = await (() async => http.Response.fromStream(
        await client.send(request),
      ))().timeout(timeout);
      if (response.statusCode != 200) {
        return Err(
          ExternalServiceFailure(
            diagnosticContext: {'status': response.statusCode},
          ),
        );
      }
      if (response.bodyBytes.length > 65536) throw const FormatException();
      final root =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if ((root['meta'] as Map<String, dynamic>)['requires_review'] != true) {
        throw const FormatException();
      }
      final data = root['data'] as Map<String, dynamic>;
      if (data.length != fields.length + 2 ||
          ![
            ...fields.keys,
            'varieties',
            'tasting_notes',
          ].every(data.containsKey)) {
        throw const FormatException();
      }
      var values = CoffeeFormValues();
      for (final entry in fields.entries) {
        final value = data[entry.key];
        final numeric =
            entry.key.endsWith('_meters') || entry.key.endsWith('_grams');
        if (value != null && (numeric ? value is! int : value is! String)) {
          throw const FormatException();
        }
        values = values.set(entry.value, value?.toString() ?? '');
      }
      List<String> tags(String key) {
        final list = (data[key] as List).cast<String>();
        if (CoffeeValidation.validateTags(list) != null) {
          throw const FormatException();
        }
        return list;
      }

      values = values.withTags(
        varieties: tags('varieties'),
        tastingNotes: tags('tasting_notes'),
      );
      final errors = CoffeeValidation.validate(values).values
          .where((issue) => issue != CoffeeValidationIssue.required);
      if (errors.isNotEmpty ||
          (values[CoffeeField.altitudeMinMeters].isEmpty !=
              values[CoffeeField.altitudeMaxMeters].isEmpty)) {
        throw const FormatException();
      }
      return Ok(values);
    } on TimeoutException {
      return const Err(NetworkFailure());
    } on http.ClientException {
      return const Err(NetworkFailure());
    } catch (_) {
      return const Err(
        ExternalServiceFailure(
          diagnosticContext: {'reason': 'invalid_response'},
        ),
      );
    }
  }
}
