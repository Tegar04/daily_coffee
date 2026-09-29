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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      try {
        await transaction(migrator.createAll);
      } catch (error) {
        throw MigrationFailure(cause: error);
      }
    },
    onUpgrade: (migrator, from, to) async {
      if ((from == 1 || from == 2) && to == 3) {
        try {
          await transaction(() async {
            if (from < 2) {
              await migrator.addColumn(coffeeDrafts, coffeeDrafts.ocrRawText);
              await migrator.addColumn(coffeeDrafts, coffeeDrafts.ocrLinesJson);
              await migrator.addColumn(coffeeDrafts, coffeeDrafts.scanRevision);
            }
            await migrator.addColumn(coffeeDrafts, coffeeDrafts.reviewJson);
            await migrator.addColumn(coffeeDrafts, coffeeDrafts.reviewRevision);
          });
        } catch (error) {
          throw MigrationFailure(cause: error);
        }
        return;
      }
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
