import 'dart:async';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/domain/coffee_draft.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:daily_coffee/features/scan/domain/scan_review_repository.dart';

import 'coffee_fakes.dart';

class FakeScanReviewRepository implements ScanReviewRepository {
  CoffeeDraft draft = CoffeeDraft(
    id: '00000000-0000-4000-8000-000000000008',
    image: null,
    text: const RecognizedLabelText('Name: Gayo\nRoastery: Nusantara', []),
    values: coffeeInput(name: 'Gayo', roastery: 'Nusantara'),
    fields: const [],
    revision: 1,
    includePhoto: false,
  );
  Completer<void>? saveGate;
  Completer<void>? promoteGate;
  bool failSave = false;
  int saves = 0;
  int promotions = 0;
  @override
  Future<Result<CoffeeDraft>> open(String id) async => Ok(draft);
  @override
  Future<Result<CoffeeDraft>> save(
    String id,
    int revision,
    CoffeeFormValues values,
    bool includePhoto,
  ) async {
    saves++;
    if (saveGate != null) await saveGate!.future;
    if (failSave) return const Err(StorageFailure());
    if (revision != draft.revision) return const Err(ConflictFailure());
    draft = CoffeeDraft(
      id: draft.id,
      image: null,
      text: draft.text,
      values: values,
      fields: draft.fields,
      revision: revision + 1,
      includePhoto: includePhoto,
    );
    return Ok(draft);
  }

  @override
  Future<Result<Coffee>> promote(String id, int revision) async {
    promotions++;
    if (promoteGate != null) await promoteGate!.future;
    return TestCoffeeRepository().create(draft.values);
  }
}
