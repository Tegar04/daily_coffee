import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/database/daos/coffee_dao.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:drift/drift.dart';

abstract final class CoffeeMapper {
  static DateTime utc(int value) =>
      DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true);

  static Coffee fromRows(CoffeeRows rows) {
    final c = rows.coffee;
    final id = CoffeeId(c.id);
    return Coffee(
      id: id,
      details: CoffeeDetails(
        name: c.name,
        roastery: c.roastery,
        originCountry: c.originCountry,
        region: c.region,
        producer: c.producer,
        process: c.process,
        roastLevel: RoastLevelKey.fromKey(c.roastLevelKey),
        roastLevelCustom: c.roastLevelCustom,
        altitudeMinMeters: c.altitudeMinMeters,
        altitudeMaxMeters: c.altitudeMaxMeters,
        roastDate: c.roastDate == null
            ? null
            : CoffeeDate.tryParse(c.roastDate!),
        purchaseDate: c.purchaseDate == null
            ? null
            : CoffeeDate.tryParse(c.purchaseDate!),
        packageWeightGrams: c.packageWeightGrams,
        personalNote: c.personalNote,
      ),
      createdAt: utc(c.createdAt),
      updatedAt: utc(c.updatedAt),
      isFavorite: c.isFavorite,
      originCountryCode: c.originCountryCode,
      altitudeSourceText: c.altitudeSourceText,
      varieties: [
        for (final t in rows.varieties)
          CoffeeVariety(
            id: t.id,
            coffeeId: id,
            displayValue: t.displayValue,
            position: t.position,
            createdAt: utc(t.createdAt),
          ),
      ],
      tastingNotes: [
        for (final t in rows.notes)
          CoffeeTastingNote(
            id: t.id,
            coffeeId: id,
            displayValue: t.displayValue,
            position: t.position,
            createdAt: utc(t.createdAt),
          ),
      ],
      photos: [
        for (final p in rows.photos)
          CoffeePhoto(
            id: p.id,
            coffeeId: id,
            localPath: p.localPath,
            mimeType: p.mimeType,
            role: CoffeePhotoRole.values.byName(p.role),
            source: CoffeePhotoSource.values.byName(p.source),
            widthPixels: p.widthPixels,
            heightPixels: p.heightPixels,
            byteSize: p.byteSize,
            position: p.position,
            contentHash: p.contentHash,
            createdAt: utc(p.createdAt),
          ),
      ],
    );
  }

  static CoffeesCompanion toRow(Coffee coffee) {
    final c = coffee.details;
    String? normalized(String? value) =>
        value == null ? null : normalizeCoffeeText(value);
    return CoffeesCompanion.insert(
      id: coffee.id.value,
      name: c.name,
      nameNormalized: c.nameNormalized,
      roastery: c.roastery,
      roasteryNormalized: c.roasteryNormalized,
      originCountry: Value(c.originCountry),
      originCountryNormalized: Value(normalized(c.originCountry)),
      originCountryCode: Value(coffee.originCountryCode),
      region: Value(c.region),
      regionNormalized: Value(normalized(c.region)),
      producer: Value(c.producer),
      producerNormalized: Value(normalized(c.producer)),
      process: Value(c.process),
      processNormalized: Value(normalized(c.process)),
      roastLevelKey: Value(c.roastLevel?.key),
      roastLevelCustom: Value(c.roastLevelCustom),
      altitudeMinMeters: Value(c.altitudeMinMeters),
      altitudeMaxMeters: Value(c.altitudeMaxMeters),
      altitudeSourceText: Value(coffee.altitudeSourceText),
      roastDate: Value(c.roastDate?.toString()),
      purchaseDate: Value(c.purchaseDate?.toString()),
      packageWeightGrams: Value(c.packageWeightGrams),
      personalNote: Value(c.personalNote),
      isFavorite: Value(coffee.isFavorite),
      createdAt: coffee.createdAt.microsecondsSinceEpoch,
      updatedAt: coffee.updatedAt.microsecondsSinceEpoch,
    );
  }

  static List<CoffeeVarietiesCompanion> varieties(Coffee coffee) => [
    for (final t in coffee.varieties)
      CoffeeVarietiesCompanion.insert(
        id: t.id,
        coffeeId: coffee.id.value,
        displayValue: t.displayValue,
        normalizedValue: t.normalizedValue,
        position: t.position,
        createdAt: t.createdAt.microsecondsSinceEpoch,
      ),
  ];
  static List<CoffeeTastingNotesCompanion> notes(Coffee coffee) => [
    for (final t in coffee.tastingNotes)
      CoffeeTastingNotesCompanion.insert(
        id: t.id,
        coffeeId: coffee.id.value,
        displayValue: t.displayValue,
        normalizedValue: t.normalizedValue,
        position: t.position,
        createdAt: t.createdAt.microsecondsSinceEpoch,
      ),
  ];
}
