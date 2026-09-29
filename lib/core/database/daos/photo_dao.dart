import 'package:drift/drift.dart';

import '../app_database.dart';

final class PhotoDao {
  PhotoDao(this.database);
  final AppDatabase database;

  Future<List<CoffeePhotoRecord>> forCoffee(String id) => (database.select(
    database.coffeePhotos,
  )..where((t) => t.coffeeId.equals(id))).get();

  /// Durable work survives a crash between relational deletion and file cleanup.
  /// Phase 6 owns executing and acknowledging these tasks.
  Future<void> queueCleanup(List<CoffeePhotoRecord> photos, int now) async {
    await database.batch((batch) {
      for (final photo in photos) {
        batch.insert(
          database.fileCleanupTasks,
          FileCleanupTasksCompanion.insert(
            id: photo.id,
            localPath: photo.localPath,
            createdAt: now,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  /// Edit drafts are owned by their target coffee and cascade with it.
  Future<void> queueEditDraftCleanup(String coffeeId, int now) async {
    final drafts = await (database.select(
      database.coffeeDrafts,
    )..where((t) => t.targetCoffeeId.equals(coffeeId))).get();
    await database.batch((batch) {
      for (final draft in drafts) {
        if (draft.temporaryImagePath != null) {
          batch.insert(
            database.fileCleanupTasks,
            FileCleanupTasksCompanion.insert(
              id: draft.id,
              localPath: draft.temporaryImagePath!,
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }
      }
    });
  }
}
