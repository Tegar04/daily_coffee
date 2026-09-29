import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/presentation/scan_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helpers/scan_review_fakes.dart';

void main() {
  testWidgets(
    'editable review requires confirmation, validates fields, then saves',
    (tester) async {
      final repository = FakeScanReviewRepository();
      final router = GoRouter(
        initialLocation: '/coffee/review',
        routes: [
          GoRoute(
            path: '/coffee/review',
            builder: (_, _) => ScanReviewScreen(draftId: repository.draft.id),
          ),
          GoRoute(
            path: '/coffee/:id',
            builder: (_, _) => const Scaffold(body: Text('Coffee tersimpan')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            scanReviewRepositoryProvider.overrideWith(
              (ref) async => repository,
            ),
          ],
          child: MaterialApp.router(
            theme: DailyTheme.light,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(repository.promotions, 0);
      Future<void> tap(String label) async {
        await tester.ensureVisible(find.text(label));
        await tester.pumpAndSettle();
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
      }

      final name = find.descendant(
        of: find.byWidgetPredicate(
          (w) => w is DailyTextField && w.label == 'Nama kopi',
        ),
        matching: find.byType(TextField),
      );
      await tester.ensureVisible(name);
      await tester.enterText(name, '');
      await tester.pumpAndSettle();
      await tap('Saya sudah memeriksa informasi kopi.');
      await tap('Konfirmasi & simpan kopi');
      expect(find.text('Bagian ini wajib diisi.'), findsOneWidget);
      expect(repository.promotions, 0);
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Gayo pilihan');
      await tester.pumpAndSettle();
      expect(repository.draft.values[CoffeeField.name], 'Gayo pilihan');
      await tap('Konfirmasi & simpan kopi');
      expect(repository.promotions, 0);
      await tap('Saya sudah memeriksa informasi kopi.');
      await tap('Konfirmasi & simpan kopi');
      expect(find.text('Coffee tersimpan'), findsOneWidget);
      expect(repository.promotions, 1);
      expect(tester.takeException(), isNull);
    },
  );
}
