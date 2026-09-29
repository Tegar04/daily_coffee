import 'package:daily_coffee/core/images/managed_image.dart';

/// Null edit means retain cover. A null replacement means explicitly remove it.
final class CoffeePhotoEdit {
  const CoffeePhotoEdit({this.replacement, this.expectedPhotoId});
  final ManagedImage? replacement;
  final String? expectedPhotoId;
}
