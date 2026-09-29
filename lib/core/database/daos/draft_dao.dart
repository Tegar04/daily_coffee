import '../app_database.dart';

/// Persistence only. Review/transitions/promotion are Phase 7-8 workflows.
final class DraftDao {
  DraftDao(this.database);
  final AppDatabase database;

  Future<DraftRecord?> find(String id) => (database.select(
    database.coffeeDrafts,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> save(
    CoffeeDraftsCompanion draft, {
    required List<DraftVarietiesCompanion> varieties,
    required List<DraftTastingNotesCompanion> notes,
    required List<ScanExtractedFieldsCompanion> fields,
  }) => database.transaction(() async {
    await database.into(database.coffeeDrafts).insertOnConflictUpdate(draft);
    await (database.delete(
      database.draftVarieties,
    )..where((t) => t.coffeeDraftId.equals(draft.id.value))).go();
    await (database.delete(
      database.draftTastingNotes,
    )..where((t) => t.coffeeDraftId.equals(draft.id.value))).go();
    await (database.delete(
      database.scanExtractedFields,
    )..where((t) => t.coffeeDraftId.equals(draft.id.value))).go();
    await database.batch((batch) {
      batch.insertAll(database.draftVarieties, varieties);
      batch.insertAll(database.draftTastingNotes, notes);
      batch.insertAll(database.scanExtractedFields, fields);
    });
  });

  Future<int> delete(String id) => (database.delete(
    database.coffeeDrafts,
  )..where((t) => t.id.equals(id))).go();
}
