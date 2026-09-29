import 'package:drift/drift.dart';

import '../app_database.dart';

final class JournalDao {
  JournalDao(this.database);
  final AppDatabase database;

  Future<int> countForCoffee(String id) async {
    final count = database.journalEntries.id.count();
    final row =
        await (database.selectOnly(database.journalEntries)
              ..addColumns([count])
              ..where(database.journalEntries.coffeeId.equals(id)))
            .getSingle();
    return row.read(count)!;
  }

  Future<List<JournalRecord>> forCoffee(String id) =>
      (database.select(database.journalEntries)
            ..where((t) => t.coffeeId.equals(id))
            ..orderBy([
              (t) => OrderingTerm.desc(t.brewedAt),
              (t) => OrderingTerm.asc(t.id),
            ]))
          .get();

  Future<void> save(
    JournalEntriesCompanion entry,
    List<JournalTastingNotesCompanion> notes,
  ) => database.transaction(() async {
    await database.into(database.journalEntries).insertOnConflictUpdate(entry);
    await (database.delete(
      database.journalTastingNotes,
    )..where((t) => t.journalEntryId.equals(entry.id.value))).go();
    await database.batch(
      (batch) => batch.insertAll(database.journalTastingNotes, notes),
    );
  });

  Future<int> delete(String id) => (database.delete(
    database.journalEntries,
  )..where((t) => t.id.equals(id))).go();
}
