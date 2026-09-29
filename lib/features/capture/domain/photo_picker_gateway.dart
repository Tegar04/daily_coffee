import 'package:daily_coffee/core/errors/result.dart';

enum PhotoSource { camera, gallery }

abstract interface class PhotoPickerGateway {
  Future<Result<String?>> pick(PhotoSource source);
  Future<Result<String?>> recover();
}
