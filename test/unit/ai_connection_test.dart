import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_service.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_store.dart';
import 'package:daily_coffee/features/scan/data/configured_label_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../helpers/ai_connection_fakes.dart';
import '../helpers/scan_review_fakes.dart';

void main() {
  final token = 'dc_${'a' * 64}';
  test(
    'rejects HTTP remote URLs, credentials, query strings and invalid tokens',
    () {
      for (final address in [
        'http://example.com',
        'https://user:pass@example.com',
        'https://example.com?token=x',
        'https://example.com#fragment',
        'https://example.com/wrong',
      ]) {
        expect(() => AiConnection.parse(address, token), throwsFormatException);
      }
      expect(
        () => AiConnection.parse('https://example.com', 'sk-invalid'),
        throwsFormatException,
      );
    },
  );

  test(
    'validates token without OpenAI and saves the endpoint/token together',
    () async {
      final store = MemoryAiConnectionStore();
      final service = AiConnectionService(
        store,
        MockClient((request) async {
          expect(
            request.url.toString(),
            'https://example.com/api/device/check',
          );
          expect(request.method, 'GET');
          expect(request.body, isEmpty);
          expect(request.headers['authorization'], 'Bearer $token');
          expect(request.followRedirects, isFalse);
          return http.Response('{"status":"ok"}', 200);
        }),
      );
      expect(
        await service.connect('https://example.com/', token),
        isA<Ok<void>>(),
      );
      expect(store.value!.endpoint.path, '/api/coffee-label/extract');
      expect(store.value!.token, token);
      await service.disconnect();
      expect(store.value, isNull);
    },
  );

  test('bad status or payload preserves old connection', () async {
    final store = MemoryAiConnectionStore()
      ..value = AiConnection.parse('https://old.example.com', token);
    for (final reply in [
      http.Response('secret', 401),
      http.Response('', 302),
      http.Response('{}', 200),
    ]) {
      final service = AiConnectionService(
        store,
        MockClient((_) async => reply),
      );
      expect(
        await service.connect('https://new.example.com', token),
        isA<Err<void>>(),
      );
      expect(store.value!.endpoint.host, 'old.example.com');
    }
  });

  test(
    'saved connection sends token only to its server, not fallback',
    () async {
      final store = MemoryAiConnectionStore()
        ..value = AiConnection.parse('https://private.example.com', token);
      final fallback = FakeLabelExtractor();
      var calls = 0;
      final extractor = ConfiguredLabelExtractor(
        store,
        MockClient((request) async {
          calls++;
          expect(request.url.host, 'private.example.com');
          expect(request.headers['authorization'], 'Bearer $token');
          expect(request.followRedirects, isFalse);
          return http.Response('', 401);
        }),
        fallback,
      );
      expect(await extractor.extract('Label'), isA<Err<CoffeeFormValues>>());
      expect(calls, 1);
      expect(fallback.calls, 0);
      store.fail = true;
      expect(await extractor.extract('Label'), isA<Err<CoffeeFormValues>>());
      expect(calls, 1);
      expect(fallback.calls, 0);
      store.fail = false;
      await store.clear();
      await extractor.extract('Label');
      expect(fallback.calls, 1);
    },
  );
}
