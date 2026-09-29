import 'package:drift/drift.dart';

import '../app_database.dart';

/// One consistent snapshot; rows never escape the feature's data layer.
final class CoffeeRows {
  const CoffeeRows(this.coffee, this.varieties, this.notes, this.photos);
  final CoffeeRecord coffee;
  final List<CoffeeVarietyRecord> varieties;
  final List<CoffeeTastingNoteRecord> notes;
  final List<CoffeePhotoRecord> photos;
}

final class CoffeeDao {
  CoffeeDao(this.database);
  final AppDatabase database;

  Stream<List<CoffeeRows>> watch({String? id}) => database
      .customSelect(
        'SELECT id FROM coffees',
        readsFrom: {
          database.coffees,
          database.coffeeVarieties,
          database.coffeeTastingNotes,
          database.coffeePhotos,
        },
      )
      .watch()
      .asyncMap((_) => read(id: id));

  Future<List<CoffeeRows>> read({String? id}) => database.transaction(() async {
    final query = database.select(database.coffees)
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
        (t) => OrderingTerm.asc(t.id),
      ]);
    if (id != null) query.where((t) => t.id.equals(id));
    final coffees = await query.get();
    if (coffees.isEmpty) return [];
    final ids = coffees.map((c) => c.id).toList();
    final varieties =
        await (database.select(database.coffeeVarieties)
              ..where((t) => t.coffeeId.isIn(ids))
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final notes =
        await (database.select(database.coffeeTastingNotes)
              ..where((t) => t.coffeeId.isIn(ids))
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final photos =
        await (database.select(database.coffeePhotos)
              ..where((t) => t.coffeeId.isIn(ids))
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    return [
      for (final c in coffees)
        CoffeeRows(
          c,
          varieties.where((r) => r.coffeeId == c.id).toList(),
          notes.where((r) => r.coffeeId == c.id).toList(),
          photos.where((r) => r.coffeeId == c.id).toList(),
        ),
    ];
  });

  Future<void> write({
    required CoffeesCompanion coffee,
    required List<CoffeeVarietiesCompanion> varieties,
    required List<CoffeeTastingNotesCompanion> notes,
    required bool insert,
  }) => database.transaction(() async {
    if (insert) {
      await database.into(database.coffees).insert(coffee);
    } else {
      await (database.update(
        database.coffees,
      )..where((t) => t.id.equals(coffee.id.value))).write(coffee);
    }
    await (database.delete(
      database.coffeeVarieties,
    )..where((t) => t.coffeeId.equals(coffee.id.value))).go();
    await (database.delete(
      database.coffeeTastingNotes,
    )..where((t) => t.coffeeId.equals(coffee.id.value))).go();
    await database.batch((batch) {
      batch.insertAll(database.coffeeVarieties, varieties);
      batch.insertAll(database.coffeeTastingNotes, notes);
    });
  });

  Future<int> delete(String id) =>
      (database.delete(database.coffees)..where((t) => t.id.equals(id))).go();
}
