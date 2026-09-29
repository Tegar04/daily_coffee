import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_providers.dart';
import 'database_providers.dart';

part 'coffee_providers.g.dart';

@Riverpod(keepAlive: true)
CoffeeRepository coffeeRepository(Ref ref) {
  return DriftCoffeeRepository(
    database: ref.watch(appDatabaseProvider),
    clock: ref.watch(appClockProvider),
    ids: ref.watch(appIdGeneratorProvider),
  );
}
