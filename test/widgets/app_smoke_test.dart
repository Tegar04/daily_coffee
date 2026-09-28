import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_doubles.dart';

void main() {
  testWidgets('onboarding and root pages fit compact landscape at 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(600, 360);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesProvider.overrideWithValue(
            FakeAppPreferences(hasCompletedOnboarding: false),
          ),
        ],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Mulai mencatat'));
    await tester.tap(find.text('Mulai mencatat'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Jurnal'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Pengaturan'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders Daily Coffee through the root ProviderScope', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
        ],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Koleksi'), findsWidgets);
    expect(find.text('Jurnal'), findsOneWidget);
    expect(find.text('Pengaturan'), findsOneWidget);
  });

  testWidgets('shows onboarding only before it is completed', (tester) async {
    final preferences = FakeAppPreferences(hasCompletedOnboarding: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appPreferencesProvider.overrideWithValue(preferences)],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mulai mencatat'), findsOneWidget);
    await tester.tap(find.text('Mulai mencatat'));
    await tester.pumpAndSettle();

    expect(preferences.hasCompletedOnboarding, isTrue);
    expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);
  });

  testWidgets('keeps each root branch state and opens child routes', (
    tester,
  ) async {
    final preferences = FakeAppPreferences();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appPreferencesProvider.overrideWithValue(preferences)],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Jurnal'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada catatan seduh'), findsOneWidget);
    expect(preferences.lastRootIndex, 1);

    await tester.tap(find.text('Pengaturan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tentang'));
    await tester.pumpAndSettle();
    expect(
      find.text('Halaman ini siap untuk implementasi feature berikutnya.'),
      findsOneWidget,
    );
  });

  testWidgets('asks before leaving a form with unsaved changes', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
        ],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tambah kopi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Isi manual'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama kopi (wajib)'),
      'Ethiopia Natural',
    );
    await tester.pump();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Buang perubahan?'), findsOneWidget);
    await tester.tap(find.text('Tetap mengedit'));
    await tester.pumpAndSettle();
    expect(find.text('Tambah kopi'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buang'));
    await tester.pumpAndSettle();
    expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);
  });
}
