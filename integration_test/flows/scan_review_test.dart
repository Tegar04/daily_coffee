import 'dart:convert';
import 'dart:io';

import 'package:daily_coffee/app/composition/database_providers.dart';
import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/app/routing/navigation_screens.dart';
import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/features/scan/data/mlkit_label_text_recognizer.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

import '../../test/fixtures/coffee_label_images.dart';
import '../../test/helpers/test_doubles.dart';

/// seed -> force-stop -> verify, on a device with --no-uninstall.
/// Actual OCR, review widgets/providers, SQLite and image files; isolated QA data.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const stage = String.fromEnvironment('REVIEW_STAGE', defaultValue: 'seed');
  const id = '00000000-0000-4000-8000-000000008001';
  testWidgets('OCR review and promotion $stage', (tester) async {
    final support = await getApplicationSupportDirectory();
    final root = Directory('${support.path}/phase8-review-qa');
    await root.create(recursive: true);
    final db = AppDatabase(NativeDatabase(File('${root.path}/qa.sqlite')));
    final storage = ImageStorage(root, ImageProcessor());
    if (stage == 'seed') {
      await db.delete(db.coffeeDrafts).go();
      final fixture = File('${root.path}/label.jpg');
      await fixture.writeAsBytes(coffeeLabelFixture());
      final image = await storage.stage(fixture.path, id, 'gallery');
      await storage.writeJson('drafts/$id/image.json', image.toJson());
      final recognized = await MlkitLabelTextRecognizer(storage)
          .recognize(image);
      expect(recognized, isA<Ok<RecognizedLabelText>>());
      final text = (recognized as Ok<RecognizedLabelText>).value;
      final now = DateTime.now().toUtc().microsecondsSinceEpoch;
      await db
          .into(db.coffeeDrafts)
          .insert(
            CoffeeDraftsCompanion.insert(
              id: id,
              draftType: 'scan_create',
              status: 'review_required',
              temporaryImagePath: Value(image.localPath),
              imageMimeType: const Value('image/jpeg'),
              ocrRawText: Value(text.text),
              ocrLinesJson: Value(
                jsonEncode(text.lines.map((line) => line.toJson()).toList()),
              ),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
    final router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: const ReviewRoute(draftId: id).location,
      routes: appRoutes,
    );
    Future<void> settle() =>
        tester.pumpAndSettle(const Duration(milliseconds: 150));
    Future<void> waitFor(String label) async {
      for (var i = 0; i < 100 && find.text(label).evaluate().isEmpty; i++) {
        await tester.pump(const Duration(milliseconds: 250));
      }
      expect(find.text(label), findsWidgets);
      await settle();
    }

    Finder field(String label) => find.descendant(
      of: find.byWidgetPredicate(
        (w) => w is DailyTextField && w.label == label,
      ),
      matching: find.byType(TextField),
    );
    Future<void> type(String label, String value) async {
      final input = field(label);
      await Scrollable.ensureVisible(tester.element(input), alignment: 0.3);
      await settle();
      await tester.enterText(input, value);
      await settle();
    }

    Future<void> tap(String label) async {
      FocusManager.instance.primaryFocus?.unfocus();
      await settle();
      await Scrollable.ensureVisible(
        tester.element(find.text(label).last),
        alignment: 0.5,
      );
      await settle();
      await tester.tap(find.text(label).last);
      await settle();
    }

    try {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            imageStorageProvider.overrideWith((ref) async => storage),
          ],
          child: AppPreferencesScope(
            preferences: FakeAppPreferences(),
            child: MaterialApp.router(
              theme: DailyTheme.light,
              routerConfig: router,
            ),
          ),
        ),
      );
      await waitFor('Periksa informasi');
      await waitFor('Draft tersimpan di perangkat.');
      expect(await db.select(db.coffees).get(), isEmpty);
      if (stage == 'seed') {
        expect(
          tester
              .widget<TextField>(field('Negara asal'))
              .controller!
              .text
              .toLowerCase(),
          'indonesia',
        );
        await type('Nama kopi', 'Phase 8 QA coffee');
        await type('Tanggal roasting', '2026-0');
        await waitFor('Draft tersimpan di perangkat.');
        final row = await db.select(db.coffeeDrafts).getSingle();
        expect(row.reviewJson, contains('Phase 8 QA coffee'));
        expect(row.reviewJson, contains('2026-0'));
        expect(await db.select(db.coffees).get(), isEmpty);
      } else {
        expect(
          tester.widget<TextField>(field('Nama kopi')).controller!.text,
          'Phase 8 QA coffee',
        );
        expect(
          tester.widget<TextField>(field('Tanggal roasting')).controller!.text,
          '2026-0',
        );
        await type('Tanggal roasting', '2026-09-29');
        await tap('Saya sudah memeriksa informasi kopi.');
        await tap('Konfirmasi & simpan kopi');
        await waitFor('Phase 8 QA coffee');
        expect(await db.select(db.coffees).get(), hasLength(1));
        expect(await db.select(db.coffeeDrafts).get(), isEmpty);
        expect(await db.select(db.scanExtractedFields).get(), isEmpty);
        final photo = await db.select(db.coffeePhotos).getSingle();
        expect(await storage.file(photo.localPath).exists(), isTrue);
        expect(await storage.file('drafts/$id/cover.jpg').exists(), isFalse);
      }
    } finally {
      await tester.pumpWidget(const SizedBox());
      router.dispose();
      await db.close();
      if (stage == 'verify') await root.delete(recursive: true);
    }
  });
}
