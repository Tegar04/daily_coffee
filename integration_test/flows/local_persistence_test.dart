import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Run seed, verify, then deleted in SEPARATE invocations with --no-uninstall.
/// Uses the production bootstrap/provider/background file connection.
/// Only creates/deletes its own uniquely named test coffee.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const stage = String.fromEnvironment(
    'PERSISTENCE_STAGE',
    defaultValue: 'seed',
  );
  const name = 'Phase 5 persistence QA';
  const editedName = 'Phase 5 persistence QA edited';

  Future<void> settle(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  }

  Future<void> tap(WidgetTester tester, String text) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await settle(tester);
    final finder = find.text(text).last;
    await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
    await settle(tester);
    await tester.tap(finder);
    await settle(tester);
  }

  testWidgets('production persistence stage: $stage', (tester) async {
    await app.main();
    await settle(tester);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(DailyCoffeeBootstrap)),
    );
    await container.read(appBootstrapProvider.future);
    await settle(tester);
    if (find.text('Mulai mencatat').evaluate().isNotEmpty) {
      await tap(tester, 'Mulai mencatat');
    }
    await tap(tester, 'Koleksi');
    final repo = container.read(coffeeRepositoryProvider);
    var before = (await repo.watchLibrary().first as Ok<List<Coffee>>).value;
    if (stage == 'seed' &&
        const bool.fromEnvironment('PERSISTENCE_RESET_FIXTURE')) {
      for (final coffee in before.where(
        (c) =>
            [name, editedName].contains(c.details.name) &&
            c.details.roastery == 'Persistence Roaster',
      )) {
        final impact =
            await repo.inspectDeleteImpact(coffee.id) as Ok<CoffeeDeleteImpact>;
        expect(await repo.delete(impact.value), isA<Ok<void>>());
      }
      before = (await repo.watchLibrary().first as Ok<List<Coffee>>).value;
    }

    if (stage == 'seed') {
      expect(
        before.where((c) => [name, editedName].contains(c.details.name)),
        isEmpty,
        reason:
            'Use a clean QA coffee name; do not overwrite existing records.',
      );
      await tap(tester, 'Tambah kopi');
      await tap(tester, 'Isi manual');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nama kopi (wajib)'),
        name,
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Roastery (wajib)'),
        'Persistence Roaster',
      );
      await tap(tester, 'Simpan kopi');
      expect(find.text(name), findsWidgets);
      await tester.tap(find.byTooltip('Tambahkan ke favorit'));
      await settle(tester);
      await tap(tester, 'Edit kopi');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nama kopi (wajib)'),
        editedName,
      );
      await tap(tester, 'Simpan perubahan');
      final saved = (await repo.watchLibrary().first as Ok<List<Coffee>>).value
          .singleWhere((c) => c.details.name == editedName);
      expect(saved.isFavorite, isTrue);
    } else if (stage == 'verify') {
      final saved = before.singleWhere((c) => c.details.name == editedName);
      expect(saved.isFavorite, isTrue);
      expect(saved.details.roastery, 'Persistence Roaster');
      await tap(tester, editedName);
      expect(find.byTooltip('Hapus dari favorit'), findsOneWidget);
      await tap(tester, 'Hapus kopi');
      await tap(tester, 'Hapus kopi');
      expect(
        (await repo.watchLibrary().first as Ok<List<Coffee>>).value.any(
          (c) => c.id == saved.id,
        ),
        isFalse,
      );
    } else if (stage == 'deleted') {
      expect(
        before.where((c) => [name, editedName].contains(c.details.name)),
        isEmpty,
      );
    } else {
      fail('Unknown PERSISTENCE_STAGE: $stage');
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await settle(tester);
  });
}
