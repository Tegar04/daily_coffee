import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_queries.g.dart';

@riverpod
Stream<Result<List<Coffee>>> coffeeLibrary(Ref ref) =>
    ref.watch(coffeeRepositoryProvider).watchLibrary();

@riverpod
Stream<Result<Coffee?>> coffeeDetail(Ref ref, String id) {
  try {
    return ref.watch(coffeeRepositoryProvider).watchCoffee(CoffeeId(id));
  } on FormatException {
    return Stream.value(const Err(NotFoundFailure()));
  }
}
