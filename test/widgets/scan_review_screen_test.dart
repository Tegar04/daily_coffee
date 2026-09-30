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
    'AI automatically fills a new review once and keeps it editable',
    (tester) async {
      final repository = FakeScanReviewRepository();
      final ai = FakeLabelExtractor();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            scanReviewRepositoryProvider.overrideWith(
              (ref) async => repository,
            ),
            labelExtractorProvider.overrideWith((ref) => ai),
          ],
          child: MaterialApp(
            theme: DailyTheme.light,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            home: ScanReviewScreen(draftId: repository.draft.id),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Pilih dari label'), findsNothing);
      expect(find.text('Isi dengan AI'), findsNothing);
      expect(find.byType(AlertDialog), findsNothing);
      expect(ai.calls, 1);
      expect(repository.draft.values[CoffeeField.altitudeMinMeters], '1500');
      expect(repository.draft.values[CoffeeField.altitudeMaxMeters], '1700');
      expect(repository.draft.values[CoffeeField.name], 'Kopi AI');
      expect(repository.draft.values[CoffeeField.roastery], 'Nusantara');
      expect(
        tester
            .widget<DropdownButtonFormField<String>>(
              find.byType(DropdownButtonFormField<String>),
            )
            .initialValue,
        'light',
      );
      expect(
        tester
            .widget<CheckboxListTile>(
              find.widgetWithText(
                CheckboxListTile,
                'Saya sudah memeriksa informasi kopi.',
              ),
            )
            .value,
        isFalse,
      );
      final name = find.descendant(
        of: find.byWidgetPredicate(
          (w) => w is DailyTextField && w.label == 'Nama kopi',
        ),
        matching: find.byType(TextField),
      );
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Koreksi manual');
      await tester.pumpAndSettle();
      expect(repository.draft.values[CoffeeField.name], 'Koreksi manual');
      expect(ai.calls, 1);
      expect(repository.promotions, 0);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'editable review requires confirmation, validates fields, then saves',
    (tester) async {
      final repository = FakeScanReviewRepository();
      final ai = FakeLabelExtractor();
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
            labelExtractorProvider.overrideWith((ref) => ai),
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
