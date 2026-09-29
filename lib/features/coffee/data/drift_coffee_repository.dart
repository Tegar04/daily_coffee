import 'dart:async';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/database/daos/coffee_dao.dart';
import 'package:daily_coffee/core/database/daos/journal_dao.dart';
import 'package:daily_coffee/core/database/daos/photo_dao.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/images/image_maintenance.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_photo_edit.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import 'coffee_aggregate_builder.dart';
import 'coffee_mapper.dart';

final class DriftCoffeeRepository implements CoffeeRepository {
  DriftCoffeeRepository({
    required AppDatabase database,
    required AppClock clock,
    required AppIdGenerator ids,
    this._imageStorage,
  }) : _db = database,
       _clock = clock,
       _ids = ids,
       _coffee = CoffeeDao(database),
       _journal = JournalDao(database),
       _photo = PhotoDao(database),
       _builder = CoffeeAggregateBuilder(clock: clock, ids: ids);
  final AppDatabase _db;
  final AppClock _clock;
  final Future<ImageStorage> Function()? _imageStorage;
  final AppIdGenerator _ids;
  final CoffeeDao _coffee;
  final JournalDao _journal;
  final PhotoDao _photo;
  final CoffeeAggregateBuilder _builder;

  AppFailure _failure(Object error) {
    if (error is AppFailure) return error;
    if (error is SqliteException &&
        [1555, 2067].contains(error.extendedResultCode)) {
      return ConflictFailure(cause: error);
    }
    return StorageFailure(cause: error);
  }

  Future<Result<T>> _command<T>(Future<T> Function() action) async {
    try {
      return Ok(await _db.transaction(action));
    } catch (error) {
      return Err(_failure(error));
    }
  }

  Stream<Result<T>> _watch<T>(String? id, T Function(List<CoffeeRows>) map) =>
      _coffee
          .watch(id: id)
          .transform(
            StreamTransformer.fromHandlers(
              handleData: (rows, sink) {
                try {
                  sink.add(Ok(map(rows)));
                } catch (error) {
                  sink.add(Err(_failure(error)));
                }
              },
              handleError: (Object error, StackTrace stack, sink) =>
                  sink.add(Err(_failure(error))),
            ),
          );

  @override
  Stream<Result<List<Coffee>>> watchLibrary() => _watch(
    null,
    (rows) => List.unmodifiable(rows.map(CoffeeMapper.fromRows)),
  );
  @override
  Stream<Result<Coffee?>> watchCoffee(CoffeeId id) => _watch(
    id.value,
    (rows) => rows.isEmpty ? null : CoffeeMapper.fromRows(rows.single),
  );

  void _validate(CoffeeFormValues input) {
    if (CoffeeValidation.validate(input).isNotEmpty ||
        CoffeeValidation.validateTags(input.varieties) != null ||
        CoffeeValidation.validateTags(input.tastingNotes) != null) {
      throw const ValidationFailure();
    }
  }

  Future<CoffeeRows> _find(CoffeeId id) async {
    final rows = await _coffee.read(id: id.value);
    if (rows.isEmpty) throw const NotFoundFailure();
    return rows.single;
  }

  Future<Coffee> _write(Coffee value, {bool insert = false}) async {
    await _coffee.write(
      coffee: CoffeeMapper.toRow(value),
      varieties: CoffeeMapper.varieties(value),
      notes: CoffeeMapper.notes(value),
      insert: insert,
    );
    return value;
  }

  @override
  Future<Result<Coffee>> create(
    CoffeeFormValues input, {
    CoffeePhotoEdit? photo,
  }) async {
    try {
      _validate(input);
      return await _savePhoto(CoffeeId(_ids.generate()), photo, (id) async {
        return _write(_builder.build(id, input), insert: true);
      });
    } catch (error) {
      return Err(_failure(error));
    }
  }

  @override
  Future<Result<Coffee>> update(
    CoffeeId id,
    CoffeeFormValues input, {
    required CoffeeFormValues expected,
    CoffeePhotoEdit? photo,
  }) => _savePhoto(id, photo, (_) async {
    _validate(input);
    final previous = CoffeeMapper.fromRows(await _find(id));
    if (previous.toFormValues() != expected) throw const ConflictFailure();
    return _write(_builder.build(id, input, previous: previous));
  });

  /// Explicit reviewed-draft promotion. The revision check, Coffee aggregate,
  /// photo metadata, cleanup queue and draft deletion share one transaction.
  Future<Result<Coffee>> createFromDraft(
    CoffeeFormValues input, {
    required String draftId,
    required int expectedRevision,
    ManagedImage? image,
  }) async {
    try {
      _validate(input);
      return await _savePhoto(
        CoffeeId(_ids.generate()),
        image == null ? null : CoffeePhotoEdit(replacement: image),
        (id) async {
          final draft = await (_db.select(
            _db.coffeeDrafts,
          )..where((t) => t.id.equals(draftId))).getSingleOrNull();
          if (draft == null) throw const NotFoundFailure();
          if (draft.draftType != 'scan_create' ||
              draft.status != 'review_required' ||
              draft.reviewJson == null ||
              draft.reviewRevision != expectedRevision ||
              (image != null &&
                  (image.id != draftId ||
                      image.localPath != draft.temporaryImagePath))) {
            throw const ConflictFailure();
          }
          final coffee = await _write(_builder.build(id, input), insert: true);
          if (draft.temporaryImagePath case final path?) {
            await _db
                .into(_db.fileCleanupTasks)
                .insert(
                  FileCleanupTasksCompanion.insert(
                    id: _ids.generate(),
                    localPath: path,
                    createdAt: _clock.now().toUtc().microsecondsSinceEpoch,
                  ),
                  mode: InsertMode.insertOrIgnore,
                );
          }
          await (_db.delete(
            _db.coffeeDrafts,
          )..where((t) => t.id.equals(draftId))).go();
          return coffee;
        },
      );
    } catch (error) {
      return Err(_failure(error));
    }
  }

