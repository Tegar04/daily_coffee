import 'dart:convert';
import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/data/drift_scan_review_repository.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/coffee_draft.dart';
import 'package:daily_coffee/features/scan/domain/coffee_label_parser.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/coffee_label_images.dart';
import '../helpers/database_fixtures.dart';
import '../helpers/test_doubles.dart';

void main() {
  late Directory root;
  late AppDatabase db;
  late ImageStorage storage;
  late DriftScanReviewRepository repository;
  final clock = FixedAppClock(dbTime);
  void connect() {
    db = AppDatabase(NativeDatabase(File('${root.path}/db.sqlite')));
    final ids = RandomAppIdGenerator();
    repository = DriftScanReviewRepository(
      db,
      storage,
      clock,
      ids,
      DriftCoffeeRepository(
        database: db,
        clock: clock,
        ids: ids,
        imageStorage: () async => storage,
      ),
    );
  }

  setUp(() async {
    root = await Directory.systemTemp.createTemp('review_');
    storage = ImageStorage(root, ImageProcessor());
    connect();
    final file = File('${root.path}/label.jpg');
    await file.writeAsBytes(coffeeLabelFixture());
    final image = await storage.stage(file.path, dbId(1), 'gallery');
    await storage.writeJson('drafts/${dbId(1)}/image.json', image.toJson());
    await db
        .into(db.coffeeDrafts)
        .insert(
          CoffeeDraftsCompanion.insert(
            id: dbId(1),
            draftType: 'scan_create',
            status: 'review_required',
            ocrRawText: const Value(
              'Name: Gayo\nRoastery: Nusantara\nWeight: 250g\nVariety: Bourbon, Typica',
            ),
            ocrLinesJson: Value(jsonEncode([])),
            temporaryImagePath: Value(image.localPath),
            imageMimeType: const Value('image/jpeg'),
            createdAt: dbTime.microsecondsSinceEpoch,
            updatedAt: dbTime.microsecondsSinceEpoch,
          ),
        );
  });
  tearDown(() async {
    await db.close();
    await root.delete(recursive: true);
  });
  Future<CoffeeDraft> open() async =>
      (await repository.open(dbId(1)) as Ok<CoffeeDraft>).value;
  test(
    'candidate selection from existing raw OCR survives database reconnect',
    () async {
      await (db.update(
        db.coffeeDrafts,
      )..where((t) => t.id.equals(dbId(1)))).write(
        const CoffeeDraftsCompanion(
          ocrRawText: Value('Name: Gayo\nName: Guji\nRoastery: Nusantara'),
        ),
      );
      final draft = await open();
      expect(draft.values[CoffeeField.name], isEmpty);
      final choice = const CoffeeLabelParser()
          .choices(draft.text, 'name')
          .firstWhere((c) => c.value == 'Guji');
      final result = await repository.save(
        draft.id,
        draft.revision,
        draft.values.set(CoffeeField.name, choice.value),
        false,
      );
      expect(result, isA<Ok<CoffeeDraft>>());
      await db.close();
      connect();
      final restored = await open();
      expect(restored.values[CoffeeField.name], 'Guji');
      expect(restored.sourceFor('name'), DraftValueSource.user);
      expect(restored.text.text, contains('Name: Gayo'));
      expect(
        const CoffeeLabelParser()
            .choices(restored.text, 'name')
            .map((c) => c.value),
        ['Gayo', 'Guji'],
      );
      expect(await db.select(db.coffees).get(), isEmpty);
    },
  );
  test(
    'opening parses once; incomplete edits and source survive reopen',
    () async {
      final draft = await open();
      expect(draft.values[CoffeeField.packageWeightGrams], '250');
      expect(await db.select(db.coffees).get(), isEmpty);
      final edit = draft.values
          .set(CoffeeField.name, 'Kopi pilihan')
          .set(CoffeeField.roastDate, '2026-0');
      final saved = await repository.save(
        draft.id,
        draft.revision,
        edit,
        false,
      ) as Ok<CoffeeDraft>;
      expect(saved.value.sourceFor('name'), DraftValueSource.user);
      await db.close();
      connect();
      final restored = await open();
      expect(restored.values[CoffeeField.name], 'Kopi pilihan');
      expect(restored.values[CoffeeField.roastDate], '2026-0');
      expect(restored.includePhoto, isFalse);
      expect(restored.fields.first.rawValue, contains('Gayo'));
      expect(
        await repository.promote(restored.id, restored.revision),
        isA<Err<Coffee>>(),
      );
      expect(await db.select(db.coffees).get(), isEmpty);
    },
  );
  test('promotion atomically saves aggregate and photo, removes raw draft; repeated save is rejected', () async {
    final draft = await open();
    final result =
        await repository.promote(draft.id, draft.revision) as Ok<Coffee>;
    expect(result.value.details.name, 'Gayo');
    expect(await db.select(db.coffees).get(), hasLength(1));
    expect(await db.select(db.coffeeVarieties).get(), hasLength(2));
    final photo = await db.select(db.coffeePhotos).getSingle();
    expect(await storage.file(photo.localPath).exists(), isTrue);
    expect(await db.select(db.coffeeDrafts).get(), isEmpty);
    expect(await db.select(db.scanExtractedFields).get(), isEmpty);
    expect(
      await repository.promote(draft.id, draft.revision),
      isA<Err<Coffee>>(),
    );
    expect(await db.select(db.coffees).get(), hasLength(1));
  });
  test(
    'database failure rolls back aggregate, keeps draft and staged image',
    () async {
      final draft = await open();
      await db.customStatement(
        "CREATE TRIGGER qa_reject_photo BEFORE INSERT ON coffee_photos BEGIN SELECT RAISE(ABORT, 'fixture failure'); END",
      );
      expect(
        await repository.promote(draft.id, draft.revision),
        isA<Err<Coffee>>(),
      );
      expect(await db.select(db.coffees).get(), isEmpty);
      expect(await db.select(db.coffeeVarieties).get(), isEmpty);
      expect(await db.select(db.coffeeDrafts).get(), hasLength(1));
      expect(await storage.file(draft.image!.localPath).exists(), isTrue);
      await db.customStatement('DROP TRIGGER qa_reject_photo');
      expect(
        await repository.promote(draft.id, draft.revision),
        isA<Ok<Coffee>>(),
      );
    },
  );
  test(
    'stale edits/promotion rejected, missing photo allows explicit opt-out',
    () async {
      final draft = await open();
      final newer = (await repository.save(
        draft.id,
        draft.revision,
        draft.values.set(CoffeeField.name, 'Edited'),
        true,
      ) as Ok<CoffeeDraft>).value;
      expect(
        await repository.save(draft.id, draft.revision, draft.values, false),
        isA<Err<CoffeeDraft>>(),
      );
      expect(
        await repository.promote(draft.id, draft.revision),
        isA<Err<Coffee>>(),
      );
      await storage.deleteWithThumbnail(draft.image!.localPath);
      expect(
        await repository.promote(draft.id, newer.revision),
        isA<Err<Coffee>>(),
      );
      final withoutPhoto = (await repository.save(
        draft.id,
        newer.revision,
        newer.values,
        false,
      ) as Ok<CoffeeDraft>).value;
      expect(
        await repository.promote(draft.id, withoutPhoto.revision),
        isA<Ok<Coffee>>(),
      );
      expect(await db.select(db.coffeePhotos).get(), isEmpty);
    },
  );
  test('reviewed draft cannot be overwritten by OCR retry/cancel', () async {
    final draft = await open();
    final scan = ScanDraftStore(db, storage, clock);
    await expectLater(scan.begin(draft.id), throwsA(isA<ConflictFailure>()));
    await scan.cancel(draft.id);
    expect((await open()).values, draft.values);
  });
}
