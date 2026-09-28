import 'dart:async';

import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/application/coffee_queries.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/presentation/screens/coffee_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';
import '../helpers/test_doubles.dart';

Future<void> pumpApp(
  WidgetTester tester,
  TestCoffeeRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
        coffeeRepositoryProvider.overrideWithValue(repository),
      ],
      child: const DailyCoffeeBootstrap(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapText(WidgetTester tester, String text) async {
  final finder = find.text(text).last;
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> enter(WidgetTester tester, String label, String value) async {
  final finder = find.widgetWithText(TextFormField, label);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, value);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('manual create detail favorite edit and delete work offline', (
    tester,
  ) async {
    final repository = TestCoffeeRepository();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      await repository.dispose();
    });
    await pumpApp(tester, repository);
    await tapText(tester, 'Tambah kopi');
    await tapText(tester, 'Isi manual');
    await enter(tester, 'Nama kopi (wajib)', 'Ethiopia Guji');
    await enter(tester, 'Roastery (wajib)', 'Daily Roaster');
    await enter(tester, 'Tasting notes', 'Peach');
    await tapText(tester, 'Simpan kopi');
    expect(find.text('Detail kopi'), findsOneWidget);
    expect(find.text('Ethiopia Guji'), findsOneWidget);
    expect(find.text('Peach'), findsOneWidget);
    await tester.tap(find.byTooltip('Tambahkan ke favorit'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Hapus dari favorit'), findsOneWidget);
    await tapText(tester, 'Edit kopi');
    await enter(tester, 'Nama kopi (wajib)', 'Guji Natural');
    await tapText(tester, 'Detail lainnya');
    await enter(tester, 'Berat kemasan (g)', '250');
    await enter(tester, 'Catatan pribadi', 'Catatan coffee, bukan sesi seduh');
    await tapText(tester, 'Simpan perubahan');
    expect(find.text('Guji Natural'), findsOneWidget);
    expect(find.text('Berat kemasan: 250 g'), findsOneWidget);
    expect(find.byTooltip('Hapus dari favorit'), findsOneWidget);
    await tester.tap(find.byTooltip('Kembali'));
    await tester.pumpAndSettle();
    expect(find.text('Guji Natural'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
    await tapText(tester, 'Guji Natural');
    await tapText(tester, 'Hapus kopi');
    expect(find.textContaining('0 catatan seduh'), findsOneWidget);
    await tapText(tester, 'Batal');

    await tapText(tester, 'Hapus kopi');
    await tapText(tester, 'Hapus kopi');
    expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'submit errors keep fields permit retry and validate required fields',
    (tester) async {
      final repository = TestCoffeeRepository()
        ..writeFailure = const StorageFailure(cause: 'PRIVATE RAW ERROR');
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await repository.dispose();
      });
      await pumpApp(tester, repository);
      await tapText(tester, 'Tambah kopi');
      await tapText(tester, 'Isi manual');
      await tapText(tester, 'Simpan kopi');
      expect(find.text('Bagian ini wajib diisi.'), findsNWidgets(2));
      expect(repository.createCalls, 0);
      await enter(tester, 'Nama kopi (wajib)', 'Guji');
      await enter(tester, 'Roastery (wajib)', 'Roaster');
      await tapText(tester, 'Simpan kopi');
      expect(find.textContaining('Isian Anda tetap tersedia'), findsOneWidget);
      expect(find.textContaining('PRIVATE RAW ERROR'), findsNothing);
      expect(find.widgetWithText(TextFormField, 'Guji'), findsOneWidget);
      repository.writeFailure = null;
      await tapText(tester, 'Simpan kopi');
      expect(find.text('Detail kopi'), findsOneWidget);
      expect(repository.createCalls, 2);
    },
  );

  testWidgets(
    'delete discloses journal impact and cascades only after consent',
    (tester) async {
      final coffee = sampleCoffee();
      final repository = TestCoffeeRepository(
        seed: [coffee],
        journalLinks: {'a': coffee.id, 'b': coffee.id},
      );
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await repository.dispose();
      });
      await pumpApp(tester, repository);
      await tapText(tester, 'Guji');
      await tapText(tester, 'Hapus kopi');
      expect(find.textContaining('2 catatan seduh'), findsOneWidget);
      expect(repository.journalLinks.length, 2);
      await tapText(tester, 'Hapus kopi');
      expect(repository.deletedImpact?.journalCount, 2);
      expect(repository.journalLinks, isEmpty);
    },
  );

  testWidgets(
    'library error retries and invalid deep link returns to collection',
    (tester) async {
      final repository = TestCoffeeRepository()..libraryFailure = true;
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await repository.dispose();
      });
      await pumpApp(tester, repository);
      expect(
        find.text('Koleksi belum dapat dimuat. Coba lagi.'),
        findsOneWidget,
      );
      repository.libraryFailure = false;
      await tapText(tester, 'Coba lagi');
      expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);
      const CoffeeDetailRoute(coffeeId: 'malformed')
          .go(tester.element(find.byType(CoffeeLibraryScreen)));
      await tester.pumpAndSettle();
      expect(find.text('Kopi tidak ditemukan'), findsOneWidget);
      await tapText(tester, 'Kembali ke Koleksi');
      expect(find.text('Koleksi kopi masih kosong'), findsOneWidget);
    },
  );

  testWidgets('library shows skeleton until stream delivers data', (
    tester,
  ) async {
    final stream = StreamController<Result<List<Coffee>>>();
    addTearDown(stream.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
          coffeeLibraryProvider.overrideWith((ref) => stream.stream),
        ],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(DailyLoadingSkeleton), findsWidgets);
    stream.add(Ok([sampleCoffee()]));
    await tester.pumpAndSettle();
    expect(find.text('Guji'), findsOneWidget);
    stream.add(const Err(StorageFailure()));
    await tester.pumpAndSettle();
    expect(find.text('Guji'), findsOneWidget);
    expect(
      find.textContaining('Koleksi terakhir tetap ditampilkan'),
      findsOneWidget,
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'compact 200% form keeps save and optional validation reachable',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 720);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final repository = TestCoffeeRepository();
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await repository.dispose();
      });
      await pumpApp(tester, repository);
      await tapText(tester, 'Tambah kopi');
      await tapText(tester, 'Isi manual');
      tester.view.viewInsets = const FakeViewPadding(bottom: 240);
      await tester.pump();
      await enter(tester, 'Nama kopi (wajib)', 'Kopi dengan nama yang panjang');
      await enter(tester, 'Roastery (wajib)', 'Roastery panjang');
      await tapText(tester, 'Detail lainnya');
      await enter(tester, 'Berat kemasan (g)', '0');
      await tapText(tester, 'Sembunyikan detail lainnya');
      await tapText(tester, 'Simpan kopi');
      expect(find.textContaining('Gunakan bilangan bulat'), findsOneWidget);
      await enter(tester, 'Berat kemasan (g)', '200');
      await tapText(tester, 'Simpan kopi');
      expect(find.text('Detail kopi'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