  Future<Result<Coffee>> _savePhoto(
    CoffeeId id,
    CoffeePhotoEdit? edit,
    Future<Coffee> Function(CoffeeId) write,
  ) async {
    ImageStorage? storage;
    ManagedImage? candidate;
    try {
      if (edit?.replacement != null) {
        storage = await _imageStorage?.call();
        if (storage == null) throw const StorageFailure();
        // Candidate is fully written before its database reference can commit.
        candidate = await storage.promote(edit!.replacement!, id.value);
      }
      final result = await _command(() async {
        final old = await _photo.forCoffee(id.value);
        if (edit != null && old.firstOrNull?.id != edit.expectedPhotoId) {
          throw const ConflictFailure();
        }
        await write(id);
        if (edit != null) {
          await _photo.queueCleanup(
            old,
            _clock.now().toUtc().microsecondsSinceEpoch,
          );
          await (_db.delete(
            _db.coffeePhotos,
          )..where((t) => t.coffeeId.equals(id.value))).go();
          if (candidate case final image?) {
            await _db
                .into(_db.coffeePhotos)
                .insert(
                  CoffeePhotosCompanion.insert(
                    id: image.id,
                    coffeeId: id.value,
                    localPath: image.localPath,
                    role: 'cover',
                    mimeType: 'image/jpeg',
                    widthPixels: image.width,
                    heightPixels: image.height,
                    byteSize: image.byteSize,
                    source: image.source,
                    position: 0,
                    createdAt: _clock.now().toUtc().microsecondsSinceEpoch,
                  ),
                );
            await _db
                .into(_db.fileCleanupTasks)
                .insert(
                  FileCleanupTasksCompanion.insert(
                    id: _ids.generate(),
                    localPath: edit.replacement!.localPath,
                    createdAt: _clock.now().toUtc().microsecondsSinceEpoch,
                  ),
                  mode: InsertMode.insertOrIgnore,
                );
            await (_db.delete(
              _db.coffeeDrafts,
            )..where((t) => t.id.equals(image.id))).go();
          }
        }
        return CoffeeMapper.fromRows(await _find(id));
      });
      if (result is Err<Coffee> && candidate != null) {
        await _queueCandidate(candidate);
      }
      await _maintain();
      return result;
    } catch (error) {
      // Also covers a copy interrupted between cover and thumbnail writes.
      if (edit?.replacement case final image?) {
        try {
          await _db
              .into(_db.fileCleanupTasks)
              .insert(
                FileCleanupTasksCompanion.insert(
                  id: _ids.generate(),
                  localPath: 'photos/${id.value}/${image.id}.jpg',
                  createdAt: _clock.now().toUtc().microsecondsSinceEpoch,
                ),
                mode: InsertMode.insertOrIgnore,
              );
        } catch (_) {
          /* Startup orphan scan is the final crash recovery layer. */
        }
      }
      await _maintain();
      return Err(_failure(error));
    }
  }

  Future<void> _queueCandidate(ManagedImage image) => _db
      .into(_db.fileCleanupTasks)
      .insert(
        FileCleanupTasksCompanion.insert(
          id: _ids.generate(),
          localPath: image.localPath,
          createdAt: _clock.now().toUtc().microsecondsSinceEpoch,
        ),
        mode: InsertMode.insertOrIgnore,
      )
      .then((_) {});

  Future<void> _maintain() async {
    if (_imageStorage == null) return;
    try {
      await ImageMaintenance(_db, await _imageStorage()).runQueue();
    } catch (_) {
      /* Cleanup failure must not turn committed writes into failure. */
    }
  }

  @override
  Future<Result<Coffee>> setFavorite(CoffeeId id, bool favorite) =>
      _command(() async {
        final previous = CoffeeMapper.fromRows(await _find(id));
        return _write(
          _builder.build(
            id,
            previous.toFormValues(),
            previous: previous,
            favorite: favorite,
          ),
        );
      });

  Future<CoffeeDeleteImpact> _impact(CoffeeId id) async {
    final rows = await _find(id);
    return CoffeeDeleteImpact(
      coffeeId: id,
      journalCount: await _journal.countForCoffee(id.value),
      photoCount: rows.photos.length,
      revision: rows.coffee.revision,
    );
  }

  @override
  Future<Result<CoffeeDeleteImpact>> inspectDeleteImpact(CoffeeId id) =>
      _command(() => _impact(id));

  @override
  Future<Result<void>> delete(CoffeeDeleteImpact confirmedImpact) async {
    final result = await _command<void>(() async {
      final current = await _impact(confirmedImpact.coffeeId);
      if (current != confirmedImpact) throw const ConflictFailure();
      await _photo.queueCleanup(
        await _photo.forCoffee(current.coffeeId.value),
        _clock.now().toUtc().microsecondsSinceEpoch,
      );
      await _photo.queueEditDraftCleanup(
        current.coffeeId.value,
        _clock.now().toUtc().microsecondsSinceEpoch,
      );
      await _coffee.delete(current.coffeeId.value);
    });
    await _maintain();
    return result;
  }
}
