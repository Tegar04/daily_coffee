import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_service.dart';
import 'package:daily_coffee/features/scan/presentation/ai_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../helpers/ai_connection_fakes.dart';

void main() {
  testWidgets('connect, hide token, and disconnect on a compact screen', (
    tester,
  ) async {
    final store = MemoryAiConnectionStore();
    final service = AiConnectionService(
      store,
      MockClient((_) async => http.Response('{"status":"ok"}', 200)),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [aiConnectionServiceProvider.overrideWith((ref) => service)],
        child: MaterialApp(
          theme: DailyTheme.light,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: const AiConnectionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final address = find.byType(TextField).at(0);
    final secret = find.byType(TextField).at(1);
    await tester.enterText(address, 'https://example.com');
    await tester.ensureVisible(secret);
    await tester.enterText(secret, 'dc_${'a' * 64}');
    expect(tester.widget<TextField>(secret).obscureText, isTrue);
    await tester.ensureVisible(find.text('Periksa & simpan'));
    await tester.tap(find.text('Periksa & simpan'));
    await tester.pumpAndSettle();
    expect(store.value, isNotNull);
    expect(tester.widget<TextField>(secret).controller!.text, isEmpty);
    await tester.ensureVisible(find.text('Hapus koneksi tersimpan'));
    await tester.tap(find.text('Hapus koneksi tersimpan'));
    await tester.pumpAndSettle();
    expect(store.value, isNull);
    expect(tester.takeException(), isNull);
  });
}
