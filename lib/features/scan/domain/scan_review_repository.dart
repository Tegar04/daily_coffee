import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'coffee_draft.dart';

abstract interface class ScanReviewRepository {
  Future<Result<CoffeeDraft>> open(String id);
  Future<Result<CoffeeDraft>> save(
    String id,
    int expectedRevision,
    CoffeeFormValues values,
    bool includePhoto,
  );
  Future<Result<Coffee>> promote(String id, int expectedRevision);
}
