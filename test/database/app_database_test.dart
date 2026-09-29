import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/database/daos/draft_dao.dart';
import 'package:daily_coffee/core/database/daos/journal_dao.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/database_fixtures.dart';

void main() {
  late AppDatabase db;
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await db.initialize();
  });
  tearDown(() => db.close());

  test('fresh schema enables foreign keys and indexes', () async {
    expect(
      (await db.customSelect('PRAGMA foreign_keys').getSingle()).read<int>(
        'foreign_keys',
      ),
      1,
    );
    expect(
      (await db.customSelect('PRAGMA user_version').getSingle()).read<int>(
        'user_version',
      ),
      3,
    );
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
    expect(
      await db
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'index' AND name = 'journal_entries_query_0'",
          )
          .get(),
      hasLength(1),
    );
  });

  test(
    'coffee constraints reject invalid permanent values at database boundary',
    () async {
      final base = coffeeRow(1);
      final invalid = [
        base.copyWith(id: const Value('not-a-uuid')),
        base.copyWith(name: const Value(' ')),
        base.copyWith(roastery: const Value(' ')),
        base.copyWith(packageWeightGrams: const Value(0)),
        base.copyWith(
          altitudeMinMeters: const Value(2000),
          altitudeMaxMeters: const Value(1000),
        ),
        base.copyWith(roastLevelKey: const Value('other')),
        base.copyWith(
          roastLevelKey: const Value('light'),
          roastLevelCustom: const Value('custom'),
        ),
        base.copyWith(roastLevelKey: const Value('invalid')),
        base.copyWith(roastDate: const Value('2026-02-30')),
        base.copyWith(purchaseDate: const Value('not-a-date')),
        base.copyWith(originCountryCode: const Value('id')),
        base.copyWith(updatedAt: const Value(0)),
      ];
      for (final row in invalid) {
        await expectLater(
          db.into(db.coffees).insert(row),
          throwsA(isA<SqliteException>()),
        );
      }
      await db
          .into(db.coffees)
          .insert(base.copyWith(roastDate: const Value('2024-02-29')));
    },
  );

  test(
    'orphan children, duplicate normalized tags and positions are rejected',
    () async {
      final tag = CoffeeVarietiesCompanion.insert(
        id: dbId(2),
        coffeeId: dbId(1),
        displayValue: 'Gesha',
        normalizedValue: 'gesha',
        position: 0,
        createdAt: 1,
      );
      await expectLater(
        db.into(db.coffeeVarieties).insert(tag),
        throwsA(isA<SqliteException>()),
      );
      await db.into(db.coffees).insert(coffeeRow(1));
      await db.into(db.coffeeVarieties).insert(tag);
      await expectLater(
        db
            .into(db.coffeeVarieties)
            .insert(tag.copyWith(id: Value(dbId(3)), position: const Value(1))),
        throwsA(isA<SqliteException>()),
      );
      await expectLater(
        db
            .into(db.coffeeVarieties)
            .insert(
              tag.copyWith(
                id: Value(dbId(3)),
                normalizedValue: const Value('bourbon'),
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    },
  );

  test('photos enforce one cover and managed paths', () async {
    await db.into(db.coffees).insert(coffeeRow(1));
    for (final path in [
      '../escape.jpg',
      '/outside.jpg',
      'C:/file.jpg',
      'a\\b.jpg',
      'a//b.jpg',
      'a/./b.jpg',
      'a/',
    ]) {
      await expectLater(
        db
            .into(db.coffeePhotos)
            .insert(photoRow(2, dbId(1)).copyWith(localPath: Value(path))),
        throwsA(isA<SqliteException>()),
      );
    }
    await db.into(db.coffeePhotos).insert(photoRow(2, dbId(1)));
    await expectLater(
      db.into(db.coffeePhotos).insert(photoRow(3, dbId(1))),
      throwsA(isA<SqliteException>()),
    );
  });

  test(
    'journal quantities, rating, method and parent are constrained',
    () async {
      final base = journalRow(2, dbId(1));
      await expectLater(
        db.into(db.journalEntries).insert(base),
        throwsA(isA<SqliteException>()),
      );
      await db.into(db.coffees).insert(coffeeRow(1));
      for (final row in [
        base.copyWith(rating: const Value(6)),
        base.copyWith(doseMilligrams: const Value(0)),
        base.copyWith(brewMethodKey: const Value('other')),
        base.copyWith(brewedAtOffsetMinutes: const Value(900)),
      ]) {
        await expectLater(
          db.into(db.journalEntries).insert(row),
          throwsA(isA<SqliteException>()),
        );
      }
      await JournalDao(db).save(base, [
        JournalTastingNotesCompanion.insert(
          id: dbId(3),
          journalEntryId: dbId(2),
          displayValue: 'Peach',
          normalizedValue: 'peach',
          position: 0,
          createdAt: 1,
        ),
      ]);
      expect(await JournalDao(db).countForCoffee(dbId(1)), 1);
      expect(
        (await JournalDao(db).forCoffee(dbId(1))).single.brewedAtOffsetMinutes,
        420,
      );
      await JournalDao(db).delete(dbId(2));
      expect(await db.select(db.journalTastingNotes).get(), isEmpty);
      expect(await db.select(db.coffees).get(), hasLength(1));
    },
  );

  test(
    'drafts persist incomplete values separately and cascade owned rows',
    () async {
      final dao = DraftDao(db);
      final variety = DraftVarietiesCompanion.insert(
        id: dbId(2),
        coffeeDraftId: dbId(1),
        displayValue: 'Gesha',
        normalizedValue: 'gesha',
        position: 0,
        source: 'ocr',
      );
      final field = ScanExtractedFieldsCompanion.insert(
        id: dbId(3),
        coffeeDraftId: dbId(1),
        fieldKey: 'name',
        reviewStatus: 'needs_review',
        confidenceBasisPoints: const Value(5000),
        createdAt: 1,
        updatedAt: 1,
      );
      await dao.save(
        draftRow(1).copyWith(packageWeightGrams: const Value(-1)),
        varieties: [variety],
        notes: [],
        fields: [field],
      );
      expect((await dao.find(dbId(1)))?.name, isNull);
      expect(await db.select(db.coffees).get(), isEmpty);
      await expectLater(
        dao.save(
          draftRow(1).copyWith(name: const Value('Changed')),
          varieties: [],
          notes: [],
          fields: [field.copyWith(confidenceBasisPoints: const Value(10001))],
        ),
        throwsA(isA<SqliteException>()),
      );
      expect((await dao.find(dbId(1)))?.name, isNull);
      expect(await db.select(db.draftVarieties).get(), hasLength(1));
      await dao.delete(dbId(1));
      expect(await db.select(db.draftVarieties).get(), isEmpty);
      expect(await db.select(db.scanExtractedFields).get(), isEmpty);
    },
  );
}
