import 'package:daily_coffee/core/images/managed_image.dart';

final class RecoveredCapture {
  const RecoveredCapture(this.image, this.targetCoffeeId, this.context);
  final ManagedImage image;
  final String? targetCoffeeId;
  final Map<String, dynamic> context;
}
