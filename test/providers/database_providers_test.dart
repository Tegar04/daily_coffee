import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/app/composition/database_providers.dart';
import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';
import '../helpers/test_doubles.dart';

void main() {
  test('production provider injects one local repository and bootstrap opens SQLite', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    await container.read(appBootstrapProvider.future);
    final repo = container.read(coffeeRepositoryProvider);
    expect(repo, isA<DriftCoffeeRepository>());
    expect(identical(repo, container.read(coffeeRepositoryProvider)), isTrue);
    expect(await repo.create(coffeeInput()), isA<Ok<Coffee>>());
    expect(await db.select(db.coffees).get(), hasLength(1));
  });

  testWidgets(
    'database initialization failure displays safe retry and then recovers',
    (tester) async {
      var attempts = 0;
      final repo = TestCoffeeRepository();
      addTearDown(repo.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
            coffeeRepositoryProvider.overrideWithValue(repo),
            databaseInitializationProvider.overrideWith((ref) async {
              if (attempts++ == 0) throw const MigrationFailure();
            }),
          ],
          child: const DailyCoffeeBootstrap(),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Aplikasi belum dapat disiapkan. Data Anda tidak dihapus.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Coba lagi'));
      await tester.pumpAndSettle();
      expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);
      expect(attempts, 2);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
