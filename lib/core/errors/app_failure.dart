sealed class AppFailure {
  const AppFailure({
    required this.code,
    this.diagnosticContext = const {},
    this.cause,
  });

  final String code;
  final Map<String, Object?> diagnosticContext;
  final Object? cause;

  @override
  String toString() => 'AppFailure(code: $code, context: $diagnosticContext)';
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({super.diagnosticContext, super.cause})
    : super(code: 'validation');
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure({super.diagnosticContext, super.cause})
    : super(code: 'not_found');
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure({super.diagnosticContext, super.cause})
    : super(code: 'conflict');
}

final class StorageFailure extends AppFailure {
  const StorageFailure({super.diagnosticContext, super.cause})
    : super(code: 'storage');
}

final class MigrationFailure extends AppFailure {
  const MigrationFailure({super.diagnosticContext, super.cause})
    : super(code: 'migration');
}

final class PermissionDeniedFailure extends AppFailure {
  const PermissionDeniedFailure({super.diagnosticContext, super.cause})
    : super(code: 'permission_denied');
}

final class PermissionPermanentlyDeniedFailure extends AppFailure {
  const PermissionPermanentlyDeniedFailure({
    super.diagnosticContext,
    super.cause,
  }) : super(code: 'permission_permanently_denied');
}

final class CameraUnavailableFailure extends AppFailure {
  const CameraUnavailableFailure({super.diagnosticContext, super.cause})
    : super(code: 'camera_unavailable');
}

final class ImageValidationFailure extends AppFailure {
  const ImageValidationFailure({super.diagnosticContext, super.cause})
    : super(code: 'image_validation');
}

final class OcrNoTextFailure extends AppFailure {
  const OcrNoTextFailure({super.diagnosticContext, super.cause})
    : super(code: 'ocr_no_text');
}

final class OcrUnavailableFailure extends AppFailure {
  const OcrUnavailableFailure({super.diagnosticContext, super.cause})
    : super(code: 'ocr_unavailable');
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({super.diagnosticContext, super.cause})
    : super(code: 'network');
}

final class ExternalServiceFailure extends AppFailure {
  const ExternalServiceFailure({super.diagnosticContext, super.cause})
    : super(code: 'external_service');
}

final class ImportValidationFailure extends AppFailure {
  const ImportValidationFailure({super.diagnosticContext, super.cause})
    : super(code: 'import_validation');
}

final class ExportFailure extends AppFailure {
  const ExportFailure({super.diagnosticContext, super.cause})
    : super(code: 'export');
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({super.diagnosticContext, super.cause})
    : super(code: 'unexpected');
}
