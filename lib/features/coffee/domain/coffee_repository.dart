import 'package:daily_coffee/core/errors/result.dart';

import 'coffee.dart';
import 'coffee_photo_edit.dart';
import 'coffee_values.dart';

final class CoffeeDeleteImpact {
  const CoffeeDeleteImpact({
    required this.coffeeId,
    required this.journalCount,
    required this.photoCount,
    required this.revision,
  });
  final CoffeeId coffeeId;
  final int journalCount;
  final int photoCount;

  /// Opaque repository revision. Delete must recheck it atomically.
  final int revision;
  @override
  bool operator ==(Object other) =>
      other is CoffeeDeleteImpact &&
      coffeeId == other.coffeeId &&
      journalCount == other.journalCount &&
      photoCount == other.photoCount &&
      revision == other.revision;
  @override
  int get hashCode => Object.hash(coffeeId, journalCount, photoCount, revision);
}

abstract interface class CoffeeRepository {
  Stream<Result<List<Coffee>>> watchLibrary();
  Stream<Result<Coffee?>> watchCoffee(CoffeeId id);
  Future<Result<Coffee>> create(
    CoffeeFormValues input, {
    CoffeePhotoEdit? photo,
  });
  Future<Result<Coffee>> update(
    CoffeeId id,
    CoffeeFormValues input, {
    required CoffeeFormValues expected,
    CoffeePhotoEdit? photo,
  });
  Future<Result<Coffee>> setFavorite(CoffeeId id, bool favorite);
  Future<Result<CoffeeDeleteImpact>> inspectDeleteImpact(CoffeeId id);
  Future<Result<void>> delete(CoffeeDeleteImpact confirmedImpact);
}
