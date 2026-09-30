import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:http/http.dart' as http;

import '../domain/label_extractor.dart';
import 'ai_connection_store.dart';
import 'backend_label_extractor.dart';

class ConfiguredLabelExtractor implements LabelExtractor {
  const ConfiguredLabelExtractor(this.store, this.client, this.fallback);
  final AiConnectionStore store;
  final http.Client client;
  final LabelExtractor fallback;

  @override
  Future<Result<CoffeeFormValues>> extract(String rawText) async {
    AiConnection? connection;
    try {
      connection = await store.read();
    } catch (_) {
      // Never silently switch servers after a credential storage failure.
      return const Err(StorageFailure());
    }
    if (connection == null) return fallback.extract(rawText);
    return BackendLabelExtractor(
      client,
      connection.endpoint,
      token: connection.token,
    ).extract(rawText);
  }
}
