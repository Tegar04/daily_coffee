import 'dart:async';

import 'package:daily_coffee/features/coffee/data/in_memory_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_providers.dart';

part 'coffee_providers.g.dart';

@Riverpod(keepAlive: true)
CoffeeRepository coffeeRepository(Ref ref) {
  final repository = InMemoryCoffeeRepository(
    clock: ref.watch(appClockProvider),
    ids: ref.watch(appIdGeneratorProvider),
  );
  ref.onDispose(() => unawaited(repository.dispose()));
  return repository;
}
