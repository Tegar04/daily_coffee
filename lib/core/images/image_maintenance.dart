import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:path/path.dart' as p;

import 'image_storage.dart';

class ImageMaintenance {
  ImageMaintenance(this.db, this.storage);
  final AppDatabase db;
  final ImageStorage storage;
  Future<bool> referenced(String path) async {
    final photos = await (db.select(
      db.coffeePhotos,
    )..where((t) => t.localPath.equals(path))).get();
    final drafts = await (db.select(
      db.coffeeDrafts,
    )..where((t) => t.temporaryImagePath.equals(path))).get();
    return photos.isNotEmpty || drafts.isNotEmpty;
  }

  /// Retain failed tasks. Checking references and deleting are serialized with
  /// database writes, so another transaction cannot acquire this path midway.
  Future<void> runQueue() async {
    final tasks = await db.select(db.fileCleanupTasks).get();
    for (final task in tasks) {
      try {
        await db.transaction(() async {
          if (await referenced(task.localPath)) return;
          await storage.deleteWithThumbnail(task.localPath);
          await (db.delete(
            db.fileCleanupTasks,
          )..where((t) => t.id.equals(task.id))).go();
        });
      } catch (_) {
        /* A later maintenance pass retries this durable task. */
      }
    }
  }

  /// Startup-only scan, before new captures/writes. Age is never sufficient:
  /// keep every referenced bundle, including draft context and thumbnail.
  Future<void> sweep(DateTime now) async {
    final references = <String>{
      ...(await db.select(db.coffeePhotos).get()).map((r) => r.localPath),
      ...(await db.select(db.coffeeDrafts).get())
          .map((r) => r.temporaryImagePath)
          .whereType<String>(),
    };
    for (final name in ['photos', 'drafts']) {
      final directory = Directory(p.join(storage.root.path, name));
      if (!await directory.exists()) continue;
      await for (final entry in directory.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entry is! File) continue;
        final relative = p
            .relative(entry.path, from: storage.root.path)
            .replaceAll('\\', '/');
        final owned = references.any(
          (r) =>
              relative == r ||
              relative == '$r.thumb.jpg' ||
              (name == 'drafts' &&
                  p.posix.dirname(relative) == p.posix.dirname(r)),
        );
        if (!owned &&
            now.difference((await entry.stat()).modified) >
                const Duration(days: 1)) {
          await storage.delete(relative);
        }
      }
    }
  }
}
