import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../domain/recognized_label_text.dart';

/// Latin model is bundled by the Android plugin, with no remote OCR service.
class MlkitLabelTextRecognizer implements LabelTextRecognizer {
  MlkitLabelTextRecognizer(this.storage);
  final ImageStorage storage;
  bool _busy = false;

  @override
  Future<Result<RecognizedLabelText>> recognize(ManagedImage image) async {
    if (_busy) return const Err(OcrUnavailableFailure());
    _busy = true;
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final file = storage.file(image.localPath);
      if (!await file.exists()) return const Err(ImageValidationFailure());
      final result = await recognizer.processImage(
        InputImage.fromFilePath(file.path),
      );
      if (result.text.trim().isEmpty) return const Err(OcrNoTextFailure());
      return Ok(
        RecognizedLabelText(result.text, [
          for (final block in result.blocks)
            for (final line in block.lines)
              RecognizedLine(line.text, [
                line.boundingBox.left,
                line.boundingBox.top,
                line.boundingBox.right,
                line.boundingBox.bottom,
              ], line.confidence),
        ]),
      );
    } catch (error) {
      return Err(OcrUnavailableFailure(cause: error));
    } finally {
      // A logical cancellation ignores late results; native work owns its
      // recognizer until completion, including after a UI timeout.
      try {
        await recognizer.close();
      } catch (_) {
        /* Best effort native close. */
      }
      _busy = false;
    }
  }
}
