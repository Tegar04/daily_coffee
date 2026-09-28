import 'coffee_values.dart';

final class CoffeeDetails {
  const CoffeeDetails({
    required this.name,
    required this.roastery,
    this.originCountry,
    this.region,
    this.producer,
    this.process,
    this.roastLevel,
    this.roastLevelCustom,
    this.altitudeMinMeters,
    this.altitudeMaxMeters,
    this.roastDate,
    this.purchaseDate,
    this.packageWeightGrams,
    this.personalNote,
  });
  final String name;
  final String roastery;
  final String? originCountry;
  final String? region;
  final String? producer;
  final String? process;
  final RoastLevel? roastLevel;
  final String? roastLevelCustom;
  final int? altitudeMinMeters;
  final int? altitudeMaxMeters;
  final CoffeeDate? roastDate;
  final CoffeeDate? purchaseDate;
  final int? packageWeightGrams;
  final String? personalNote;
  String get nameNormalized => normalizeCoffeeText(name);
  String get roasteryNormalized => normalizeCoffeeText(roastery);
}

final class Coffee {
  Coffee({
    required this.id,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.originCountryCode,
    this.altitudeSourceText,
    List<CoffeeVariety> varieties = const [],
    List<CoffeeTastingNote> tastingNotes = const [],
    List<CoffeePhoto> photos = const [],
  }) : varieties = List.unmodifiable(varieties),
       tastingNotes = List.unmodifiable(tastingNotes),
       photos = List.unmodifiable(photos);
  final CoffeeId id;
  final CoffeeDetails details;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  // Reserved metadata retained across manual edits; never inferred from names.
  final String? originCountryCode;
  final String? altitudeSourceText;
  final List<CoffeeVariety> varieties;
  final List<CoffeeTastingNote> tastingNotes;
  final List<CoffeePhoto> photos;

  CoffeeFormValues toFormValues() => CoffeeFormValues(
    fields: {
      CoffeeField.name: details.name,
      CoffeeField.roastery: details.roastery,
      CoffeeField.originCountry: details.originCountry ?? '',
      CoffeeField.region: details.region ?? '',
      CoffeeField.producer: details.producer ?? '',
      CoffeeField.process: details.process ?? '',
      CoffeeField.roastLevelKey: details.roastLevel?.key ?? '',
      CoffeeField.roastLevelCustom: details.roastLevelCustom ?? '',
      CoffeeField.altitudeMinMeters:
          details.altitudeMinMeters?.toString() ?? '',
      CoffeeField.altitudeMaxMeters:
          details.altitudeMaxMeters?.toString() ?? '',
      CoffeeField.roastDate: details.roastDate?.toString() ?? '',
      CoffeeField.purchaseDate: details.purchaseDate?.toString() ?? '',
      CoffeeField.packageWeightGrams:
          details.packageWeightGrams?.toString() ?? '',
      CoffeeField.personalNote: details.personalNote ?? '',
    },
    varieties: varieties.map((tag) => tag.displayValue).toList(),
    tastingNotes: tastingNotes.map((tag) => tag.displayValue).toList(),
  );
}

sealed class CoffeeTag {
  const CoffeeTag({
    required this.id,
    required this.coffeeId,
    required this.displayValue,
    required this.position,
    required this.createdAt,
  });
  final String id;
  final CoffeeId coffeeId;
  final String displayValue;
  final int position;
  final DateTime createdAt;
  String get normalizedValue => normalizeCoffeeText(displayValue);
}

final class CoffeeVariety extends CoffeeTag {
  const CoffeeVariety({
    required super.id,
    required super.coffeeId,
    required super.displayValue,
    required super.position,
    required super.createdAt,
  });
}

final class CoffeeTastingNote extends CoffeeTag {
  const CoffeeTastingNote({
    required super.id,
    required super.coffeeId,
    required super.displayValue,
    required super.position,
    required super.createdAt,
  });
}

enum CoffeePhotoSource { camera, gallery, scan, import }

enum CoffeePhotoRole { cover }

/// Metadata only. Acquisition and managed file lifecycle are Phase 6.
final class CoffeePhoto {
  CoffeePhoto({
    required this.id,
    required this.coffeeId,
    required this.localPath,
    required this.mimeType,
    required this.widthPixels,
    required this.heightPixels,
    required this.byteSize,
    required this.source,
    required this.createdAt,
    this.role = CoffeePhotoRole.cover,
    this.position = 0,
    this.contentHash,
  }) {
    if (localPath.isEmpty ||
        localPath.startsWith('/') ||
        localPath.contains('\\') ||
        localPath.contains(':') ||
        localPath
            .split('/')
            .any((part) => part == '..' || part == '.' || part.isEmpty) ||
        widthPixels <= 0 ||
        heightPixels <= 0 ||
        byteSize < 0 ||
        position < 0 ||
        !['image/jpeg', 'image/png', 'image/webp'].contains(mimeType)) {
      throw ArgumentError('Invalid managed photo metadata');
    }
  }
  final String id;
  final CoffeeId coffeeId;
  final String localPath;
  final String mimeType;
  final int widthPixels;
  final int heightPixels;
  final int byteSize;
  final CoffeePhotoSource source;
  final CoffeePhotoRole role;
  final int position;
  final String? contentHash;
  final DateTime createdAt;
}
