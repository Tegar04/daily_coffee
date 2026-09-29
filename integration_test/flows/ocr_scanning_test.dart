import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/scan/data/mlkit_label_text_recognizer.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

import '../../test/fixtures/coffee_label_images.dart';

/// Real native OCR and disk storage. Run seed/verify in separate app processes
/// with --no-uninstall and network disabled. Uses an isolated QA database.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const stage = String.fromEnvironment('OCR_STAGE', defaultValue: 'seed');
  testWidgets('offline OCR and durable draft: $stage', (tester) async {
    await tester.pumpWidget(const SizedBox());
    final support = await getApplicationSupportDirectory();
    final root = Directory('${support.path}/phase7-ocr-qa');
    await root.create(recursive: true);
    final db = AppDatabase(NativeDatabase(File('${root.path}/qa.sqlite')));
    final storage = ImageStorage(root, ImageProcessor());
    final store = ScanDraftStore(db, storage, const SystemAppClock());
    try {
      if (stage == 'verify') {
        final drafts = await store.load();
        expect(drafts, hasLength(3));
        for (final draft in drafts) {
          expect(draft.result!.text.toUpperCase(), contains('NUSANTARA'));
          expect(draft.result!.lines, isNotEmpty);
          expect(await storage.file(draft.image.localPath).exists(), isTrue);
        }
        expect(await db.select(db.coffees).get(), isEmpty);
      } else {
        final recognizer = MlkitLabelTextRecognizer(storage);
        await db.delete(db.coffeeDrafts).go();
        for (var i = 0; i < 4; i++) {
          final id = '00000000-0000-4000-8000-00000000700$i';
          final fixture = File('${root.path}/input-$i.jpg');
          await fixture.writeAsBytes(
            coffeeLabelFixture(
              columns: i == 1,
              degraded: i == 2,
              blank: i == 3,
            ),
          );
          final image = await storage.stage(fixture.path, id, 'gallery');
          final result = await recognizer.recognize(image);
          if (i == 3) {
            expect(result, isA<Err<RecognizedLabelText>>());
            expect(
              (result as Err<RecognizedLabelText>).failure,
              isA<OcrNoTextFailure>(),
            );
            await storage.deleteWithThumbnail(image.localPath);
            await fixture.delete();
            continue;
          }
          expect(result, isA<Ok<RecognizedLabelText>>());
          final text = (result as Ok<RecognizedLabelText>).value;
          expect(text.text.toUpperCase(), contains('NUSANTARA'));
          expect(text.text.toUpperCase(), contains('INDONESIA'));
          expect(text.lines.any((line) => line.confidence != null), isTrue);
          await storage.writeJson('drafts/$id/image.json', image.toJson());
          final now = DateTime.now().toUtc().microsecondsSinceEpoch;
          await db
              .into(db.coffeeDrafts)
              .insert(
                CoffeeDraftsCompanion.insert(
                  id: id,
                  draftType: 'scan_create',
                  status: 'image_ready',
                  temporaryImagePath: Value(image.localPath),
                  imageMimeType: const Value('image/jpeg'),
                  createdAt: now,
                  updatedAt: now,
                ),
              );
          final revision = await store.begin(id);
          expect(await store.finish(id, revision, result: text), isTrue);
          await fixture.delete();
        }
        expect(await db.select(db.coffees).get(), isEmpty);
      }
    } finally {
      await db.close();
      if (stage == 'verify') await root.delete(recursive: true);
    }
  });
}
