import 'dart:async';

import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/application/scan_review_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/scan_review_fakes.dart';

void main() {
  late FakeScanReviewRepository repository;
  late ProviderContainer container;
  late ScanReviewController controller;
  setUp(() async {
    repository = FakeScanReviewRepository();
    container = ProviderContainer(
      overrides: [
        scanReviewRepositoryProvider.overrideWith((ref) async => repository),
      ],
    );
    container.listen(
      scanReviewControllerProvider(repository.draft.id),
      (_, _) {},
    );
    await container.read(
      scanReviewControllerProvider(repository.draft.id).future,
    );
    controller = container.read(
      scanReviewControllerProvider(repository.draft.id).notifier,
    );
  });
  tearDown(() => container.dispose());
  test('queued edits persist latest snapshot before explicit promotion; duplicate click blocked', () async {
    repository.saveGate = Completer<void>();
    controller.change(
      repository.draft.values.set(CoffeeField.name, 'First'),
      false,
    );
    controller.change(
      repository.draft.values.set(CoffeeField.name, 'Last'),
      false,
    );
    final promotion = controller.confirm();
    final duplicate = await controller.confirm();
    expect(duplicate, isA<Err<Coffee>>());
    expect(repository.promotions, 0);
    repository.saveGate!.complete();
    expect(await promotion, isA<Ok<Coffee>>());
    expect(repository.draft.values[CoffeeField.name], 'Last');
    expect(repository.promotions, 1);
  });
  test(
    'save failure blocks promotion; retry preserves current input',
    () async {
      repository.failSave = true;
      controller.change(
        repository.draft.values.set(CoffeeField.name, 'Recover me'),
        false,
      );
      expect(await controller.confirm(), isA<Err<Coffee>>());
      expect(repository.promotions, 0);
      repository.failSave = false;
      expect(await controller.flush(), isTrue);
      expect(repository.draft.values[CoffeeField.name], 'Recover me');
    },
  );
  test('disposing review does not cancel already queued persistence', () async {
    repository.saveGate = Completer<void>();
    controller.change(
      repository.draft.values.set(CoffeeField.roastDate, '2026-0'),
      false,
    );
    container.dispose();
    repository.saveGate!.complete();
    for (
      var i = 0;
      i < 20 && repository.draft.values[CoffeeField.roastDate] != '2026-0';
      i++
    ) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
    expect(repository.draft.values[CoffeeField.roastDate], '2026-0');
    expect(repository.promotions, 0);
  });
}
