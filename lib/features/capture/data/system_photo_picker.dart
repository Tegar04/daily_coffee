import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../domain/photo_picker_gateway.dart';

final class SystemPhotoPicker implements PhotoPickerGateway {
  SystemPhotoPicker() {
    final platform = ImagePickerPlatform.instance;
    if (platform is ImagePickerAndroid) platform.useAndroidPhotoPicker = true;
  }
  final _picker = ImagePicker();
  AppFailure _failure(Object error) {
    if (error is PlatformException) {
      if (error.code.contains('without_prompt')) {
        return const PermissionPermanentlyDeniedFailure();
      }
      if (error.code.contains('denied') || error.code.contains('restricted')) {
        return const PermissionDeniedFailure();
      }
    }
    return const CameraUnavailableFailure();
  }

  @override
  Future<Result<String?>> pick(PhotoSource source) async {
    try {
      final result = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        requestFullMetadata: false,
      );
      return Ok(result?.path);
    } catch (error) {
      return Err(_failure(error));
    }
  }

  @override
  Future<Result<String?>> recover() async {
    try {
      final result = await _picker.retrieveLostData();
      if (result.exception != null) return Err(_failure(result.exception!));
      return Ok(result.files?.firstOrNull?.path);
    } catch (error) {
      return Err(_failure(error));
    }
  }
}
