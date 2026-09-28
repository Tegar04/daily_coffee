import 'dart:async';

import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/application/coffee_form_controller.dart';
import 'package:daily_coffee/features/coffee/application/coffee_queries.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';

void main() {
  late TestCoffeeRepository repository;
  late ProviderContainer container;
  setUp(() {
    repository = TestCoffeeRepository();
    container = ProviderContainer(
      overrides: [coffeeRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(coffeeFormControllerProvider(null), (_, _) {});
    container.listen(coffeeLibraryProvider, (_, _) {});
  });
  tearDown(() async {
    container.dispose();
    await repository.dispose();
  });

  test('invalid form stays editable and never reaches repository', () async {
    final provider = coffeeFormControllerProvider(null);
    final controller = container.read(provider.notifier);
    expect(await controller.submit(), isA<Err<Coffee>>());
    expect(
      container.read(provider).errors.keys,
      containsAll([CoffeeField.name, CoffeeField.roastery]),
    );
    expect(repository.createCalls, 0);
    controller.change(coffeeInput());
    expect(container.read(provider).isDirty, isTrue);
    controller.change(CoffeeFormValues());
    expect(container.read(provider).isDirty, isFalse);
  });

  test(
    'failed save retains fields and can retry; duplicate submission blocked',
    () async {
      final provider = coffeeFormControllerProvider(null);
      final controller = container.read(provider.notifier);
      controller.change(
        coffeeInput().set(CoffeeField.process, 'Custom fermentation'),
      );
      repository.writeFailure = const StorageFailure();
      repository.createGate = Completer<void>();
      final first = controller.submit();
      expect(container.read(provider).submitting, isTrue);
      expect(await controller.submit(), isA<Err<Coffee>>());
      expect(repository.createCalls, 1);
      repository.createGate!.complete();
      expect(await first, isA<Err<Coffee>>());
      expect(
        container.read(provider).values[CoffeeField.process],
        'Custom fermentation',
      );
      expect(container.read(provider).isDirty, isTrue);
      repository.writeFailure = null;
      repository.createGate = null;
      expect(await controller.submit(), isA<Ok<Coffee>>());
      expect(container.read(provider).isDirty, isFalse);
      expect(
        (await container.read(
          coffeeLibraryProvider.future,
        ) as Ok<List<Coffee>>).value.single.details.process,
        'Custom fermentation',
      );
    },
  );

  test(
    'invalid route id produces typed not-found rather than exception',
    () async {
      container.listen(coffeeDetailProvider('malformed-id'), (_, _) {});
      final result = await container.read(
        coffeeDetailProvider('malformed-id').future,
      );
      expect((result as Err<Coffee?>).failure, isA<NotFoundFailure>());
    },
  );
}
