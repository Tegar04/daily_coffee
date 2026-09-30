import 'dart:async';

import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
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
  late FakeLabelExtractor ai;
  late ScanReviewController controller;
  setUp(() async {
    repository = FakeScanReviewRepository();
    ai = FakeLabelExtractor();
    container = ProviderContainer(
      overrides: [
        labelExtractorProvider.overrideWith((ref) => ai),
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
  test(
    'automatic AI is not repeated after failure or provider recreation',
    () async {
      ai.result = const Err(NetworkFailure());
      expect(
        await controller.fillWithAi(onlyIfNew: true),
        isA<Err<CoffeeFormValues>>(),
      );
      expect(ai.calls, 1);
      expect(repository.draft.revision, 2);
      container.invalidate(scanReviewControllerProvider(repository.draft.id));
      await container.read(
        scanReviewControllerProvider(repository.draft.id).future,
      );
      final reopened = container.read(
        scanReviewControllerProvider(repository.draft.id).notifier,
      );
      await reopened.fillWithAi(onlyIfNew: true);
      expect(ai.calls, 1);
      expect(repository.draft.values[CoffeeField.name], 'Gayo');
    },
  );

  test('automatic AI skips previously edited drafts', () async {
    controller.change(
      repository.draft.values.set(CoffeeField.name, 'My edit'),
      false,
    );
    await controller.flush();
    await controller.fillWithAi(onlyIfNew: true);
    expect(ai.calls, 0);
    expect(repository.draft.values[CoffeeField.name], 'My edit');
  });
  test('AI preserves personal data and missing fields and autosaves without promotion', () async {
    controller.change(
      repository.draft.values
          .set(CoffeeField.personalNote, 'My note')
          .set(CoffeeField.purchaseDate, '2026-09-30'),
      false,
    );
    final result = await controller.fillWithAi();
    expect(result, isA<Ok<CoffeeFormValues>>());
    await controller.flush();
    expect(repository.draft.values[CoffeeField.personalNote], 'My note');
    expect(repository.draft.values[CoffeeField.roastery], 'Nusantara');
    expect(repository.draft.values[CoffeeField.altitudeMaxMeters], '1700');
    expect(repository.promotions, 0);
  });
  test(
    'duplicate calls blocked; edits during request invalidate late AI result',
    () async {
      ai.gate = Completer<Result<CoffeeFormValues>>();
      final pending = controller.fillWithAi();
      await Future<void>.delayed(Duration.zero);
      expect(await controller.fillWithAi(), isA<Err<CoffeeFormValues>>());
      expect(await controller.confirm(), isA<Err<Coffee>>());
      controller.change(
        repository.draft.values.set(CoffeeField.name, 'Keep edit'),
        false,
      );
      ai.gate!.complete(ai.result);
      expect(await pending, isA<Err<CoffeeFormValues>>());
      await controller.flush();
      expect(repository.draft.values[CoffeeField.name], 'Keep edit');
      expect(ai.calls, 1);
    },
  );
  test('failed AI leaves form intact and allows manual promotion', () async {
    ai.result = const Err(NetworkFailure());
    final before = repository.draft.values;
    expect(await controller.fillWithAi(), isA<Err<CoffeeFormValues>>());
    expect(repository.draft.values, before);
    expect(await controller.confirm(), isA<Ok<Coffee>>());
  });
  test('cancel ignores late result without persisting AI', () async {
    ai.gate = Completer<Result<CoffeeFormValues>>();
    final pending = controller.fillWithAi();
    await Future<void>.delayed(Duration.zero);
    controller.cancelAi();
    ai.gate!.complete(ai.result);
    expect(await pending, isA<Err<CoffeeFormValues>>());
    expect(repository.saves, 0);
  });
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
