import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:drift/drift.dart';

import 'tables/app_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Coffees,
    CoffeeVarieties,
    CoffeeTastingNotes,
    CoffeePhotos,
    JournalEntries,
    JournalTastingNotes,
    CoffeeDrafts,
    DraftVarieties,
    DraftTastingNotes,
    ScanExtractedFields,
    FileCleanupTasks,
  ],
  include: {'schema.drift'},
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      try {
        await transaction(migrator.createAll);
      } catch (error) {
        throw MigrationFailure(cause: error);
      }
    },
    // v1 is the first persisted schema. Never reset an unknown/newer database.
    onUpgrade: (migrator, from, to) async {
      throw MigrationFailure(diagnosticContext: {'from': from, 'to': to});
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> initialize() async {
    try {
      await customSelect('SELECT 1').get();
    } on AppFailure {
      rethrow;
    } catch (error) {
      throw StorageFailure(cause: error);
    }
  }
}
