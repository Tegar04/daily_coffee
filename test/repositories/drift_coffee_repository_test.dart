import 'dart:async';
import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';
import '../helpers/database_fixtures.dart';
import '../helpers/test_doubles.dart';

void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('full aggregate roundtrip preserves dates, metadata, identity and normalization', () async {
    final repo = localRepository(db);
    final input = coffeeInput()
        .set(CoffeeField.originCountry, 'Indonesia')
        .set(CoffeeField.roastDate, '2026-09-01')
        .set(CoffeeField.purchaseDate, '2026-09-02')
        .set(CoffeeField.roastLevelKey, 'other')
        .set(CoffeeField.roastLevelCustom, 'Omni')
        .set(CoffeeField.altitudeMinMeters, '1500')
        .set(CoffeeField.altitudeMaxMeters, '1800')
        .set(CoffeeField.packageWeightGrams, '200')
        .set(CoffeeField.personalNote, 'Catatan')
        .set(CoffeeField.region, 'Aceh')
        .set(CoffeeField.producer, 'Farm')
        .set(CoffeeField.process, 'Natural')
        .withTags(
          varieties: ['Gesha', 'gesha', 'Bourbon'],
          tastingNotes: ['Cafe\u0301'],
        );
    final created = (await repo.create(input) as Ok<Coffee>).value;
    await db.into(db.coffeePhotos).insert(photoRow(99, created.id.value));
    await (db.update(
      db.coffees,
    )..where((t) => t.id.equals(created.id.value))).write(
      const CoffeesCompanion(
        originCountryCode: Value('ID'),
        altitudeSourceText: Value('1500-1800 masl'),
      ),
    );
    final loaded =
        (await repo.watchCoffee(created.id).first as Ok<Coffee?>).value!;
    expect(loaded.toFormValues(), created.toFormValues());
    expect(loaded.createdAt, dbTime);
    expect(loaded.createdAt.isUtc, isTrue);
    expect(loaded.varieties, hasLength(2));
    expect(loaded.tastingNotes.single.normalizedValue, 'café');
    expect(loaded.photos.single.localPath, 'coffee/99.jpg');
    await repo.setFavorite(created.id, true);
    final edited = (await repo.update(
      created.id,
      loaded.toFormValues().set(CoffeeField.name, 'Updated'),
      expected: loaded.toFormValues(),
    ) as Ok<Coffee>).value;
    expect(edited.isFavorite, isTrue);
    expect(edited.varieties.first.id, loaded.varieties.first.id);
    expect(edited.originCountryCode, 'ID');
    expect(edited.altitudeSourceText, '1500-1800 masl');
    expect(
      (await repo.update(
        created.id,
        input,
        expected: loaded.toFormValues(),
      ) as Err<Coffee>).failure,
      isA<ConflictFailure>(),
    );
    final row = await db.select(db.coffees).getSingle();
    expect(row.nameNormalized, 'updated');
    expect(row.regionNormalized, 'aceh');
  });

  test(
    'invalid input and a child insert failure leave no partial aggregate',
    () async {
      final repo = localRepository(
        db,
        ids: SequenceAppIdGenerator([dbId(1), dbId(2), dbId(2)]),
      );
      expect(
        (await repo.create(coffeeInput(name: ' ')) as Err<Coffee>).failure,
        isA<ValidationFailure>(),
      );
      final result = await repo.create(
        coffeeInput().withTags(varieties: ['A', 'B']),
      );
      expect((result as Err<Coffee>).failure, isA<ConflictFailure>());
      expect(await db.select(db.coffees).get(), isEmpty);
      expect(await db.select(db.coffeeVarieties).get(), isEmpty);
    },
  );

  test('failed child update rolls back coffee and previous children', () async {
    final repo = localRepository(db);
    final c = (await repo.create(
      coffeeInput().withTags(varieties: ['Original']),
    ) as Ok<Coffee>).value;
    final conflicting = localRepository(
      db,
      ids: SequenceAppIdGenerator([dbId(9), dbId(9)]),
    );
    final result = await conflicting.update(
      c.id,
      c
          .toFormValues()
          .set(CoffeeField.name, 'Changed')
          .withTags(varieties: ['A', 'B']),
      expected: c.toFormValues(),
    );
    expect(result, isA<Err<Coffee>>());
    final persisted =
        (await repo.watchCoffee(c.id).first as Ok<Coffee?>).value!;
    expect(persisted.toFormValues(), c.toFormValues());
  });

  test('delete rechecks graph revision, cascades and queues photo cleanup atomically', () async {
    final repo = localRepository(db);
    final c = (await repo.create(
      coffeeInput().withTags(varieties: ['Gesha'], tastingNotes: ['Peach']),
    ) as Ok<Coffee>).value;
    await db.into(db.coffees).insert(coffeeRow(50));
    await db.into(db.journalEntries).insert(journalRow(10, c.id.value));
    await db.into(db.journalEntries).insert(journalRow(51, dbId(50)));
    await db
        .into(db.journalTastingNotes)
        .insert(
          JournalTastingNotesCompanion.insert(
            id: dbId(11),
            journalEntryId: dbId(10),
            displayValue: 'Peach',
            normalizedValue: 'peach',
            position: 0,
            createdAt: 1,
          ),
        );
    await db.into(db.coffeePhotos).insert(photoRow(12, c.id.value));
    final stale =
        (await repo.inspectDeleteImpact(c.id) as Ok<CoffeeDeleteImpact>).value;
    expect(stale.journalCount, 1);
    expect(stale.photoCount, 1);
    await (db.update(
      db.journalEntries,
    )..where((t) => t.id.equals(dbId(10)))).write(
      const JournalEntriesCompanion(
        note: Value('Changed without changing count'),
      ),
    );
    expect(
      (await repo.delete(stale) as Err<void>).failure,
      isA<ConflictFailure>(),
    );
    final impact =
        (await repo.inspectDeleteImpact(c.id) as Ok<CoffeeDeleteImpact>).value;
    expect(await repo.delete(impact), isA<Ok<void>>());
    expect(await db.select(db.coffeeVarieties).get(), isEmpty);
    expect(await db.select(db.coffeeTastingNotes).get(), isEmpty);
    expect(await db.select(db.coffeePhotos).get(), isEmpty);
    expect(await db.select(db.journalTastingNotes).get(), isEmpty);
    expect((await db.select(db.journalEntries).get()).single.id, dbId(51));
    expect(
      (await db.select(db.fileCleanupTasks).get()).single.localPath,
      'coffee/12.jpg',
    );
    expect((await repo.watchCoffee(c.id).first as Ok<Coffee?>).value, isNull);
  });

  test(
    'reactive collection observes committed child changes and delete',
    () async {
      final repo = localRepository(db);
      final updates = StreamIterator(repo.watchLibrary());
      addTearDown(updates.cancel);
      expect(await updates.moveNext(), isTrue);
      expect((updates.current as Ok<List<Coffee>>).value, isEmpty);
      final c = (await repo.create(
        coffeeInput().withTags(varieties: ['Gesha']),
      ) as Ok<Coffee>).value;
      expect(await updates.moveNext(), isTrue);
      expect(
        (updates.current as Ok<List<Coffee>>)
            .value
            .single
            .varieties
            .single
            .displayValue,
        'Gesha',
      );
      await (db.update(
        db.coffeeVarieties,
      )..where((t) => t.coffeeId.equals(c.id.value))).write(
        const CoffeeVarietiesCompanion(
          displayValue: Value('Bourbon'),
          normalizedValue: Value('bourbon'),
        ),
      );
      expect(await updates.moveNext(), isTrue);
      expect(
        (updates.current as Ok<List<Coffee>>)
            .value
            .single
            .varieties
            .single
            .displayValue,
        'Bourbon',
      );
      await repo.delete(
        (await repo.inspectDeleteImpact(c.id) as Ok<CoffeeDeleteImpact>).value,
      );
      expect(await updates.moveNext(), isTrue);
      expect((updates.current as Ok<List<Coffee>>).value, isEmpty);
    },
  );

  test('disk reopen preserves create edit favorite and deletion', () async {
    await db.close();
    final dir = await Directory.systemTemp.createTemp(
      'daily_coffee_persistence_',
    );
    final file = File('${dir.path}/coffee.sqlite');
    AppDatabase? disk;
    try {
      disk = AppDatabase(NativeDatabase(file));
      var repo = localRepository(disk);
      final c = (await repo.create(
        coffeeInput().withTags(tastingNotes: ['Peach']),
      ) as Ok<Coffee>).value;
      await disk.close();
      disk = AppDatabase(NativeDatabase(file));
      repo = localRepository(disk);
      final loaded = (await repo.watchCoffee(c.id).first as Ok<Coffee?>).value!;
      expect(loaded.toFormValues(), c.toFormValues());
      await repo.setFavorite(c.id, true);
      await repo.update(
        c.id,
        loaded.toFormValues().set(CoffeeField.name, 'After restart'),
        expected: loaded.toFormValues(),
      );
      await disk.close();
      disk = AppDatabase(NativeDatabase(file));
      repo = localRepository(disk);
      final edited = (await repo.watchCoffee(c.id).first as Ok<Coffee?>).value!;
      expect(edited.details.name, 'After restart');
      expect(edited.isFavorite, isTrue);
      await repo.delete(
        (await repo.inspectDeleteImpact(c.id) as Ok<CoffeeDeleteImpact>).value,
      );
      await disk.close();
      disk = AppDatabase(NativeDatabase(file));
      expect(
        (await localRepository(disk).watchLibrary().first as Ok<List<Coffee>>)
            .value,
        isEmpty,
      );
    } finally {
      await disk?.close();
      await dir.delete(recursive: true);
    }
  });

  test(
    'failed deletion rolls back cleanup queue and the entire graph',
    () async {
      final repo = localRepository(db);
      final c = (await repo.create(coffeeInput()) as Ok<Coffee>).value;
      await db.into(db.coffeePhotos).insert(photoRow(10, c.id.value));
      await db.customStatement(
        "CREATE TRIGGER reject_delete BEFORE DELETE ON coffees BEGIN SELECT RAISE(ABORT, 'fixture failure'); END",
      );
      final impact = (await repo.inspectDeleteImpact(
        c.id,
      ) as Ok<CoffeeDeleteImpact>).value;
      expect(
        (await repo.delete(impact) as Err<void>).failure,
        isA<StorageFailure>(),
      );
      expect(await db.select(db.coffees).get(), hasLength(1));
      expect(await db.select(db.coffeePhotos).get(), hasLength(1));
      expect(await db.select(db.fileCleanupTasks).get(), isEmpty);
    },
  );

  test(
    'delete cascades edit drafts and preserves their pending file cleanup',
    () async {
      final repo = localRepository(db);
      final c = (await repo.create(coffeeInput()) as Ok<Coffee>).value;
      await db
          .into(db.coffeeDrafts)
          .insert(
            draftRow(10).copyWith(
              draftType: const Value('edit_existing'),
              targetCoffeeId: Value(c.id.value),
              temporaryImagePath: const Value('temporary/edit.jpg'),
              imageMimeType: const Value('image/jpeg'),
            ),
          );
      final impact = (await repo.inspectDeleteImpact(
        c.id,
      ) as Ok<CoffeeDeleteImpact>).value;
      expect(await repo.delete(impact), isA<Ok<void>>());
      expect(await db.select(db.coffeeDrafts).get(), isEmpty);
      expect(
        (await db.select(db.fileCleanupTasks).get()).single.localPath,
        'temporary/edit.jpg',
      );
    },
  );
}
