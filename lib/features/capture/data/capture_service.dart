import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:drift/drift.dart';

import '../domain/photo_picker_gateway.dart';
import '../domain/recovered_capture.dart';

/// One native picker operation at a time. A durable draft owns both its image
/// and a lossless form checkpoint until save/discard. No automatic Coffee write.
class CaptureService {
  CaptureService(this.db, this.storage, this.picker, this.ids, this.clock);
  final AppDatabase db;
  final ImageStorage storage;
  final PhotoPickerGateway picker;
  final AppIdGenerator ids;
  final AppClock clock;
  bool _busy = false;
  static const pendingPath = 'maintenance/pending-picker.json';

  AppFailure _failure(Object error) =>
      error is AppFailure ? error : StorageFailure(cause: error);

  Future<Result<ManagedImage?>> acquire(
    PhotoSource source, {
    required String? targetCoffeeId,
    required Map<String, Object?> context,
    bool forScan = false,
  }) async {
    if (_busy) return const Err(ConflictFailure());
    _busy = true;
    final id = ids.generate();
    try {
      final now = clock.now().toUtc().microsecondsSinceEpoch;
      await storage.writeJson('drafts/$id/context.json', context);
      await db
          .into(db.coffeeDrafts)
          .insert(
            CoffeeDraftsCompanion.insert(
              id: id,
              draftType: targetCoffeeId == null
                  ? (forScan ? 'scan_create' : 'manual_create')
                  : 'edit_existing',
              status: 'editing',
              targetCoffeeId: Value(targetCoffeeId),
              temporaryImagePath: Value('drafts/$id/cover.jpg'),
              imageMimeType: const Value('image/jpeg'),
              failureCategory: const Value('photo_session'),
              createdAt: now,
              updatedAt: now,
            ),
          );
      await storage.writeJson(pendingPath, {'id': id, 'source': source.name});
      final result = await picker.pick(source);
      if (result case Err<String?>(:final failure)) {
        await discard(id);
        return Err(failure);
      }
      final path = (result as Ok<String?>).value;
      if (path == null) {
        await discard(id);
        return const Ok(null);
      }
      final image = await _stage(path, id, source.name);
      await storage.delete(pendingPath);
      return Ok(image);
    } catch (error) {
      // Retain complete staging for recovery, but do not leak failed sessions.
      try {
        if (await storage.readJson('drafts/$id/image.json') == null) {
          await discard(id);
        }
      } catch (_) {
        /* Startup recovery retries failed-session cleanup. */
      }
      return Err(_failure(error));
    } finally {
      _busy = false;
    }
  }

  Future<ManagedImage> _stage(String path, String id, String source) async {
    final image = await storage.stage(path, id, source);
    await storage.writeJson('drafts/$id/image.json', image.toJson());
    await (db.update(db.coffeeDrafts)..where((t) => t.id.equals(id))).write(
      CoffeeDraftsCompanion(
        status: const Value('image_ready'),
        updatedAt: Value(clock.now().toUtc().microsecondsSinceEpoch),
      ),
    );
    return image;
  }

  Future<Result<List<RecoveredCapture>>> recover() async {
    if (_busy) return const Ok([]);
    _busy = true;
    try {
      final pending = await storage.readJson(pendingPath);
      final lost = await picker.recover();
      if (lost case Ok<String?>(value: final path?)) {
        if (pending != null) {
          final id = pending['id'] as String;
          final draft = await (db.select(
            db.coffeeDrafts,
          )..where((t) => t.id.equals(id))).getSingleOrNull();
          if (draft != null) {
            await _stage(path, id, pending['source'] as String);
          }
          // Without an exact draft association, never attach the result.
        }
      }
      if (lost is Err<String?> && pending != null) {
        return Err(lost.failure);
      }
      if (pending != null) {
        final id = pending['id'] as String;
        if (!await storage.file('drafts/$id/cover.jpg').exists()) {
          await discard(id);
        }
      }
      await storage.delete(pendingPath);
      final drafts =
          await (db.select(db.coffeeDrafts)..where(
                (t) =>
                    t.failureCategory.equals('photo_session') &
                    t.draftType.equals('scan_create').not() &
                    (t.status.equals('image_ready') |
                        t.status.equals('editing')),
              ))
              .get();
      final recovered = <RecoveredCapture>[];
      for (final draft in drafts) {
        final json = await storage.readJson('drafts/${draft.id}/image.json');
        final context = await storage.readJson(
          'drafts/${draft.id}/context.json',
        );
        if (json == null || context == null) {
          await discard(draft.id);
          continue;
        }
        final image = ManagedImage.fromJson(json);
        if (await storage.file(image.localPath).exists()) {
          recovered.add(RecoveredCapture(image, draft.targetCoffeeId, context));
        } else {
          await discard(draft.id);
        }
      }
      return Ok(recovered);
    } catch (error) {
      return Err(_failure(error));
    } finally {
      _busy = false;
    }
  }

  Future<void> discard(String id) async {
    final path = 'drafts/$id/cover.jpg';
    await db.transaction(() async {
      await db
          .into(db.fileCleanupTasks)
          .insert(
            FileCleanupTasksCompanion.insert(
              id: id,
              localPath: path,
              createdAt: clock.now().toUtc().microsecondsSinceEpoch,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await (db.delete(db.coffeeDrafts)..where((t) => t.id.equals(id))).go();
    });
    final pending = await storage.readJson(pendingPath);
    if (pending?['id'] == id) await storage.delete(pendingPath);
    try {
      await storage.deleteWithThumbnail(path);
      await storage.delete('drafts/$id/context.json');
      await storage.delete('drafts/$id/image.json');
      await (db.delete(
        db.fileCleanupTasks,
      )..where((t) => t.id.equals(id))).go();
    } catch (_) {
      /* Queue and startup sweep retain retry responsibility. */
    }
  }
}
