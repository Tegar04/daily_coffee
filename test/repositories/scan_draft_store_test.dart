import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/database_fixtures.dart';
import '../helpers/test_doubles.dart';

void main() {
  late Directory dir;
  late AppDatabase db;
  late ScanDraftStore store;
  const result = RecognizedLabelText('Nusantara\nGayo', [
    RecognizedLine('Gayo', [1, 2, 30, 40], 0.91),
    RecognizedLine('Nusantara', [0, 0, 30, 10], null),
  ]);
  setUp(() async {
    dir = await Directory.systemTemp.createTemp('scan_store_');
    db = AppDatabase(NativeDatabase(File('${dir.path}/app.sqlite')));
    store = ScanDraftStore(
      db,
      ImageStorage(dir, ImageProcessor()),
      FixedAppClock(dbTime),
    );
    await db
        .into(db.coffeeDrafts)
        .insert(
          CoffeeDraftsCompanion.insert(
            id: dbId(1),
            draftType: 'scan_create',
            status: 'image_ready',
            temporaryImagePath: Value('drafts/${dbId(1)}/cover.jpg'),
            imageMimeType: const Value('image/jpeg'),
            createdAt: dbTime.microsecondsSinceEpoch,
            updatedAt: dbTime.microsecondsSinceEpoch,
          ),
        );
  });
  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });
  test(
    'raw OCR and nullable confidence survive database restart without Coffee',
    () async {
      final revision = await store.begin(dbId(1));
      expect(await store.finish(dbId(1), revision, result: result), isTrue);
      await db.close();
      db = AppDatabase(NativeDatabase(File('${dir.path}/app.sqlite')));
      store = ScanDraftStore(
        db,
        ImageStorage(dir, ImageProcessor()),
        FixedAppClock(dbTime),
      );
      final restored = (await store.load()).single;
      expect(restored.result!.text, result.text);
      expect(restored.result!.lines.first.confidence, 0.91);
      expect(restored.result!.lines.last.confidence, isNull);
      expect(await db.select(db.coffees).get(), isEmpty);
      expect(
        (await db.select(db.coffeeDrafts).getSingle()).status,
        'review_required',
      );
    },
  );
  test(
    'cancel rejects late results and retry rejects earlier operation',
    () async {
      final old = await store.begin(dbId(1));
      await store.cancel(dbId(1));
      expect(await store.finish(dbId(1), old, result: result), isFalse);
      final next = await store.begin(dbId(1));
      expect(await store.finish(dbId(1), old, result: result), isFalse);
      expect(await store.finish(dbId(1), next, result: result), isTrue);
    },
  );
  test('failure retains draft image and retry can succeed', () async {
    final revision = await store.begin(dbId(1));
    await store.finish(dbId(1), revision, failure: const OcrNoTextFailure());
    final row = await db.select(db.coffeeDrafts).getSingle();
    expect(row.failureCategory, 'ocr_no_text');
    expect(row.temporaryImagePath, isNotNull);
    final next = await store.begin(dbId(1));
    expect(await store.finish(dbId(1), next, result: result), isTrue);
  });
}
