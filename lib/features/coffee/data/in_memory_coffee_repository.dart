import 'dart:async';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'coffee_aggregate_builder.dart';

/// Test/preview adapter. Production uses DriftCoffeeRepository.
class InMemoryCoffeeRepository implements CoffeeRepository {
  InMemoryCoffeeRepository({
    required this._clock,
    required this._ids,
    Iterable<Coffee> seed = const [],
    Map<String, CoffeeId> journalLinks = const {},
  }) : _coffees = {for (final coffee in seed) coffee.id: coffee},
       _journalLinks = Map.of(journalLinks);
  final AppClock _clock;
  final AppIdGenerator _ids;
  final Map<CoffeeId, Coffee> _coffees;
  // Fake relational fixtures only; real JournalEntry storage belongs to Phase 9.
  final Map<String, CoffeeId> _journalLinks;
  final _revisions = <CoffeeId, int>{};
  final _changes = StreamController<void>.broadcast(sync: true);
  Map<String, CoffeeId> get journalLinks => Map.unmodifiable(_journalLinks);
  Future<void> dispose() => _changes.close();

  Stream<Result<T>> _watch<T>(T Function() read) => Stream.multi((sink) {
    void emit() => sink.add(Ok(read()));
    final subscription = _changes.stream.listen(
      (_) => emit(),
      onDone: sink.close,
    );
    emit();
    sink.onCancel = subscription.cancel;
  });
  @override
  Stream<Result<List<Coffee>>> watchLibrary() => _watch(() {
    final values = _coffees.values.toList()
      ..sort((a, b) {
        final byDate = b.createdAt.compareTo(a.createdAt);
        return byDate != 0 ? byDate : a.id.value.compareTo(b.id.value);
      });
    return List.unmodifiable(values);
  });
  @override
  Stream<Result<Coffee?>> watchCoffee(CoffeeId id) =>
      _watch(() => _coffees[id]);

  bool _valid(CoffeeFormValues input) =>
      CoffeeValidation.validate(input).isEmpty &&
      CoffeeValidation.validateTags(input.varieties) == null &&
      CoffeeValidation.validateTags(input.tastingNotes) == null;

  void _commit(Coffee coffee) {
    _coffees[coffee.id] = coffee;
    _revisions.update(coffee.id, (value) => value + 1, ifAbsent: () => 1);
    _changes.add(null);
  }

  @override
  Future<Result<Coffee>> create(CoffeeFormValues input) async {
    if (!_valid(input)) return const Err(ValidationFailure());
    try {
      final id = CoffeeId(_ids.generate());
      if (_coffees.containsKey(id)) return const Err(ConflictFailure());
      final coffee = CoffeeAggregateBuilder(
        clock: _clock,
        ids: _ids,
      ).build(id, input);
      _commit(coffee);
      return Ok(coffee);
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  @override
  Future<Result<Coffee>> update(
    CoffeeId id,
    CoffeeFormValues input, {
    required CoffeeFormValues expected,
  }) async {
    if (!_valid(input)) return const Err(ValidationFailure());
    final previous = _coffees[id];
    if (previous == null) return const Err(NotFoundFailure());
    if (previous.toFormValues() != expected) {
      return const Err(ConflictFailure());
    }
    try {
      final coffee = CoffeeAggregateBuilder(
        clock: _clock,
        ids: _ids,
      ).build(id, input, previous: previous);
      _commit(coffee);
      return Ok(coffee);
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  @override
  Future<Result<Coffee>> setFavorite(CoffeeId id, bool favorite) async {
    final previous = _coffees[id];
    if (previous == null) return const Err(NotFoundFailure());
    try {
      final coffee = CoffeeAggregateBuilder(clock: _clock, ids: _ids).build(
        id,
        previous.toFormValues(),
        previous: previous,
        favorite: favorite,
      );
      _commit(coffee);
      return Ok(coffee);
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  CoffeeDeleteImpact? _impact(CoffeeId id) {
    final coffee = _coffees[id];
    return coffee == null
        ? null
        : CoffeeDeleteImpact(
            coffeeId: id,
            journalCount: _journalLinks.values
                .where((parent) => parent == id)
                .length,
            photoCount: coffee.photos.length,
            revision: _revisions[id] ?? 0,
          );
  }

  @override
  Future<Result<CoffeeDeleteImpact>> inspectDeleteImpact(CoffeeId id) async {
    final impact = _impact(id);
    return impact == null ? const Err(NotFoundFailure()) : Ok(impact);
  }

  @override
  Future<Result<void>> delete(CoffeeDeleteImpact confirmedImpact) async {
    final current = _impact(confirmedImpact.coffeeId);
    if (current == null) return const Err(NotFoundFailure());
    if (current != confirmedImpact) return const Err(ConflictFailure());
    // One synchronous commit removes the entire fake graph; no await in between.
    _journalLinks.removeWhere((_, parent) => parent == current.coffeeId);
    _coffees.remove(current.coffeeId);
    _revisions.remove(current.coffeeId);
    _changes.add(null);
    return const Ok(null);
  }
}
