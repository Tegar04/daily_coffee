import 'dart:async';
import 'dart:math';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/features/coffee/data/in_memory_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'test_doubles.dart';

CoffeeFormValues coffeeInput({
  String name = 'Ethiopia Guji',
  String roastery = 'Daily Roaster',
}) => CoffeeFormValues(
  fields: {CoffeeField.name: name, CoffeeField.roastery: roastery},
);

class TestCoffeeRepository extends InMemoryCoffeeRepository {
  TestCoffeeRepository({super.seed, super.journalLinks})
    : super(
        clock: FixedAppClock(DateTime.utc(2026, 9, 28)),
        ids: RandomAppIdGenerator(random: Random(42)),
      );
  AppFailure? writeFailure;
  bool libraryFailure = false;
  bool detailFailure = false;
  Completer<void>? createGate;
  var createCalls = 0;
  CoffeeDeleteImpact? deletedImpact;

  @override
  Stream<Result<List<Coffee>>> watchLibrary() => libraryFailure
      ? Stream.value(const Err(StorageFailure()))
      : super.watchLibrary();
  @override
  Stream<Result<Coffee?>> watchCoffee(CoffeeId id) => detailFailure
      ? Stream.value(const Err(StorageFailure()))
      : super.watchCoffee(id);
  @override
  Future<Result<Coffee>> create(CoffeeFormValues input) async {
    createCalls++;
    if (createGate != null) await createGate!.future;
    return writeFailure == null ? super.create(input) : Err(writeFailure!);
  }

  @override
  Future<Result<Coffee>> update(
    CoffeeId id,
    CoffeeFormValues input, {
    required CoffeeFormValues expected,
  }) async => writeFailure == null
      ? super.update(id, input, expected: expected)
      : Err(writeFailure!);
  @override
  Future<Result<void>> delete(CoffeeDeleteImpact confirmedImpact) {
    deletedImpact = confirmedImpact;
    return super.delete(confirmedImpact);
  }
}

Coffee sampleCoffee({
  String id = '00000000-0000-4000-8000-000000000001',
  List<CoffeePhoto> photos = const [],
}) => Coffee(
  id: CoffeeId(id),
  details: const CoffeeDetails(name: 'Guji', roastery: 'Roaster'),
  createdAt: DateTime.utc(2026, 9, 20),
  updatedAt: DateTime.utc(2026, 9, 20),
  photos: photos,
);
