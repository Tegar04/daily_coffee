import 'dart:async';
import 'dart:convert';

import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/data/backend_label_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  final endpoint = Uri.parse('http://127.0.0.1:8000/api/coffee-label/extract');
  Map<String, dynamic> fixture() => {
    'data': {
      for (final key in BackendLabelExtractor.fields.keys) key: null,
      'altitude_min_meters': 1500,
      'altitude_max_meters': 1700,
      'package_weight_grams': 250,
      'roast_date': '2026-09-29',
      'varieties': ['Bourbon'],
      'tasting_notes': ['Peach'],
    },
    'meta': {'requires_review': true},
  };
  test(
    'posts raw text only and maps nullable fields including altitude',
    () async {
      final client = MockClient((request) async {
        expect(request.url, endpoint);
        expect(request.headers.containsKey('authorization'), isFalse);
        expect(jsonDecode(request.body), {'raw_text': 'Label example'});
        expect(request.followRedirects, isFalse);
        return http.Response(jsonEncode(fixture()), 200);
      });
      final result = await BackendLabelExtractor(
        client,
        endpoint,
      ).extract('Label example') as Ok<CoffeeFormValues>;
      expect(result.value[CoffeeField.altitudeMinMeters], '1500');
      expect(result.value[CoffeeField.altitudeMaxMeters], '1700');
      expect(result.value[CoffeeField.name], '');
      expect(result.value.varieties, ['Bourbon']);
    },
  );
  test('HTTP errors, malformed and incomplete payloads fail safely', () async {
    for (final response in [
      http.Response('secret error', 500),
      http.Response('{}', 200),
      http.Response('not json', 200),
    ]) {
      final service = BackendLabelExtractor(
        MockClient((_) async => response),
        endpoint,
      );
      final result = await service.extract('Label');
      expect(result, isA<Err<CoffeeFormValues>>());
      expect((result as Err).failure.toString(), isNot(contains('secret')));
    }
  });
  test('invalid altitude/date/type rejected before form update', () async {
    for (final edit in [
      {'altitude_max_meters': 1000},
      {'altitude_min_meters': '1500'},
      {'roast_date': '2026-02-31'},
    ]) {
      final body = fixture();
      (body['data'] as Map).addAll(edit);
      final service = BackendLabelExtractor(
        MockClient((_) async => http.Response(jsonEncode(body), 200)),
        endpoint,
      );
      expect(await service.extract('Label'), isA<Err<CoffeeFormValues>>());
    }
  });
  test('not configured and invalid input never send requests', () async {
    final client = MockClient(
      (_) async => throw StateError('Unexpected request'),
    );
    expect(
      await BackendLabelExtractor(client, null).extract('Label'),
      isA<Err<CoffeeFormValues>>(),
    );
    expect(
      await BackendLabelExtractor(client, endpoint).extract(''),
      isA<Err<CoffeeFormValues>>(),
    );
  });
  test('timeout is bounded and no automatic retry occurs', () async {
    var calls = 0;
    final gate = Completer<http.Response>();
    final service = BackendLabelExtractor(
      MockClient((_) {
        calls++;
        return gate.future;
      }),
      endpoint,
      timeout: const Duration(milliseconds: 5),
    );
    expect(await service.extract('Label'), isA<Err<CoffeeFormValues>>());
    expect(calls, 1);
    gate.complete(http.Response('{}', 200));
  });
}
