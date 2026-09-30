import 'dart:convert';
import 'dart:io';

import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_service.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_store.dart';
import 'package:daily_coffee/features/scan/data/backend_label_extractor.dart';
import 'package:daily_coffee/features/scan/presentation/ai_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';

// Local mock server + isolated secure-storage key. No OpenAI or personal data.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('device connection persists securely and sends bearer token', (
    tester,
  ) async {
    final token = 'dc_${'a' * 64}';
    final key =
        'coffee_ai_connection_qa_${DateTime.now().microsecondsSinceEpoch}';
    final store = SecureAiConnectionStore(
      const FlutterSecureStorage(),
      key: key,
    );
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final client = http.Client();
    var checks = 0;
    var extractions = 0;
    final listener = server.listen((request) async {
      request.response.headers.contentType = ContentType.json;
      if (request.headers.value('Authorization') != 'Bearer $token') {
        request.response.statusCode = 401;
      } else if (request.uri.path == '/api/device/check') {
        checks++;
        request.response.write('{"status":"ok"}');
      } else if (request.uri.path == '/api/coffee-label/extract') {
        extractions++;
        await request.drain<void>();
        request.response.write(
          jsonEncode({
            'data': {
              for (final field in BackendLabelExtractor.fields.keys)
                field: null,
              'altitude_min_meters': 1500,
              'altitude_max_meters': 1700,
              'varieties': <String>[],
              'tasting_notes': <String>[],
            },
            'meta': {'requires_review': true},
          }),
        );
      } else {
        request.response.statusCode = 404;
      }
      await request.response.close();
    });
    try {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            aiConnectionServiceProvider.overrideWith(
              (ref) => AiConnectionService(store, client),
            ),
          ],
          child: MaterialApp(
            theme: DailyTheme.light,
            home: const AiConnectionScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).at(0),
        'http://127.0.0.1:${server.port}',
      );
      await tester.enterText(find.byType(TextField).at(1), token);
      await tester.ensureVisible(find.text('Periksa & simpan'));
      await tester.tap(find.text('Periksa & simpan'));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(find.textContaining('Koneksi berhasil disimpan'), findsOneWidget);
      expect(checks, 1);
      final reopened = await SecureAiConnectionStore(
        const FlutterSecureStorage(),
        key: key,
      ).read();
      expect(reopened, isNotNull);
      final result = await BackendLabelExtractor(
        client,
        reopened!.endpoint,
        token: reopened.token,
      ).extract('QA label');
      expect(result, isA<Ok<CoffeeFormValues>>());
      expect(
        (result as Ok<CoffeeFormValues>).value[CoffeeField.altitudeMinMeters],
        '1500',
      );
      expect(extractions, 1);
      await tester.ensureVisible(find.text('Hapus koneksi tersimpan'));
      await tester.tap(find.text('Hapus koneksi tersimpan'));
      await tester.pumpAndSettle();
      expect(await store.read(), isNull);
      expect(tester.takeException(), isNull);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      await store.clear();
      client.close();
      await listener.cancel();
      await server.close(force: true);
    }
  });
}
