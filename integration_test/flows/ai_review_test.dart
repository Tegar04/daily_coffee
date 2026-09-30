import 'dart:io';

import 'package:daily_coffee/app/composition/database_providers.dart';
import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/application/scan_review_controller.dart';
import 'package:daily_coffee/features/scan/domain/coffee_draft.dart';
import 'package:daily_coffee/features/scan/presentation/scan_review_screen.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Opt-in live test: one billable synthetic label, isolated SQLite, no personal data.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const live = bool.fromEnvironment('RUN_LIVE_AI_TEST');
  testWidgets(
    'review calls backend and persists AI altitude without promotion',
    (tester) async {
      final root = await Directory.systemTemp.createTemp('daily_coffee_ai_qa_');
      final db = AppDatabase(NativeDatabase(File('${root.path}/qa.sqlite')));
      final storage = ImageStorage(root, ImageProcessor());
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          imageStorageProvider.overrideWith((ref) async => storage),
        ],
      );
      const id = '00000000-0000-4000-8000-000000008099';
      final subscription = container.listen(
        scanReviewControllerProvider(id),
        (_, _) {},
      );
      final now = DateTime.now().toUtc().microsecondsSinceEpoch;
      try {
        await db
            .into(db.coffeeDrafts)
            .insert(
              CoffeeDraftsCompanion.insert(
                id: id,
                draftType: 'scan_create',
                status: 'review_required',
                ocrRawText: const Value(
                  'Nama kopi: Gayo Highlands\nRoastery: Nusantara\nAltitude: 1500-1700 masl\nNet weight: 0.25 kg\nRoast date: 29 September 2026',
                ),
                ocrLinesJson: const Value('[]'),
                createdAt: now,
                updatedAt: now,
              ),
            );
        await container.read(scanReviewControllerProvider(id).future);
        final controller = container.read(
          scanReviewControllerProvider(id).notifier,
        );
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: DailyTheme.light,
              home: const ScanReviewScreen(draftId: id),
            ),
          ),
        );
        for (var i = 0; i < 280; i++) {
          await tester.pump(const Duration(milliseconds: 250));
          if (find
              .textContaining('Hasil AI diterapkan')
              .evaluate()
              .isNotEmpty) {
            break;
          }
        }
        expect(find.textContaining('Hasil AI diterapkan'), findsOneWidget);
        expect(await controller.flush(), isTrue);
        final repository = await container.read(
          scanReviewRepositoryProvider.future,
        );
        final restored = (await repository.open(id) as Ok<CoffeeDraft>).value;
        expect(restored.values[CoffeeField.altitudeMinMeters], '1500');
        expect(restored.values[CoffeeField.altitudeMaxMeters], '1700');
        expect(restored.values[CoffeeField.packageWeightGrams], '250');
        expect(restored.values[CoffeeField.roastDate], '2026-09-29');
        expect(await db.select(db.coffees).get(), isEmpty);
        expect(tester.takeException(), isNull);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        subscription.close();
        container.dispose();
        await db.close();
        await root.delete(recursive: true);
      }
    },
    skip: !live,
  );
}
