import 'dart:async';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/database/daos/coffee_dao.dart';
import 'package:daily_coffee/core/database/daos/journal_dao.dart';
import 'package:daily_coffee/core/database/daos/photo_dao.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:sqlite3/sqlite3.dart';

import 'coffee_aggregate_builder.dart';
import 'coffee_mapper.dart';

final class DriftCoffeeRepository implements CoffeeRepository {
  DriftCoffeeRepository({
    required AppDatabase database,
    required AppClock clock,
    required AppIdGenerator ids,
  }) : _db = database,
       _clock = clock,
       _ids = ids,
       _coffee = CoffeeDao(database),
       _journal = JournalDao(database),
       _photo = PhotoDao(database),
       _builder = CoffeeAggregateBuilder(clock: clock, ids: ids);
  final AppDatabase _db;
  final AppClock _clock;
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
  Future<Result<Coffee>> create(CoffeeFormValues input) => _command(() async {
    _validate(input);
    return _write(
      _builder.build(CoffeeId(_ids.generate()), input),
      insert: true,
    );
  });

  @override
  Future<Result<Coffee>> update(
    CoffeeId id,
    CoffeeFormValues input, {
    required CoffeeFormValues expected,
  }) => _command(() async {
    _validate(input);
    final previous = CoffeeMapper.fromRows(await _find(id));
    if (previous.toFormValues() != expected) throw const ConflictFailure();
    return _write(_builder.build(id, input, previous: previous));
  });

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
  Future<Result<void>> delete(CoffeeDeleteImpact confirmedImpact) =>
      _command(() async {
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
}
