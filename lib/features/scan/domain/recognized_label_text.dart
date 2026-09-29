import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/managed_image.dart';

abstract interface class LabelTextRecognizer {
  Future<Result<RecognizedLabelText>> recognize(ManagedImage image);
}

/// Provider-neutral pixel coordinates after orientation normalization.
class RecognizedLine {
  const RecognizedLine(this.text, this.bounds, this.confidence);
  final String text;
  final List<double> bounds;

  /// Null means unavailable; never infer confidence from text length.
  final double? confidence;
  Map<String, Object?> toJson() => {
    'text': text,
    'bounds': bounds,
    'confidence': confidence,
  };
  factory RecognizedLine.fromJson(Map<String, dynamic> json) => RecognizedLine(
    json['text'] as String,
    (json['bounds'] as List).map((v) => (v as num).toDouble()).toList(),
    (json['confidence'] as num?)?.toDouble(),
  );
}

class RecognizedLabelText {
  const RecognizedLabelText(this.text, this.lines);
  final String text;
  final List<RecognizedLine> lines;
}

class ScanDraft {
  const ScanDraft(this.image, this.result);
  final ManagedImage image;
  final RecognizedLabelText? result;
}
