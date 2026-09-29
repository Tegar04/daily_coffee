import 'dart:isolate';
import 'dart:typed_data';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:image/image.dart' as img;

final class ProcessedImage {
  const ProcessedImage(this.cover, this.thumbnail, this.width, this.height);
  final Uint8List cover;
  final Uint8List thumbnail;
  final int width;
  final int height;
}

/// Limits checked before full decode. Work runs away from the UI isolate.
class ImageProcessor {
  static const maxInputBytes = 25 * 1024 * 1024;
  static const maxPixels = 40 * 1000 * 1000;
  static const coverEdge = 2400;
  static const thumbnailEdge = 480;
  Future<ProcessedImage> process(Uint8List bytes) =>
      Isolate.run(() => normalize(bytes));

  static ProcessedImage normalize(Uint8List bytes) {
    try {
      return _normalize(bytes);
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const ImageValidationFailure();
    }
  }

  static ProcessedImage _normalize(Uint8List bytes) {
    if (bytes.isEmpty || bytes.length > maxInputBytes) {
      throw const ImageValidationFailure();
    }
    _checkJpegHeader(bytes);
    final decoder = img.findDecoderForData(bytes);
    if (decoder is! img.JpegDecoder &&
        decoder is! img.PngDecoder &&
        decoder is! img.WebPDecoder) {
      throw const ImageValidationFailure();
    }
    final info = decoder!.startDecode(bytes);
    if (info == null ||
        info.width <= 0 ||
        info.height <= 0 ||
        info.width * info.height > maxPixels ||
        (decoder is img.WebPDecoder
            ? decoder.info!.hasAnimation
            : info.numFrames != 1)) {
      throw const ImageValidationFailure();
    }
    final decoded = decoder.decodeFrame(0);
    if (decoded == null) throw const ImageValidationFailure();
    var image = img.bakeOrientation(decoded);
    // Remove EXIF (including location) from persisted derivatives.
    image.exif = img.ExifData();
    img.Image resize(img.Image input, int edge) {
      if (input.width <= edge && input.height <= edge) return input;
      return img.copyResize(
        input,
        width: input.width >= input.height ? edge : null,
        height: input.height > input.width ? edge : null,
        interpolation: img.Interpolation.average,
      );
    }

    image = resize(image, coverEdge);
    return ProcessedImage(
      img.encodeJpg(image, quality: 90),
      img.encodeJpg(resize(image, thumbnailEdge), quality: 80),
      image.width,
      image.height,
    );
  }

  // image's JPEG startDecode prepares component buffers, even when callers
  // only ask for dimensions. Reject oversized SOF headers before invoking it.
  static void _checkJpegHeader(Uint8List bytes) {
    if (bytes.length < 2 || bytes[0] != 0xff || bytes[1] != 0xd8) return;
    var offset = 2;
    const frames = {
      0xc0,
      0xc1,
      0xc2,
      0xc3,
      0xc5,
      0xc6,
      0xc7,
      0xc9,
      0xca,
      0xcb,
      0xcd,
      0xce,
      0xcf,
    };
    while (offset < bytes.length) {
      if (bytes[offset++] != 0xff) throw const ImageValidationFailure();
      while (offset < bytes.length && bytes[offset] == 0xff) {
        offset++;
      }
      if (offset >= bytes.length) break;
      final marker = bytes[offset++];
      if (marker == 0xda || marker == 0xd9) break;
      if (marker == 0x01 || (marker >= 0xd0 && marker <= 0xd8)) continue;
      if (offset + 2 > bytes.length) break;
      final length = (bytes[offset] << 8) | bytes[offset + 1];
      if (length < 2 || offset + length > bytes.length) break;
      if (frames.contains(marker)) {
        if (length < 8) break;
        final height = (bytes[offset + 3] << 8) | bytes[offset + 4];
        final width = (bytes[offset + 5] << 8) | bytes[offset + 6];
        final components = bytes[offset + 7];
        if (width == 0 ||
            height == 0 ||
            width * height > maxPixels ||
            components < 1 ||
            components > 4 ||
            length < 8 + components * 3) {
          throw const ImageValidationFailure();
        }
        for (var component = 0; component < components; component++) {
          final sampling = bytes[offset + 9 + component * 3];
          final horizontal = sampling >> 4;
          final vertical = sampling & 15;
          if (horizontal < 1 ||
              horizontal > 4 ||
              vertical < 1 ||
              vertical > 4) {
            throw const ImageValidationFailure();
          }
        }
        return;
      }
      offset += length;
    }
    throw const ImageValidationFailure();
  }
}
