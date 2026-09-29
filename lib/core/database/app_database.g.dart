// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CoffeesTable extends Coffees
    with TableInfo<$CoffeesTable, CoffeeRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameNormalizedMeta = const VerificationMeta(
    'nameNormalized',
  );
  @override
  late final GeneratedColumn<String> nameNormalized = GeneratedColumn<String>(
    'name_normalized',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roasteryMeta = const VerificationMeta(
    'roastery',
  );
  @override
  late final GeneratedColumn<String> roastery = GeneratedColumn<String>(
    'roastery',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roasteryNormalizedMeta =
      const VerificationMeta('roasteryNormalized');
  @override
  late final GeneratedColumn<String> roasteryNormalized =
      GeneratedColumn<String>(
        'roastery_normalized',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _originCountryMeta = const VerificationMeta(
    'originCountry',
  );
  @override
  late final GeneratedColumn<String> originCountry = GeneratedColumn<String>(
    'origin_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originCountryNormalizedMeta =
      const VerificationMeta('originCountryNormalized');
  @override
  late final GeneratedColumn<String> originCountryNormalized =
      GeneratedColumn<String>(
        'origin_country_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionNormalizedMeta = const VerificationMeta(
    'regionNormalized',
  );
  @override
  late final GeneratedColumn<String> regionNormalized = GeneratedColumn<String>(
    'region_normalized',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _producerMeta = const VerificationMeta(
    'producer',
  );
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
    'producer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _producerNormalizedMeta =
      const VerificationMeta('producerNormalized');
  @override
  late final GeneratedColumn<String> producerNormalized =
      GeneratedColumn<String>(
        'producer_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _processMeta = const VerificationMeta(
    'process',
  );
  @override
  late final GeneratedColumn<String> process = GeneratedColumn<String>(
    'process',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processNormalizedMeta = const VerificationMeta(
    'processNormalized',
  );
  @override
  late final GeneratedColumn<String> processNormalized =
      GeneratedColumn<String>(
        'process_normalized',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _originCountryCodeMeta = const VerificationMeta(
    'originCountryCode',
  );
  @override
  late final GeneratedColumn<String> originCountryCode =
      GeneratedColumn<String>(
        'origin_country_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _roastLevelKeyMeta = const VerificationMeta(
    'roastLevelKey',
  );
  @override
  late final GeneratedColumn<String> roastLevelKey = GeneratedColumn<String>(
    'roast_level_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastLevelCustomMeta = const VerificationMeta(
    'roastLevelCustom',
  );
  @override
  late final GeneratedColumn<String> roastLevelCustom = GeneratedColumn<String>(
    'roast_level_custom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMinMetersMeta = const VerificationMeta(
    'altitudeMinMeters',
  );
  @override
  late final GeneratedColumn<int> altitudeMinMeters = GeneratedColumn<int>(
    'altitude_min_meters',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMaxMetersMeta = const VerificationMeta(
    'altitudeMaxMeters',
  );
  @override
  late final GeneratedColumn<int> altitudeMaxMeters = GeneratedColumn<int>(
    'altitude_max_meters',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeSourceTextMeta =
      const VerificationMeta('altitudeSourceText');
  @override
  late final GeneratedColumn<String> altitudeSourceText =
      GeneratedColumn<String>(
        'altitude_source_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<String> roastDate = GeneratedColumn<String>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<String> purchaseDate = GeneratedColumn<String>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packageWeightGramsMeta =
      const VerificationMeta('packageWeightGrams');
  @override
  late final GeneratedColumn<int> packageWeightGrams = GeneratedColumn<int>(
    'package_weight_grams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personalNoteMeta = const VerificationMeta(
    'personalNote',
  );
  @override
  late final GeneratedColumn<String> personalNote = GeneratedColumn<String>(
    'personal_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameNormalized,
    roastery,
    roasteryNormalized,
    originCountry,
    originCountryNormalized,
    region,
    regionNormalized,
    producer,
    producerNormalized,
    process,
    processNormalized,
    originCountryCode,
    roastLevelKey,
    roastLevelCustom,
    altitudeMinMeters,
    altitudeMaxMeters,
    altitudeSourceText,
    roastDate,
    purchaseDate,
    packageWeightGrams,
    personalNote,
    isFavorite,
    revision,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffees';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_normalized')) {
      context.handle(
        _nameNormalizedMeta,
        nameNormalized.isAcceptableOrUnknown(
          data['name_normalized']!,
          _nameNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameNormalizedMeta);
    }
    if (data.containsKey('roastery')) {
      context.handle(
        _roasteryMeta,
        roastery.isAcceptableOrUnknown(data['roastery']!, _roasteryMeta),
      );
    } else if (isInserting) {
      context.missing(_roasteryMeta);
    }
    if (data.containsKey('roastery_normalized')) {
      context.handle(
        _roasteryNormalizedMeta,
        roasteryNormalized.isAcceptableOrUnknown(
          data['roastery_normalized']!,
          _roasteryNormalizedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roasteryNormalizedMeta);
    }
    if (data.containsKey('origin_country')) {
      context.handle(
        _originCountryMeta,
        originCountry.isAcceptableOrUnknown(
          data['origin_country']!,
          _originCountryMeta,
        ),
      );
    }
    if (data.containsKey('origin_country_normalized')) {
      context.handle(
        _originCountryNormalizedMeta,
        originCountryNormalized.isAcceptableOrUnknown(
          data['origin_country_normalized']!,
          _originCountryNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('region_normalized')) {
      context.handle(
        _regionNormalizedMeta,
        regionNormalized.isAcceptableOrUnknown(
          data['region_normalized']!,
          _regionNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('producer')) {
      context.handle(
        _producerMeta,
        producer.isAcceptableOrUnknown(data['producer']!, _producerMeta),
      );
    }
    if (data.containsKey('producer_normalized')) {
      context.handle(
        _producerNormalizedMeta,
        producerNormalized.isAcceptableOrUnknown(
          data['producer_normalized']!,
          _producerNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('process')) {
      context.handle(
        _processMeta,
        process.isAcceptableOrUnknown(data['process']!, _processMeta),
      );
    }
    if (data.containsKey('process_normalized')) {
      context.handle(
        _processNormalizedMeta,
        processNormalized.isAcceptableOrUnknown(
          data['process_normalized']!,
          _processNormalizedMeta,
        ),
      );
    }
    if (data.containsKey('origin_country_code')) {
      context.handle(
        _originCountryCodeMeta,
        originCountryCode.isAcceptableOrUnknown(
          data['origin_country_code']!,
          _originCountryCodeMeta,
        ),
      );
    }
    if (data.containsKey('roast_level_key')) {
      context.handle(
        _roastLevelKeyMeta,
        roastLevelKey.isAcceptableOrUnknown(
          data['roast_level_key']!,
          _roastLevelKeyMeta,
        ),
      );
    }
    if (data.containsKey('roast_level_custom')) {
      context.handle(
        _roastLevelCustomMeta,
        roastLevelCustom.isAcceptableOrUnknown(
          data['roast_level_custom']!,
          _roastLevelCustomMeta,
        ),
      );
    }
    if (data.containsKey('altitude_min_meters')) {
      context.handle(
        _altitudeMinMetersMeta,
        altitudeMinMeters.isAcceptableOrUnknown(
          data['altitude_min_meters']!,
          _altitudeMinMetersMeta,
        ),
      );
    }
    if (data.containsKey('altitude_max_meters')) {
      context.handle(
        _altitudeMaxMetersMeta,
        altitudeMaxMeters.isAcceptableOrUnknown(
          data['altitude_max_meters']!,
          _altitudeMaxMetersMeta,
        ),
      );
    }
    if (data.containsKey('altitude_source_text')) {
      context.handle(
        _altitudeSourceTextMeta,
        altitudeSourceText.isAcceptableOrUnknown(
          data['altitude_source_text']!,
          _altitudeSourceTextMeta,
        ),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('package_weight_grams')) {
      context.handle(
        _packageWeightGramsMeta,
        packageWeightGrams.isAcceptableOrUnknown(
          data['package_weight_grams']!,
          _packageWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('personal_note')) {
      context.handle(
        _personalNoteMeta,
        personalNote.isAcceptableOrUnknown(
          data['personal_note']!,
          _personalNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoffeeRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_normalized'],
      )!,
      roastery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roastery'],
      )!,
      roasteryNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roastery_normalized'],
      )!,
      originCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country'],
      ),
      originCountryNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country_normalized'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      regionNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_normalized'],
      ),
      producer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producer'],
      ),
      producerNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producer_normalized'],
      ),
      process: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process'],
      ),
      processNormalized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process_normalized'],
      ),
      originCountryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country_code'],
      ),
      roastLevelKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level_key'],
      ),
      roastLevelCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level_custom'],
      ),
      altitudeMinMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_min_meters'],
      ),
      altitudeMaxMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_max_meters'],
      ),
      altitudeSourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}altitude_source_text'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_date'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_date'],
      ),
      packageWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}package_weight_grams'],
      ),
      personalNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_note'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CoffeesTable createAlias(String alias) {
    return $CoffeesTable(attachedDatabase, alias);
  }
}

class CoffeeRecord extends DataClass implements Insertable<CoffeeRecord> {
  final String id;
  final String name;
  final String nameNormalized;
  final String roastery;
  final String roasteryNormalized;
  final String? originCountry;
  final String? originCountryNormalized;
  final String? region;
  final String? regionNormalized;
  final String? producer;
  final String? producerNormalized;
  final String? process;
  final String? processNormalized;
  final String? originCountryCode;
  final String? roastLevelKey;
  final String? roastLevelCustom;
  final int? altitudeMinMeters;
  final int? altitudeMaxMeters;
  final String? altitudeSourceText;
  final String? roastDate;
  final String? purchaseDate;
  final int? packageWeightGrams;
  final String? personalNote;
  final bool isFavorite;
  final int revision;
  final int createdAt;
  final int updatedAt;
  const CoffeeRecord({
    required this.id,
    required this.name,
    required this.nameNormalized,
    required this.roastery,
    required this.roasteryNormalized,
    this.originCountry,
    this.originCountryNormalized,
    this.region,
    this.regionNormalized,
    this.producer,
    this.producerNormalized,
    this.process,
    this.processNormalized,
    this.originCountryCode,
    this.roastLevelKey,
    this.roastLevelCustom,
    this.altitudeMinMeters,
    this.altitudeMaxMeters,
    this.altitudeSourceText,
    this.roastDate,
    this.purchaseDate,
    this.packageWeightGrams,
    this.personalNote,
    required this.isFavorite,
    required this.revision,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['name_normalized'] = Variable<String>(nameNormalized);
    map['roastery'] = Variable<String>(roastery);
    map['roastery_normalized'] = Variable<String>(roasteryNormalized);
    if (!nullToAbsent || originCountry != null) {
      map['origin_country'] = Variable<String>(originCountry);
    }
    if (!nullToAbsent || originCountryNormalized != null) {
      map['origin_country_normalized'] = Variable<String>(
        originCountryNormalized,
      );
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || regionNormalized != null) {
      map['region_normalized'] = Variable<String>(regionNormalized);
    }
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || producerNormalized != null) {
      map['producer_normalized'] = Variable<String>(producerNormalized);
    }
    if (!nullToAbsent || process != null) {
      map['process'] = Variable<String>(process);
    }
    if (!nullToAbsent || processNormalized != null) {
      map['process_normalized'] = Variable<String>(processNormalized);
    }
    if (!nullToAbsent || originCountryCode != null) {
      map['origin_country_code'] = Variable<String>(originCountryCode);
    }
    if (!nullToAbsent || roastLevelKey != null) {
      map['roast_level_key'] = Variable<String>(roastLevelKey);
    }
    if (!nullToAbsent || roastLevelCustom != null) {
      map['roast_level_custom'] = Variable<String>(roastLevelCustom);
    }
    if (!nullToAbsent || altitudeMinMeters != null) {
      map['altitude_min_meters'] = Variable<int>(altitudeMinMeters);
    }
    if (!nullToAbsent || altitudeMaxMeters != null) {
      map['altitude_max_meters'] = Variable<int>(altitudeMaxMeters);
    }
    if (!nullToAbsent || altitudeSourceText != null) {
      map['altitude_source_text'] = Variable<String>(altitudeSourceText);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<String>(roastDate);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<String>(purchaseDate);
    }
    if (!nullToAbsent || packageWeightGrams != null) {
      map['package_weight_grams'] = Variable<int>(packageWeightGrams);
    }
    if (!nullToAbsent || personalNote != null) {
      map['personal_note'] = Variable<String>(personalNote);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['revision'] = Variable<int>(revision);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  CoffeesCompanion toCompanion(bool nullToAbsent) {
    return CoffeesCompanion(
      id: Value(id),
      name: Value(name),
      nameNormalized: Value(nameNormalized),
      roastery: Value(roastery),
      roasteryNormalized: Value(roasteryNormalized),
      originCountry: originCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountry),
      originCountryNormalized: originCountryNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountryNormalized),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      regionNormalized: regionNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(regionNormalized),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      producerNormalized: producerNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(producerNormalized),
      process: process == null && nullToAbsent
          ? const Value.absent()
          : Value(process),
      processNormalized: processNormalized == null && nullToAbsent
          ? const Value.absent()
          : Value(processNormalized),
      originCountryCode: originCountryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountryCode),
      roastLevelKey: roastLevelKey == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevelKey),
      roastLevelCustom: roastLevelCustom == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevelCustom),
      altitudeMinMeters: altitudeMinMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMinMeters),
      altitudeMaxMeters: altitudeMaxMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMaxMeters),
      altitudeSourceText: altitudeSourceText == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeSourceText),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      packageWeightGrams: packageWeightGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(packageWeightGrams),
      personalNote: personalNote == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNote),
      isFavorite: Value(isFavorite),
      revision: Value(revision),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CoffeeRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameNormalized: serializer.fromJson<String>(json['nameNormalized']),
      roastery: serializer.fromJson<String>(json['roastery']),
      roasteryNormalized: serializer.fromJson<String>(
        json['roasteryNormalized'],
      ),
      originCountry: serializer.fromJson<String?>(json['originCountry']),
      originCountryNormalized: serializer.fromJson<String?>(
        json['originCountryNormalized'],
      ),
      region: serializer.fromJson<String?>(json['region']),
      regionNormalized: serializer.fromJson<String?>(json['regionNormalized']),
      producer: serializer.fromJson<String?>(json['producer']),
      producerNormalized: serializer.fromJson<String?>(
        json['producerNormalized'],
      ),
      process: serializer.fromJson<String?>(json['process']),
      processNormalized: serializer.fromJson<String?>(
        json['processNormalized'],
      ),
      originCountryCode: serializer.fromJson<String?>(
        json['originCountryCode'],
      ),
      roastLevelKey: serializer.fromJson<String?>(json['roastLevelKey']),
      roastLevelCustom: serializer.fromJson<String?>(json['roastLevelCustom']),
      altitudeMinMeters: serializer.fromJson<int?>(json['altitudeMinMeters']),
      altitudeMaxMeters: serializer.fromJson<int?>(json['altitudeMaxMeters']),
      altitudeSourceText: serializer.fromJson<String?>(
        json['altitudeSourceText'],
      ),
      roastDate: serializer.fromJson<String?>(json['roastDate']),
      purchaseDate: serializer.fromJson<String?>(json['purchaseDate']),
      packageWeightGrams: serializer.fromJson<int?>(json['packageWeightGrams']),
      personalNote: serializer.fromJson<String?>(json['personalNote']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      revision: serializer.fromJson<int>(json['revision']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'nameNormalized': serializer.toJson<String>(nameNormalized),
      'roastery': serializer.toJson<String>(roastery),
      'roasteryNormalized': serializer.toJson<String>(roasteryNormalized),
      'originCountry': serializer.toJson<String?>(originCountry),
      'originCountryNormalized': serializer.toJson<String?>(
        originCountryNormalized,
      ),
      'region': serializer.toJson<String?>(region),
      'regionNormalized': serializer.toJson<String?>(regionNormalized),
      'producer': serializer.toJson<String?>(producer),
      'producerNormalized': serializer.toJson<String?>(producerNormalized),
      'process': serializer.toJson<String?>(process),
      'processNormalized': serializer.toJson<String?>(processNormalized),
      'originCountryCode': serializer.toJson<String?>(originCountryCode),
      'roastLevelKey': serializer.toJson<String?>(roastLevelKey),
      'roastLevelCustom': serializer.toJson<String?>(roastLevelCustom),
      'altitudeMinMeters': serializer.toJson<int?>(altitudeMinMeters),
      'altitudeMaxMeters': serializer.toJson<int?>(altitudeMaxMeters),
      'altitudeSourceText': serializer.toJson<String?>(altitudeSourceText),
      'roastDate': serializer.toJson<String?>(roastDate),
      'purchaseDate': serializer.toJson<String?>(purchaseDate),
      'packageWeightGrams': serializer.toJson<int?>(packageWeightGrams),
      'personalNote': serializer.toJson<String?>(personalNote),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'revision': serializer.toJson<int>(revision),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  CoffeeRecord copyWith({
    String? id,
    String? name,
    String? nameNormalized,
    String? roastery,
    String? roasteryNormalized,
    Value<String?> originCountry = const Value.absent(),
    Value<String?> originCountryNormalized = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> regionNormalized = const Value.absent(),
    Value<String?> producer = const Value.absent(),
    Value<String?> producerNormalized = const Value.absent(),
    Value<String?> process = const Value.absent(),
    Value<String?> processNormalized = const Value.absent(),
    Value<String?> originCountryCode = const Value.absent(),
    Value<String?> roastLevelKey = const Value.absent(),
    Value<String?> roastLevelCustom = const Value.absent(),
    Value<int?> altitudeMinMeters = const Value.absent(),
    Value<int?> altitudeMaxMeters = const Value.absent(),
    Value<String?> altitudeSourceText = const Value.absent(),
    Value<String?> roastDate = const Value.absent(),
    Value<String?> purchaseDate = const Value.absent(),
    Value<int?> packageWeightGrams = const Value.absent(),
    Value<String?> personalNote = const Value.absent(),
    bool? isFavorite,
    int? revision,
    int? createdAt,
    int? updatedAt,
  }) => CoffeeRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    nameNormalized: nameNormalized ?? this.nameNormalized,
    roastery: roastery ?? this.roastery,
    roasteryNormalized: roasteryNormalized ?? this.roasteryNormalized,
    originCountry: originCountry.present
        ? originCountry.value
        : this.originCountry,
    originCountryNormalized: originCountryNormalized.present
        ? originCountryNormalized.value
        : this.originCountryNormalized,
    region: region.present ? region.value : this.region,
    regionNormalized: regionNormalized.present
        ? regionNormalized.value
        : this.regionNormalized,
    producer: producer.present ? producer.value : this.producer,
    producerNormalized: producerNormalized.present
        ? producerNormalized.value
        : this.producerNormalized,
    process: process.present ? process.value : this.process,
    processNormalized: processNormalized.present
        ? processNormalized.value
        : this.processNormalized,
    originCountryCode: originCountryCode.present
        ? originCountryCode.value
        : this.originCountryCode,
    roastLevelKey: roastLevelKey.present
        ? roastLevelKey.value
        : this.roastLevelKey,
    roastLevelCustom: roastLevelCustom.present
        ? roastLevelCustom.value
        : this.roastLevelCustom,
    altitudeMinMeters: altitudeMinMeters.present
        ? altitudeMinMeters.value
        : this.altitudeMinMeters,
    altitudeMaxMeters: altitudeMaxMeters.present
        ? altitudeMaxMeters.value
        : this.altitudeMaxMeters,
    altitudeSourceText: altitudeSourceText.present
        ? altitudeSourceText.value
        : this.altitudeSourceText,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    packageWeightGrams: packageWeightGrams.present
        ? packageWeightGrams.value
        : this.packageWeightGrams,
    personalNote: personalNote.present ? personalNote.value : this.personalNote,
    isFavorite: isFavorite ?? this.isFavorite,
    revision: revision ?? this.revision,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CoffeeRecord copyWithCompanion(CoffeesCompanion data) {
    return CoffeeRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameNormalized: data.nameNormalized.present
          ? data.nameNormalized.value
          : this.nameNormalized,
      roastery: data.roastery.present ? data.roastery.value : this.roastery,
      roasteryNormalized: data.roasteryNormalized.present
          ? data.roasteryNormalized.value
          : this.roasteryNormalized,
      originCountry: data.originCountry.present
          ? data.originCountry.value
          : this.originCountry,
      originCountryNormalized: data.originCountryNormalized.present
          ? data.originCountryNormalized.value
          : this.originCountryNormalized,
      region: data.region.present ? data.region.value : this.region,
      regionNormalized: data.regionNormalized.present
          ? data.regionNormalized.value
          : this.regionNormalized,
      producer: data.producer.present ? data.producer.value : this.producer,
      producerNormalized: data.producerNormalized.present
          ? data.producerNormalized.value
          : this.producerNormalized,
      process: data.process.present ? data.process.value : this.process,
      processNormalized: data.processNormalized.present
          ? data.processNormalized.value
          : this.processNormalized,
      originCountryCode: data.originCountryCode.present
          ? data.originCountryCode.value
          : this.originCountryCode,
      roastLevelKey: data.roastLevelKey.present
          ? data.roastLevelKey.value
          : this.roastLevelKey,
      roastLevelCustom: data.roastLevelCustom.present
          ? data.roastLevelCustom.value
          : this.roastLevelCustom,
      altitudeMinMeters: data.altitudeMinMeters.present
          ? data.altitudeMinMeters.value
          : this.altitudeMinMeters,
      altitudeMaxMeters: data.altitudeMaxMeters.present
          ? data.altitudeMaxMeters.value
          : this.altitudeMaxMeters,
      altitudeSourceText: data.altitudeSourceText.present
          ? data.altitudeSourceText.value
          : this.altitudeSourceText,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      packageWeightGrams: data.packageWeightGrams.present
          ? data.packageWeightGrams.value
          : this.packageWeightGrams,
      personalNote: data.personalNote.present
          ? data.personalNote.value
          : this.personalNote,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      revision: data.revision.present ? data.revision.value : this.revision,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('roastery: $roastery, ')
          ..write('roasteryNormalized: $roasteryNormalized, ')
          ..write('originCountry: $originCountry, ')
          ..write('originCountryNormalized: $originCountryNormalized, ')
          ..write('region: $region, ')
          ..write('regionNormalized: $regionNormalized, ')
          ..write('producer: $producer, ')
          ..write('producerNormalized: $producerNormalized, ')
          ..write('process: $process, ')
          ..write('processNormalized: $processNormalized, ')
          ..write('originCountryCode: $originCountryCode, ')
          ..write('roastLevelKey: $roastLevelKey, ')
          ..write('roastLevelCustom: $roastLevelCustom, ')
          ..write('altitudeMinMeters: $altitudeMinMeters, ')
          ..write('altitudeMaxMeters: $altitudeMaxMeters, ')
          ..write('altitudeSourceText: $altitudeSourceText, ')
          ..write('roastDate: $roastDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageWeightGrams: $packageWeightGrams, ')
          ..write('personalNote: $personalNote, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('revision: $revision, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    nameNormalized,
    roastery,
    roasteryNormalized,
    originCountry,
    originCountryNormalized,
    region,
    regionNormalized,
    producer,
    producerNormalized,
    process,
    processNormalized,
    originCountryCode,
    roastLevelKey,
    roastLevelCustom,
    altitudeMinMeters,
    altitudeMaxMeters,
    altitudeSourceText,
    roastDate,
    purchaseDate,
    packageWeightGrams,
    personalNote,
    isFavorite,
    revision,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameNormalized == this.nameNormalized &&
          other.roastery == this.roastery &&
          other.roasteryNormalized == this.roasteryNormalized &&
          other.originCountry == this.originCountry &&
          other.originCountryNormalized == this.originCountryNormalized &&
          other.region == this.region &&
          other.regionNormalized == this.regionNormalized &&
          other.producer == this.producer &&
          other.producerNormalized == this.producerNormalized &&
          other.process == this.process &&
          other.processNormalized == this.processNormalized &&
          other.originCountryCode == this.originCountryCode &&
          other.roastLevelKey == this.roastLevelKey &&
          other.roastLevelCustom == this.roastLevelCustom &&
          other.altitudeMinMeters == this.altitudeMinMeters &&
          other.altitudeMaxMeters == this.altitudeMaxMeters &&
          other.altitudeSourceText == this.altitudeSourceText &&
          other.roastDate == this.roastDate &&
          other.purchaseDate == this.purchaseDate &&
          other.packageWeightGrams == this.packageWeightGrams &&
          other.personalNote == this.personalNote &&
          other.isFavorite == this.isFavorite &&
          other.revision == this.revision &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CoffeesCompanion extends UpdateCompanion<CoffeeRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> nameNormalized;
  final Value<String> roastery;
  final Value<String> roasteryNormalized;
  final Value<String?> originCountry;
  final Value<String?> originCountryNormalized;
  final Value<String?> region;
  final Value<String?> regionNormalized;
  final Value<String?> producer;
  final Value<String?> producerNormalized;
  final Value<String?> process;
  final Value<String?> processNormalized;
  final Value<String?> originCountryCode;
  final Value<String?> roastLevelKey;
  final Value<String?> roastLevelCustom;
  final Value<int?> altitudeMinMeters;
  final Value<int?> altitudeMaxMeters;
  final Value<String?> altitudeSourceText;
  final Value<String?> roastDate;
  final Value<String?> purchaseDate;
  final Value<int?> packageWeightGrams;
  final Value<String?> personalNote;
  final Value<bool> isFavorite;
  final Value<int> revision;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const CoffeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameNormalized = const Value.absent(),
    this.roastery = const Value.absent(),
    this.roasteryNormalized = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.originCountryNormalized = const Value.absent(),
    this.region = const Value.absent(),
    this.regionNormalized = const Value.absent(),
    this.producer = const Value.absent(),
    this.producerNormalized = const Value.absent(),
    this.process = const Value.absent(),
    this.processNormalized = const Value.absent(),
    this.originCountryCode = const Value.absent(),
    this.roastLevelKey = const Value.absent(),
    this.roastLevelCustom = const Value.absent(),
    this.altitudeMinMeters = const Value.absent(),
    this.altitudeMaxMeters = const Value.absent(),
    this.altitudeSourceText = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageWeightGrams = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.revision = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeesCompanion.insert({
    required String id,
    required String name,
    required String nameNormalized,
    required String roastery,
    required String roasteryNormalized,
    this.originCountry = const Value.absent(),
    this.originCountryNormalized = const Value.absent(),
    this.region = const Value.absent(),
    this.regionNormalized = const Value.absent(),
    this.producer = const Value.absent(),
    this.producerNormalized = const Value.absent(),
    this.process = const Value.absent(),
    this.processNormalized = const Value.absent(),
    this.originCountryCode = const Value.absent(),
    this.roastLevelKey = const Value.absent(),
    this.roastLevelCustom = const Value.absent(),
    this.altitudeMinMeters = const Value.absent(),
    this.altitudeMaxMeters = const Value.absent(),
    this.altitudeSourceText = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageWeightGrams = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.revision = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       nameNormalized = Value(nameNormalized),
       roastery = Value(roastery),
       roasteryNormalized = Value(roasteryNormalized),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CoffeeRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? nameNormalized,
    Expression<String>? roastery,
    Expression<String>? roasteryNormalized,
    Expression<String>? originCountry,
    Expression<String>? originCountryNormalized,
    Expression<String>? region,
    Expression<String>? regionNormalized,
    Expression<String>? producer,
    Expression<String>? producerNormalized,
    Expression<String>? process,
    Expression<String>? processNormalized,
    Expression<String>? originCountryCode,
    Expression<String>? roastLevelKey,
    Expression<String>? roastLevelCustom,
    Expression<int>? altitudeMinMeters,
    Expression<int>? altitudeMaxMeters,
    Expression<String>? altitudeSourceText,
    Expression<String>? roastDate,
    Expression<String>? purchaseDate,
    Expression<int>? packageWeightGrams,
    Expression<String>? personalNote,
    Expression<bool>? isFavorite,
    Expression<int>? revision,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameNormalized != null) 'name_normalized': nameNormalized,
      if (roastery != null) 'roastery': roastery,
      if (roasteryNormalized != null) 'roastery_normalized': roasteryNormalized,
      if (originCountry != null) 'origin_country': originCountry,
      if (originCountryNormalized != null)
        'origin_country_normalized': originCountryNormalized,
      if (region != null) 'region': region,
      if (regionNormalized != null) 'region_normalized': regionNormalized,
      if (producer != null) 'producer': producer,
      if (producerNormalized != null) 'producer_normalized': producerNormalized,
      if (process != null) 'process': process,
      if (processNormalized != null) 'process_normalized': processNormalized,
      if (originCountryCode != null) 'origin_country_code': originCountryCode,
      if (roastLevelKey != null) 'roast_level_key': roastLevelKey,
      if (roastLevelCustom != null) 'roast_level_custom': roastLevelCustom,
      if (altitudeMinMeters != null) 'altitude_min_meters': altitudeMinMeters,
      if (altitudeMaxMeters != null) 'altitude_max_meters': altitudeMaxMeters,
      if (altitudeSourceText != null)
        'altitude_source_text': altitudeSourceText,
      if (roastDate != null) 'roast_date': roastDate,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (packageWeightGrams != null)
        'package_weight_grams': packageWeightGrams,
      if (personalNote != null) 'personal_note': personalNote,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (revision != null) 'revision': revision,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? nameNormalized,
    Value<String>? roastery,
    Value<String>? roasteryNormalized,
    Value<String?>? originCountry,
    Value<String?>? originCountryNormalized,
    Value<String?>? region,
    Value<String?>? regionNormalized,
    Value<String?>? producer,
    Value<String?>? producerNormalized,
    Value<String?>? process,
    Value<String?>? processNormalized,
    Value<String?>? originCountryCode,
    Value<String?>? roastLevelKey,
    Value<String?>? roastLevelCustom,
    Value<int?>? altitudeMinMeters,
    Value<int?>? altitudeMaxMeters,
    Value<String?>? altitudeSourceText,
    Value<String?>? roastDate,
    Value<String?>? purchaseDate,
    Value<int?>? packageWeightGrams,
    Value<String?>? personalNote,
    Value<bool>? isFavorite,
    Value<int>? revision,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return CoffeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameNormalized: nameNormalized ?? this.nameNormalized,
      roastery: roastery ?? this.roastery,
      roasteryNormalized: roasteryNormalized ?? this.roasteryNormalized,
      originCountry: originCountry ?? this.originCountry,
      originCountryNormalized:
          originCountryNormalized ?? this.originCountryNormalized,
      region: region ?? this.region,
      regionNormalized: regionNormalized ?? this.regionNormalized,
      producer: producer ?? this.producer,
      producerNormalized: producerNormalized ?? this.producerNormalized,
      process: process ?? this.process,
      processNormalized: processNormalized ?? this.processNormalized,
      originCountryCode: originCountryCode ?? this.originCountryCode,
      roastLevelKey: roastLevelKey ?? this.roastLevelKey,
      roastLevelCustom: roastLevelCustom ?? this.roastLevelCustom,
      altitudeMinMeters: altitudeMinMeters ?? this.altitudeMinMeters,
      altitudeMaxMeters: altitudeMaxMeters ?? this.altitudeMaxMeters,
      altitudeSourceText: altitudeSourceText ?? this.altitudeSourceText,
      roastDate: roastDate ?? this.roastDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      packageWeightGrams: packageWeightGrams ?? this.packageWeightGrams,
      personalNote: personalNote ?? this.personalNote,
      isFavorite: isFavorite ?? this.isFavorite,
      revision: revision ?? this.revision,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameNormalized.present) {
      map['name_normalized'] = Variable<String>(nameNormalized.value);
    }
    if (roastery.present) {
      map['roastery'] = Variable<String>(roastery.value);
    }
    if (roasteryNormalized.present) {
      map['roastery_normalized'] = Variable<String>(roasteryNormalized.value);
    }
    if (originCountry.present) {
      map['origin_country'] = Variable<String>(originCountry.value);
    }
    if (originCountryNormalized.present) {
      map['origin_country_normalized'] = Variable<String>(
        originCountryNormalized.value,
      );
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (regionNormalized.present) {
      map['region_normalized'] = Variable<String>(regionNormalized.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (producerNormalized.present) {
      map['producer_normalized'] = Variable<String>(producerNormalized.value);
    }
    if (process.present) {
      map['process'] = Variable<String>(process.value);
    }
    if (processNormalized.present) {
      map['process_normalized'] = Variable<String>(processNormalized.value);
    }
    if (originCountryCode.present) {
      map['origin_country_code'] = Variable<String>(originCountryCode.value);
    }
    if (roastLevelKey.present) {
      map['roast_level_key'] = Variable<String>(roastLevelKey.value);
    }
    if (roastLevelCustom.present) {
      map['roast_level_custom'] = Variable<String>(roastLevelCustom.value);
    }
    if (altitudeMinMeters.present) {
      map['altitude_min_meters'] = Variable<int>(altitudeMinMeters.value);
    }
    if (altitudeMaxMeters.present) {
      map['altitude_max_meters'] = Variable<int>(altitudeMaxMeters.value);
    }
    if (altitudeSourceText.present) {
      map['altitude_source_text'] = Variable<String>(altitudeSourceText.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<String>(roastDate.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<String>(purchaseDate.value);
    }
    if (packageWeightGrams.present) {
      map['package_weight_grams'] = Variable<int>(packageWeightGrams.value);
    }
    if (personalNote.present) {
      map['personal_note'] = Variable<String>(personalNote.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('roastery: $roastery, ')
          ..write('roasteryNormalized: $roasteryNormalized, ')
          ..write('originCountry: $originCountry, ')
          ..write('originCountryNormalized: $originCountryNormalized, ')
          ..write('region: $region, ')
          ..write('regionNormalized: $regionNormalized, ')
          ..write('producer: $producer, ')
          ..write('producerNormalized: $producerNormalized, ')
          ..write('process: $process, ')
          ..write('processNormalized: $processNormalized, ')
          ..write('originCountryCode: $originCountryCode, ')
          ..write('roastLevelKey: $roastLevelKey, ')
          ..write('roastLevelCustom: $roastLevelCustom, ')
          ..write('altitudeMinMeters: $altitudeMinMeters, ')
          ..write('altitudeMaxMeters: $altitudeMaxMeters, ')
          ..write('altitudeSourceText: $altitudeSourceText, ')
          ..write('roastDate: $roastDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageWeightGrams: $packageWeightGrams, ')
          ..write('personalNote: $personalNote, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('revision: $revision, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _brewedAtMeta = const VerificationMeta(
    'brewedAt',
  );
  @override
  late final GeneratedColumn<int> brewedAt = GeneratedColumn<int>(
    'brewed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brewedAtOffsetMinutesMeta =
      const VerificationMeta('brewedAtOffsetMinutes');
  @override
  late final GeneratedColumn<int> brewedAtOffsetMinutes = GeneratedColumn<int>(
    'brewed_at_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brewMethodKeyMeta = const VerificationMeta(
    'brewMethodKey',
  );
  @override
  late final GeneratedColumn<String> brewMethodKey = GeneratedColumn<String>(
    'brew_method_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brewMethodCustomMeta = const VerificationMeta(
    'brewMethodCustom',
  );
  @override
  late final GeneratedColumn<String> brewMethodCustom = GeneratedColumn<String>(
    'brew_method_custom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doseMilligramsMeta = const VerificationMeta(
    'doseMilligrams',
  );
  @override
  late final GeneratedColumn<int> doseMilligrams = GeneratedColumn<int>(
    'dose_milligrams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterMilligramsMeta = const VerificationMeta(
    'waterMilligrams',
  );
  @override
  late final GeneratedColumn<int> waterMilligrams = GeneratedColumn<int>(
    'water_milligrams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterTemperatureDeciCelsiusMeta =
      const VerificationMeta('waterTemperatureDeciCelsius');
  @override
  late final GeneratedColumn<int> waterTemperatureDeciCelsius =
      GeneratedColumn<int>(
        'water_temperature_deci_celsius',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _grindSizeMeta = const VerificationMeta(
    'grindSize',
  );
  @override
  late final GeneratedColumn<String> grindSize = GeneratedColumn<String>(
    'grind_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brewTimeSecondsMeta = const VerificationMeta(
    'brewTimeSeconds',
  );
  @override
  late final GeneratedColumn<int> brewTimeSeconds = GeneratedColumn<int>(
    'brew_time_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeId,
    brewedAt,
    brewedAtOffsetMinutes,
    brewMethodKey,
    brewMethodCustom,
    doseMilligrams,
    waterMilligrams,
    waterTemperatureDeciCelsius,
    grindSize,
    brewTimeSeconds,
    rating,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('brewed_at')) {
      context.handle(
        _brewedAtMeta,
        brewedAt.isAcceptableOrUnknown(data['brewed_at']!, _brewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_brewedAtMeta);
    }
    if (data.containsKey('brewed_at_offset_minutes')) {
      context.handle(
        _brewedAtOffsetMinutesMeta,
        brewedAtOffsetMinutes.isAcceptableOrUnknown(
          data['brewed_at_offset_minutes']!,
          _brewedAtOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_brewedAtOffsetMinutesMeta);
    }
    if (data.containsKey('brew_method_key')) {
      context.handle(
        _brewMethodKeyMeta,
        brewMethodKey.isAcceptableOrUnknown(
          data['brew_method_key']!,
          _brewMethodKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_brewMethodKeyMeta);
    }
    if (data.containsKey('brew_method_custom')) {
      context.handle(
        _brewMethodCustomMeta,
        brewMethodCustom.isAcceptableOrUnknown(
          data['brew_method_custom']!,
          _brewMethodCustomMeta,
        ),
      );
    }
    if (data.containsKey('dose_milligrams')) {
      context.handle(
        _doseMilligramsMeta,
        doseMilligrams.isAcceptableOrUnknown(
          data['dose_milligrams']!,
          _doseMilligramsMeta,
        ),
      );
    }
    if (data.containsKey('water_milligrams')) {
      context.handle(
        _waterMilligramsMeta,
        waterMilligrams.isAcceptableOrUnknown(
          data['water_milligrams']!,
          _waterMilligramsMeta,
        ),
      );
    }
    if (data.containsKey('water_temperature_deci_celsius')) {
      context.handle(
        _waterTemperatureDeciCelsiusMeta,
        waterTemperatureDeciCelsius.isAcceptableOrUnknown(
          data['water_temperature_deci_celsius']!,
          _waterTemperatureDeciCelsiusMeta,
        ),
      );
    }
    if (data.containsKey('grind_size')) {
      context.handle(
        _grindSizeMeta,
        grindSize.isAcceptableOrUnknown(data['grind_size']!, _grindSizeMeta),
      );
    }
    if (data.containsKey('brew_time_seconds')) {
      context.handle(
        _brewTimeSecondsMeta,
        brewTimeSeconds.isAcceptableOrUnknown(
          data['brew_time_seconds']!,
          _brewTimeSecondsMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      brewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brewed_at'],
      )!,
      brewedAtOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brewed_at_offset_minutes'],
      )!,
      brewMethodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brew_method_key'],
      )!,
      brewMethodCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brew_method_custom'],
      ),
      doseMilligrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dose_milligrams'],
      ),
      waterMilligrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_milligrams'],
      ),
      waterTemperatureDeciCelsius: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_temperature_deci_celsius'],
      ),
      grindSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grind_size'],
      ),
      brewTimeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brew_time_seconds'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalRecord extends DataClass implements Insertable<JournalRecord> {
  final String id;
  final String coffeeId;
  final int brewedAt;
  final int brewedAtOffsetMinutes;
  final String brewMethodKey;
  final String? brewMethodCustom;
  final int? doseMilligrams;
  final int? waterMilligrams;
  final int? waterTemperatureDeciCelsius;
  final String? grindSize;
  final int? brewTimeSeconds;
  final int? rating;
  final String? note;
  final int createdAt;
  final int updatedAt;
  const JournalRecord({
    required this.id,
    required this.coffeeId,
    required this.brewedAt,
    required this.brewedAtOffsetMinutes,
    required this.brewMethodKey,
    this.brewMethodCustom,
    this.doseMilligrams,
    this.waterMilligrams,
    this.waterTemperatureDeciCelsius,
    this.grindSize,
    this.brewTimeSeconds,
    this.rating,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_id'] = Variable<String>(coffeeId);
    map['brewed_at'] = Variable<int>(brewedAt);
    map['brewed_at_offset_minutes'] = Variable<int>(brewedAtOffsetMinutes);
    map['brew_method_key'] = Variable<String>(brewMethodKey);
    if (!nullToAbsent || brewMethodCustom != null) {
      map['brew_method_custom'] = Variable<String>(brewMethodCustom);
    }
    if (!nullToAbsent || doseMilligrams != null) {
      map['dose_milligrams'] = Variable<int>(doseMilligrams);
    }
    if (!nullToAbsent || waterMilligrams != null) {
      map['water_milligrams'] = Variable<int>(waterMilligrams);
    }
    if (!nullToAbsent || waterTemperatureDeciCelsius != null) {
      map['water_temperature_deci_celsius'] = Variable<int>(
        waterTemperatureDeciCelsius,
      );
    }
    if (!nullToAbsent || grindSize != null) {
      map['grind_size'] = Variable<String>(grindSize);
    }
    if (!nullToAbsent || brewTimeSeconds != null) {
      map['brew_time_seconds'] = Variable<int>(brewTimeSeconds);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      coffeeId: Value(coffeeId),
      brewedAt: Value(brewedAt),
      brewedAtOffsetMinutes: Value(brewedAtOffsetMinutes),
      brewMethodKey: Value(brewMethodKey),
      brewMethodCustom: brewMethodCustom == null && nullToAbsent
          ? const Value.absent()
          : Value(brewMethodCustom),
      doseMilligrams: doseMilligrams == null && nullToAbsent
          ? const Value.absent()
          : Value(doseMilligrams),
      waterMilligrams: waterMilligrams == null && nullToAbsent
          ? const Value.absent()
          : Value(waterMilligrams),
      waterTemperatureDeciCelsius:
          waterTemperatureDeciCelsius == null && nullToAbsent
          ? const Value.absent()
          : Value(waterTemperatureDeciCelsius),
      grindSize: grindSize == null && nullToAbsent
          ? const Value.absent()
          : Value(grindSize),
      brewTimeSeconds: brewTimeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(brewTimeSeconds),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory JournalRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      brewedAt: serializer.fromJson<int>(json['brewedAt']),
      brewedAtOffsetMinutes: serializer.fromJson<int>(
        json['brewedAtOffsetMinutes'],
      ),
      brewMethodKey: serializer.fromJson<String>(json['brewMethodKey']),
      brewMethodCustom: serializer.fromJson<String?>(json['brewMethodCustom']),
      doseMilligrams: serializer.fromJson<int?>(json['doseMilligrams']),
      waterMilligrams: serializer.fromJson<int?>(json['waterMilligrams']),
      waterTemperatureDeciCelsius: serializer.fromJson<int?>(
        json['waterTemperatureDeciCelsius'],
      ),
      grindSize: serializer.fromJson<String?>(json['grindSize']),
      brewTimeSeconds: serializer.fromJson<int?>(json['brewTimeSeconds']),
      rating: serializer.fromJson<int?>(json['rating']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeId': serializer.toJson<String>(coffeeId),
      'brewedAt': serializer.toJson<int>(brewedAt),
      'brewedAtOffsetMinutes': serializer.toJson<int>(brewedAtOffsetMinutes),
      'brewMethodKey': serializer.toJson<String>(brewMethodKey),
      'brewMethodCustom': serializer.toJson<String?>(brewMethodCustom),
      'doseMilligrams': serializer.toJson<int?>(doseMilligrams),
      'waterMilligrams': serializer.toJson<int?>(waterMilligrams),
      'waterTemperatureDeciCelsius': serializer.toJson<int?>(
        waterTemperatureDeciCelsius,
      ),
      'grindSize': serializer.toJson<String?>(grindSize),
      'brewTimeSeconds': serializer.toJson<int?>(brewTimeSeconds),
      'rating': serializer.toJson<int?>(rating),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  JournalRecord copyWith({
    String? id,
    String? coffeeId,
    int? brewedAt,
    int? brewedAtOffsetMinutes,
    String? brewMethodKey,
    Value<String?> brewMethodCustom = const Value.absent(),
    Value<int?> doseMilligrams = const Value.absent(),
    Value<int?> waterMilligrams = const Value.absent(),
    Value<int?> waterTemperatureDeciCelsius = const Value.absent(),
    Value<String?> grindSize = const Value.absent(),
    Value<int?> brewTimeSeconds = const Value.absent(),
    Value<int?> rating = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => JournalRecord(
    id: id ?? this.id,
    coffeeId: coffeeId ?? this.coffeeId,
    brewedAt: brewedAt ?? this.brewedAt,
    brewedAtOffsetMinutes: brewedAtOffsetMinutes ?? this.brewedAtOffsetMinutes,
    brewMethodKey: brewMethodKey ?? this.brewMethodKey,
    brewMethodCustom: brewMethodCustom.present
        ? brewMethodCustom.value
        : this.brewMethodCustom,
    doseMilligrams: doseMilligrams.present
        ? doseMilligrams.value
        : this.doseMilligrams,
    waterMilligrams: waterMilligrams.present
        ? waterMilligrams.value
        : this.waterMilligrams,
    waterTemperatureDeciCelsius: waterTemperatureDeciCelsius.present
        ? waterTemperatureDeciCelsius.value
        : this.waterTemperatureDeciCelsius,
    grindSize: grindSize.present ? grindSize.value : this.grindSize,
    brewTimeSeconds: brewTimeSeconds.present
        ? brewTimeSeconds.value
        : this.brewTimeSeconds,
    rating: rating.present ? rating.value : this.rating,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  JournalRecord copyWithCompanion(JournalEntriesCompanion data) {
    return JournalRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      brewedAt: data.brewedAt.present ? data.brewedAt.value : this.brewedAt,
      brewedAtOffsetMinutes: data.brewedAtOffsetMinutes.present
          ? data.brewedAtOffsetMinutes.value
          : this.brewedAtOffsetMinutes,
      brewMethodKey: data.brewMethodKey.present
          ? data.brewMethodKey.value
          : this.brewMethodKey,
      brewMethodCustom: data.brewMethodCustom.present
          ? data.brewMethodCustom.value
          : this.brewMethodCustom,
      doseMilligrams: data.doseMilligrams.present
          ? data.doseMilligrams.value
          : this.doseMilligrams,
      waterMilligrams: data.waterMilligrams.present
          ? data.waterMilligrams.value
          : this.waterMilligrams,
      waterTemperatureDeciCelsius: data.waterTemperatureDeciCelsius.present
          ? data.waterTemperatureDeciCelsius.value
          : this.waterTemperatureDeciCelsius,
      grindSize: data.grindSize.present ? data.grindSize.value : this.grindSize,
      brewTimeSeconds: data.brewTimeSeconds.present
          ? data.brewTimeSeconds.value
          : this.brewTimeSeconds,
      rating: data.rating.present ? data.rating.value : this.rating,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalRecord(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewedAt: $brewedAt, ')
          ..write('brewedAtOffsetMinutes: $brewedAtOffsetMinutes, ')
          ..write('brewMethodKey: $brewMethodKey, ')
          ..write('brewMethodCustom: $brewMethodCustom, ')
          ..write('doseMilligrams: $doseMilligrams, ')
          ..write('waterMilligrams: $waterMilligrams, ')
          ..write('waterTemperatureDeciCelsius: $waterTemperatureDeciCelsius, ')
          ..write('grindSize: $grindSize, ')
          ..write('brewTimeSeconds: $brewTimeSeconds, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeId,
    brewedAt,
    brewedAtOffsetMinutes,
    brewMethodKey,
    brewMethodCustom,
    doseMilligrams,
    waterMilligrams,
    waterTemperatureDeciCelsius,
    grindSize,
    brewTimeSeconds,
    rating,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalRecord &&
          other.id == this.id &&
          other.coffeeId == this.coffeeId &&
          other.brewedAt == this.brewedAt &&
          other.brewedAtOffsetMinutes == this.brewedAtOffsetMinutes &&
          other.brewMethodKey == this.brewMethodKey &&
          other.brewMethodCustom == this.brewMethodCustom &&
          other.doseMilligrams == this.doseMilligrams &&
          other.waterMilligrams == this.waterMilligrams &&
          other.waterTemperatureDeciCelsius ==
              this.waterTemperatureDeciCelsius &&
          other.grindSize == this.grindSize &&
          other.brewTimeSeconds == this.brewTimeSeconds &&
          other.rating == this.rating &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalRecord> {
  final Value<String> id;
  final Value<String> coffeeId;
  final Value<int> brewedAt;
  final Value<int> brewedAtOffsetMinutes;
  final Value<String> brewMethodKey;
  final Value<String?> brewMethodCustom;
  final Value<int?> doseMilligrams;
  final Value<int?> waterMilligrams;
  final Value<int?> waterTemperatureDeciCelsius;
  final Value<String?> grindSize;
  final Value<int?> brewTimeSeconds;
  final Value<int?> rating;
  final Value<String?> note;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.brewedAt = const Value.absent(),
    this.brewedAtOffsetMinutes = const Value.absent(),
    this.brewMethodKey = const Value.absent(),
    this.brewMethodCustom = const Value.absent(),
    this.doseMilligrams = const Value.absent(),
    this.waterMilligrams = const Value.absent(),
    this.waterTemperatureDeciCelsius = const Value.absent(),
    this.grindSize = const Value.absent(),
    this.brewTimeSeconds = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String coffeeId,
    required int brewedAt,
    required int brewedAtOffsetMinutes,
    required String brewMethodKey,
    this.brewMethodCustom = const Value.absent(),
    this.doseMilligrams = const Value.absent(),
    this.waterMilligrams = const Value.absent(),
    this.waterTemperatureDeciCelsius = const Value.absent(),
    this.grindSize = const Value.absent(),
    this.brewTimeSeconds = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeId = Value(coffeeId),
       brewedAt = Value(brewedAt),
       brewedAtOffsetMinutes = Value(brewedAtOffsetMinutes),
       brewMethodKey = Value(brewMethodKey),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<JournalRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeId,
    Expression<int>? brewedAt,
    Expression<int>? brewedAtOffsetMinutes,
    Expression<String>? brewMethodKey,
    Expression<String>? brewMethodCustom,
    Expression<int>? doseMilligrams,
    Expression<int>? waterMilligrams,
    Expression<int>? waterTemperatureDeciCelsius,
    Expression<String>? grindSize,
    Expression<int>? brewTimeSeconds,
    Expression<int>? rating,
    Expression<String>? note,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (brewedAt != null) 'brewed_at': brewedAt,
      if (brewedAtOffsetMinutes != null)
        'brewed_at_offset_minutes': brewedAtOffsetMinutes,
      if (brewMethodKey != null) 'brew_method_key': brewMethodKey,
      if (brewMethodCustom != null) 'brew_method_custom': brewMethodCustom,
      if (doseMilligrams != null) 'dose_milligrams': doseMilligrams,
      if (waterMilligrams != null) 'water_milligrams': waterMilligrams,
      if (waterTemperatureDeciCelsius != null)
        'water_temperature_deci_celsius': waterTemperatureDeciCelsius,
      if (grindSize != null) 'grind_size': grindSize,
      if (brewTimeSeconds != null) 'brew_time_seconds': brewTimeSeconds,
      if (rating != null) 'rating': rating,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeId,
    Value<int>? brewedAt,
    Value<int>? brewedAtOffsetMinutes,
    Value<String>? brewMethodKey,
    Value<String?>? brewMethodCustom,
    Value<int?>? doseMilligrams,
    Value<int?>? waterMilligrams,
    Value<int?>? waterTemperatureDeciCelsius,
    Value<String?>? grindSize,
    Value<int?>? brewTimeSeconds,
    Value<int?>? rating,
    Value<String?>? note,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      brewedAt: brewedAt ?? this.brewedAt,
      brewedAtOffsetMinutes:
          brewedAtOffsetMinutes ?? this.brewedAtOffsetMinutes,
      brewMethodKey: brewMethodKey ?? this.brewMethodKey,
      brewMethodCustom: brewMethodCustom ?? this.brewMethodCustom,
      doseMilligrams: doseMilligrams ?? this.doseMilligrams,
      waterMilligrams: waterMilligrams ?? this.waterMilligrams,
      waterTemperatureDeciCelsius:
          waterTemperatureDeciCelsius ?? this.waterTemperatureDeciCelsius,
      grindSize: grindSize ?? this.grindSize,
      brewTimeSeconds: brewTimeSeconds ?? this.brewTimeSeconds,
      rating: rating ?? this.rating,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (brewedAt.present) {
      map['brewed_at'] = Variable<int>(brewedAt.value);
    }
    if (brewedAtOffsetMinutes.present) {
      map['brewed_at_offset_minutes'] = Variable<int>(
        brewedAtOffsetMinutes.value,
      );
    }
    if (brewMethodKey.present) {
      map['brew_method_key'] = Variable<String>(brewMethodKey.value);
    }
    if (brewMethodCustom.present) {
      map['brew_method_custom'] = Variable<String>(brewMethodCustom.value);
    }
    if (doseMilligrams.present) {
      map['dose_milligrams'] = Variable<int>(doseMilligrams.value);
    }
    if (waterMilligrams.present) {
      map['water_milligrams'] = Variable<int>(waterMilligrams.value);
    }
    if (waterTemperatureDeciCelsius.present) {
      map['water_temperature_deci_celsius'] = Variable<int>(
        waterTemperatureDeciCelsius.value,
      );
    }
    if (grindSize.present) {
      map['grind_size'] = Variable<String>(grindSize.value);
    }
    if (brewTimeSeconds.present) {
      map['brew_time_seconds'] = Variable<int>(brewTimeSeconds.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewedAt: $brewedAt, ')
          ..write('brewedAtOffsetMinutes: $brewedAtOffsetMinutes, ')
          ..write('brewMethodKey: $brewMethodKey, ')
          ..write('brewMethodCustom: $brewMethodCustom, ')
          ..write('doseMilligrams: $doseMilligrams, ')
          ..write('waterMilligrams: $waterMilligrams, ')
          ..write('waterTemperatureDeciCelsius: $waterTemperatureDeciCelsius, ')
          ..write('grindSize: $grindSize, ')
          ..write('brewTimeSeconds: $brewTimeSeconds, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeeDraftsTable extends CoffeeDrafts
    with TableInfo<$CoffeeDraftsTable, DraftRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeDraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _reviewJsonMeta = const VerificationMeta(
    'reviewJson',
  );
  @override
  late final GeneratedColumn<String> reviewJson = GeneratedColumn<String>(
    'review_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewRevisionMeta = const VerificationMeta(
    'reviewRevision',
  );
  @override
  late final GeneratedColumn<int> reviewRevision = GeneratedColumn<int>(
    'review_revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ocrRawTextMeta = const VerificationMeta(
    'ocrRawText',
  );
  @override
  late final GeneratedColumn<String> ocrRawText = GeneratedColumn<String>(
    'ocr_raw_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrLinesJsonMeta = const VerificationMeta(
    'ocrLinesJson',
  );
  @override
  late final GeneratedColumn<String> ocrLinesJson = GeneratedColumn<String>(
    'ocr_lines_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scanRevisionMeta = const VerificationMeta(
    'scanRevision',
  );
  @override
  late final GeneratedColumn<int> scanRevision = GeneratedColumn<int>(
    'scan_revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _draftTypeMeta = const VerificationMeta(
    'draftType',
  );
  @override
  late final GeneratedColumn<String> draftType = GeneratedColumn<String>(
    'draft_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCoffeeIdMeta = const VerificationMeta(
    'targetCoffeeId',
  );
  @override
  late final GeneratedColumn<String> targetCoffeeId = GeneratedColumn<String>(
    'target_coffee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _temporaryImagePathMeta =
      const VerificationMeta('temporaryImagePath');
  @override
  late final GeneratedColumn<String> temporaryImagePath =
      GeneratedColumn<String>(
        'temporary_image_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imageMimeTypeMeta = const VerificationMeta(
    'imageMimeType',
  );
  @override
  late final GeneratedColumn<String> imageMimeType = GeneratedColumn<String>(
    'image_mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roasteryMeta = const VerificationMeta(
    'roastery',
  );
  @override
  late final GeneratedColumn<String> roastery = GeneratedColumn<String>(
    'roastery',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originCountryMeta = const VerificationMeta(
    'originCountry',
  );
  @override
  late final GeneratedColumn<String> originCountry = GeneratedColumn<String>(
    'origin_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _producerMeta = const VerificationMeta(
    'producer',
  );
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
    'producer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processMeta = const VerificationMeta(
    'process',
  );
  @override
  late final GeneratedColumn<String> process = GeneratedColumn<String>(
    'process',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originCountryCodeMeta = const VerificationMeta(
    'originCountryCode',
  );
  @override
  late final GeneratedColumn<String> originCountryCode =
      GeneratedColumn<String>(
        'origin_country_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _roastLevelKeyMeta = const VerificationMeta(
    'roastLevelKey',
  );
  @override
  late final GeneratedColumn<String> roastLevelKey = GeneratedColumn<String>(
    'roast_level_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastLevelCustomMeta = const VerificationMeta(
    'roastLevelCustom',
  );
  @override
  late final GeneratedColumn<String> roastLevelCustom = GeneratedColumn<String>(
    'roast_level_custom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMinMetersMeta = const VerificationMeta(
    'altitudeMinMeters',
  );
  @override
  late final GeneratedColumn<int> altitudeMinMeters = GeneratedColumn<int>(
    'altitude_min_meters',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMaxMetersMeta = const VerificationMeta(
    'altitudeMaxMeters',
  );
  @override
  late final GeneratedColumn<int> altitudeMaxMeters = GeneratedColumn<int>(
    'altitude_max_meters',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeSourceTextMeta =
      const VerificationMeta('altitudeSourceText');
  @override
  late final GeneratedColumn<String> altitudeSourceText =
      GeneratedColumn<String>(
        'altitude_source_text',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<String> roastDate = GeneratedColumn<String>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<String> purchaseDate = GeneratedColumn<String>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packageWeightGramsMeta =
      const VerificationMeta('packageWeightGrams');
  @override
  late final GeneratedColumn<int> packageWeightGrams = GeneratedColumn<int>(
    'package_weight_grams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personalNoteMeta = const VerificationMeta(
    'personalNote',
  );
  @override
  late final GeneratedColumn<String> personalNote = GeneratedColumn<String>(
    'personal_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureCategoryMeta = const VerificationMeta(
    'failureCategory',
  );
  @override
  late final GeneratedColumn<String> failureCategory = GeneratedColumn<String>(
    'failure_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    reviewJson,
    reviewRevision,
    ocrRawText,
    ocrLinesJson,
    scanRevision,
    id,
    draftType,
    status,
    targetCoffeeId,
    temporaryImagePath,
    imageMimeType,
    name,
    roastery,
    originCountry,
    region,
    producer,
    process,
    originCountryCode,
    roastLevelKey,
    roastLevelCustom,
    altitudeMinMeters,
    altitudeMaxMeters,
    altitudeSourceText,
    roastDate,
    purchaseDate,
    packageWeightGrams,
    personalNote,
    failureCategory,
    createdAt,
    updatedAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('review_json')) {
      context.handle(
        _reviewJsonMeta,
        reviewJson.isAcceptableOrUnknown(data['review_json']!, _reviewJsonMeta),
      );
    }
    if (data.containsKey('review_revision')) {
      context.handle(
        _reviewRevisionMeta,
        reviewRevision.isAcceptableOrUnknown(
          data['review_revision']!,
          _reviewRevisionMeta,
        ),
      );
    }
    if (data.containsKey('ocr_raw_text')) {
      context.handle(
        _ocrRawTextMeta,
        ocrRawText.isAcceptableOrUnknown(
          data['ocr_raw_text']!,
          _ocrRawTextMeta,
        ),
      );
    }
    if (data.containsKey('ocr_lines_json')) {
      context.handle(
        _ocrLinesJsonMeta,
        ocrLinesJson.isAcceptableOrUnknown(
          data['ocr_lines_json']!,
          _ocrLinesJsonMeta,
        ),
      );
    }
    if (data.containsKey('scan_revision')) {
      context.handle(
        _scanRevisionMeta,
        scanRevision.isAcceptableOrUnknown(
          data['scan_revision']!,
          _scanRevisionMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('draft_type')) {
      context.handle(
        _draftTypeMeta,
        draftType.isAcceptableOrUnknown(data['draft_type']!, _draftTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_draftTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('target_coffee_id')) {
      context.handle(
        _targetCoffeeIdMeta,
        targetCoffeeId.isAcceptableOrUnknown(
          data['target_coffee_id']!,
          _targetCoffeeIdMeta,
        ),
      );
    }
    if (data.containsKey('temporary_image_path')) {
      context.handle(
        _temporaryImagePathMeta,
        temporaryImagePath.isAcceptableOrUnknown(
          data['temporary_image_path']!,
          _temporaryImagePathMeta,
        ),
      );
    }
    if (data.containsKey('image_mime_type')) {
      context.handle(
        _imageMimeTypeMeta,
        imageMimeType.isAcceptableOrUnknown(
          data['image_mime_type']!,
          _imageMimeTypeMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('roastery')) {
      context.handle(
        _roasteryMeta,
        roastery.isAcceptableOrUnknown(data['roastery']!, _roasteryMeta),
      );
    }
    if (data.containsKey('origin_country')) {
      context.handle(
        _originCountryMeta,
        originCountry.isAcceptableOrUnknown(
          data['origin_country']!,
          _originCountryMeta,
        ),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('producer')) {
      context.handle(
        _producerMeta,
        producer.isAcceptableOrUnknown(data['producer']!, _producerMeta),
      );
    }
    if (data.containsKey('process')) {
      context.handle(
        _processMeta,
        process.isAcceptableOrUnknown(data['process']!, _processMeta),
      );
    }
    if (data.containsKey('origin_country_code')) {
      context.handle(
        _originCountryCodeMeta,
        originCountryCode.isAcceptableOrUnknown(
          data['origin_country_code']!,
          _originCountryCodeMeta,
        ),
      );
    }
    if (data.containsKey('roast_level_key')) {
      context.handle(
        _roastLevelKeyMeta,
        roastLevelKey.isAcceptableOrUnknown(
          data['roast_level_key']!,
          _roastLevelKeyMeta,
        ),
      );
    }
    if (data.containsKey('roast_level_custom')) {
      context.handle(
        _roastLevelCustomMeta,
        roastLevelCustom.isAcceptableOrUnknown(
          data['roast_level_custom']!,
          _roastLevelCustomMeta,
        ),
      );
    }
    if (data.containsKey('altitude_min_meters')) {
      context.handle(
        _altitudeMinMetersMeta,
        altitudeMinMeters.isAcceptableOrUnknown(
          data['altitude_min_meters']!,
          _altitudeMinMetersMeta,
        ),
      );
    }
    if (data.containsKey('altitude_max_meters')) {
      context.handle(
        _altitudeMaxMetersMeta,
        altitudeMaxMeters.isAcceptableOrUnknown(
          data['altitude_max_meters']!,
          _altitudeMaxMetersMeta,
        ),
      );
    }
    if (data.containsKey('altitude_source_text')) {
      context.handle(
        _altitudeSourceTextMeta,
        altitudeSourceText.isAcceptableOrUnknown(
          data['altitude_source_text']!,
          _altitudeSourceTextMeta,
        ),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('package_weight_grams')) {
      context.handle(
        _packageWeightGramsMeta,
        packageWeightGrams.isAcceptableOrUnknown(
          data['package_weight_grams']!,
          _packageWeightGramsMeta,
        ),
      );
    }
    if (data.containsKey('personal_note')) {
      context.handle(
        _personalNoteMeta,
        personalNote.isAcceptableOrUnknown(
          data['personal_note']!,
          _personalNoteMeta,
        ),
      );
    }
    if (data.containsKey('failure_category')) {
      context.handle(
        _failureCategoryMeta,
        failureCategory.isAcceptableOrUnknown(
          data['failure_category']!,
          _failureCategoryMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftRecord(
      reviewJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_json'],
      ),
      reviewRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_revision'],
      )!,
      ocrRawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_raw_text'],
      ),
      ocrLinesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_lines_json'],
      ),
      scanRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scan_revision'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      draftType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draft_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      targetCoffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_coffee_id'],
      ),
      temporaryImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}temporary_image_path'],
      ),
      imageMimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_mime_type'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      roastery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roastery'],
      ),
      originCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      producer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producer'],
      ),
      process: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process'],
      ),
      originCountryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country_code'],
      ),
      roastLevelKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level_key'],
      ),
      roastLevelCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level_custom'],
      ),
      altitudeMinMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_min_meters'],
      ),
      altitudeMaxMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_max_meters'],
      ),
      altitudeSourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}altitude_source_text'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_date'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_date'],
      ),
      packageWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}package_weight_grams'],
      ),
      personalNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_note'],
      ),
      failureCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_category'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      ),
    );
  }

  @override
  $CoffeeDraftsTable createAlias(String alias) {
    return $CoffeeDraftsTable(attachedDatabase, alias);
  }
}

class DraftRecord extends DataClass implements Insertable<DraftRecord> {
  final String? reviewJson;
  final int reviewRevision;
  final String? ocrRawText;
  final String? ocrLinesJson;
  final int scanRevision;
  final String id;
  final String draftType;
  final String status;
  final String? targetCoffeeId;
  final String? temporaryImagePath;
  final String? imageMimeType;
  final String? name;
  final String? roastery;
  final String? originCountry;
  final String? region;
  final String? producer;
  final String? process;
  final String? originCountryCode;
  final String? roastLevelKey;
  final String? roastLevelCustom;
  final int? altitudeMinMeters;
  final int? altitudeMaxMeters;
  final String? altitudeSourceText;
  final String? roastDate;
  final String? purchaseDate;
  final int? packageWeightGrams;
  final String? personalNote;
  final String? failureCategory;
  final int createdAt;
  final int updatedAt;
  final int? expiresAt;
  const DraftRecord({
    this.reviewJson,
    required this.reviewRevision,
    this.ocrRawText,
    this.ocrLinesJson,
    required this.scanRevision,
    required this.id,
    required this.draftType,
    required this.status,
    this.targetCoffeeId,
    this.temporaryImagePath,
    this.imageMimeType,
    this.name,
    this.roastery,
    this.originCountry,
    this.region,
    this.producer,
    this.process,
    this.originCountryCode,
    this.roastLevelKey,
    this.roastLevelCustom,
    this.altitudeMinMeters,
    this.altitudeMaxMeters,
    this.altitudeSourceText,
    this.roastDate,
    this.purchaseDate,
    this.packageWeightGrams,
    this.personalNote,
    this.failureCategory,
    required this.createdAt,
    required this.updatedAt,
    this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || reviewJson != null) {
      map['review_json'] = Variable<String>(reviewJson);
    }
    map['review_revision'] = Variable<int>(reviewRevision);
    if (!nullToAbsent || ocrRawText != null) {
      map['ocr_raw_text'] = Variable<String>(ocrRawText);
    }
    if (!nullToAbsent || ocrLinesJson != null) {
      map['ocr_lines_json'] = Variable<String>(ocrLinesJson);
    }
    map['scan_revision'] = Variable<int>(scanRevision);
    map['id'] = Variable<String>(id);
    map['draft_type'] = Variable<String>(draftType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || targetCoffeeId != null) {
      map['target_coffee_id'] = Variable<String>(targetCoffeeId);
    }
    if (!nullToAbsent || temporaryImagePath != null) {
      map['temporary_image_path'] = Variable<String>(temporaryImagePath);
    }
    if (!nullToAbsent || imageMimeType != null) {
      map['image_mime_type'] = Variable<String>(imageMimeType);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || roastery != null) {
      map['roastery'] = Variable<String>(roastery);
    }
    if (!nullToAbsent || originCountry != null) {
      map['origin_country'] = Variable<String>(originCountry);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || process != null) {
      map['process'] = Variable<String>(process);
    }
    if (!nullToAbsent || originCountryCode != null) {
      map['origin_country_code'] = Variable<String>(originCountryCode);
    }
    if (!nullToAbsent || roastLevelKey != null) {
      map['roast_level_key'] = Variable<String>(roastLevelKey);
    }
    if (!nullToAbsent || roastLevelCustom != null) {
      map['roast_level_custom'] = Variable<String>(roastLevelCustom);
    }
    if (!nullToAbsent || altitudeMinMeters != null) {
      map['altitude_min_meters'] = Variable<int>(altitudeMinMeters);
    }
    if (!nullToAbsent || altitudeMaxMeters != null) {
      map['altitude_max_meters'] = Variable<int>(altitudeMaxMeters);
    }
    if (!nullToAbsent || altitudeSourceText != null) {
      map['altitude_source_text'] = Variable<String>(altitudeSourceText);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<String>(roastDate);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<String>(purchaseDate);
    }
    if (!nullToAbsent || packageWeightGrams != null) {
      map['package_weight_grams'] = Variable<int>(packageWeightGrams);
    }
    if (!nullToAbsent || personalNote != null) {
      map['personal_note'] = Variable<String>(personalNote);
    }
    if (!nullToAbsent || failureCategory != null) {
      map['failure_category'] = Variable<String>(failureCategory);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<int>(expiresAt);
    }
    return map;
  }

  CoffeeDraftsCompanion toCompanion(bool nullToAbsent) {
    return CoffeeDraftsCompanion(
      reviewJson: reviewJson == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewJson),
      reviewRevision: Value(reviewRevision),
      ocrRawText: ocrRawText == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrRawText),
      ocrLinesJson: ocrLinesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrLinesJson),
      scanRevision: Value(scanRevision),
      id: Value(id),
      draftType: Value(draftType),
      status: Value(status),
      targetCoffeeId: targetCoffeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCoffeeId),
      temporaryImagePath: temporaryImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(temporaryImagePath),
      imageMimeType: imageMimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(imageMimeType),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      roastery: roastery == null && nullToAbsent
          ? const Value.absent()
          : Value(roastery),
      originCountry: originCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountry),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      process: process == null && nullToAbsent
          ? const Value.absent()
          : Value(process),
      originCountryCode: originCountryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountryCode),
      roastLevelKey: roastLevelKey == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevelKey),
      roastLevelCustom: roastLevelCustom == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevelCustom),
      altitudeMinMeters: altitudeMinMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMinMeters),
      altitudeMaxMeters: altitudeMaxMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMaxMeters),
      altitudeSourceText: altitudeSourceText == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeSourceText),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      packageWeightGrams: packageWeightGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(packageWeightGrams),
      personalNote: personalNote == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNote),
      failureCategory: failureCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(failureCategory),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
    );
  }

  factory DraftRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftRecord(
      reviewJson: serializer.fromJson<String?>(json['reviewJson']),
      reviewRevision: serializer.fromJson<int>(json['reviewRevision']),
      ocrRawText: serializer.fromJson<String?>(json['ocrRawText']),
      ocrLinesJson: serializer.fromJson<String?>(json['ocrLinesJson']),
      scanRevision: serializer.fromJson<int>(json['scanRevision']),
      id: serializer.fromJson<String>(json['id']),
      draftType: serializer.fromJson<String>(json['draftType']),
      status: serializer.fromJson<String>(json['status']),
      targetCoffeeId: serializer.fromJson<String?>(json['targetCoffeeId']),
      temporaryImagePath: serializer.fromJson<String?>(
        json['temporaryImagePath'],
      ),
      imageMimeType: serializer.fromJson<String?>(json['imageMimeType']),
      name: serializer.fromJson<String?>(json['name']),
      roastery: serializer.fromJson<String?>(json['roastery']),
      originCountry: serializer.fromJson<String?>(json['originCountry']),
      region: serializer.fromJson<String?>(json['region']),
      producer: serializer.fromJson<String?>(json['producer']),
      process: serializer.fromJson<String?>(json['process']),
      originCountryCode: serializer.fromJson<String?>(
        json['originCountryCode'],
      ),
      roastLevelKey: serializer.fromJson<String?>(json['roastLevelKey']),
      roastLevelCustom: serializer.fromJson<String?>(json['roastLevelCustom']),
      altitudeMinMeters: serializer.fromJson<int?>(json['altitudeMinMeters']),
      altitudeMaxMeters: serializer.fromJson<int?>(json['altitudeMaxMeters']),
      altitudeSourceText: serializer.fromJson<String?>(
        json['altitudeSourceText'],
      ),
      roastDate: serializer.fromJson<String?>(json['roastDate']),
      purchaseDate: serializer.fromJson<String?>(json['purchaseDate']),
      packageWeightGrams: serializer.fromJson<int?>(json['packageWeightGrams']),
      personalNote: serializer.fromJson<String?>(json['personalNote']),
      failureCategory: serializer.fromJson<String?>(json['failureCategory']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      expiresAt: serializer.fromJson<int?>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'reviewJson': serializer.toJson<String?>(reviewJson),
      'reviewRevision': serializer.toJson<int>(reviewRevision),
      'ocrRawText': serializer.toJson<String?>(ocrRawText),
      'ocrLinesJson': serializer.toJson<String?>(ocrLinesJson),
      'scanRevision': serializer.toJson<int>(scanRevision),
      'id': serializer.toJson<String>(id),
      'draftType': serializer.toJson<String>(draftType),
      'status': serializer.toJson<String>(status),
      'targetCoffeeId': serializer.toJson<String?>(targetCoffeeId),
      'temporaryImagePath': serializer.toJson<String?>(temporaryImagePath),
      'imageMimeType': serializer.toJson<String?>(imageMimeType),
      'name': serializer.toJson<String?>(name),
      'roastery': serializer.toJson<String?>(roastery),
      'originCountry': serializer.toJson<String?>(originCountry),
      'region': serializer.toJson<String?>(region),
      'producer': serializer.toJson<String?>(producer),
      'process': serializer.toJson<String?>(process),
      'originCountryCode': serializer.toJson<String?>(originCountryCode),
      'roastLevelKey': serializer.toJson<String?>(roastLevelKey),
      'roastLevelCustom': serializer.toJson<String?>(roastLevelCustom),
      'altitudeMinMeters': serializer.toJson<int?>(altitudeMinMeters),
      'altitudeMaxMeters': serializer.toJson<int?>(altitudeMaxMeters),
      'altitudeSourceText': serializer.toJson<String?>(altitudeSourceText),
      'roastDate': serializer.toJson<String?>(roastDate),
      'purchaseDate': serializer.toJson<String?>(purchaseDate),
      'packageWeightGrams': serializer.toJson<int?>(packageWeightGrams),
      'personalNote': serializer.toJson<String?>(personalNote),
      'failureCategory': serializer.toJson<String?>(failureCategory),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'expiresAt': serializer.toJson<int?>(expiresAt),
    };
  }

  DraftRecord copyWith({
    Value<String?> reviewJson = const Value.absent(),
    int? reviewRevision,
    Value<String?> ocrRawText = const Value.absent(),
    Value<String?> ocrLinesJson = const Value.absent(),
    int? scanRevision,
    String? id,
    String? draftType,
    String? status,
    Value<String?> targetCoffeeId = const Value.absent(),
    Value<String?> temporaryImagePath = const Value.absent(),
    Value<String?> imageMimeType = const Value.absent(),
    Value<String?> name = const Value.absent(),
    Value<String?> roastery = const Value.absent(),
    Value<String?> originCountry = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> producer = const Value.absent(),
    Value<String?> process = const Value.absent(),
    Value<String?> originCountryCode = const Value.absent(),
    Value<String?> roastLevelKey = const Value.absent(),
    Value<String?> roastLevelCustom = const Value.absent(),
    Value<int?> altitudeMinMeters = const Value.absent(),
    Value<int?> altitudeMaxMeters = const Value.absent(),
    Value<String?> altitudeSourceText = const Value.absent(),
    Value<String?> roastDate = const Value.absent(),
    Value<String?> purchaseDate = const Value.absent(),
    Value<int?> packageWeightGrams = const Value.absent(),
    Value<String?> personalNote = const Value.absent(),
    Value<String?> failureCategory = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> expiresAt = const Value.absent(),
  }) => DraftRecord(
    reviewJson: reviewJson.present ? reviewJson.value : this.reviewJson,
    reviewRevision: reviewRevision ?? this.reviewRevision,
    ocrRawText: ocrRawText.present ? ocrRawText.value : this.ocrRawText,
    ocrLinesJson: ocrLinesJson.present ? ocrLinesJson.value : this.ocrLinesJson,
    scanRevision: scanRevision ?? this.scanRevision,
    id: id ?? this.id,
    draftType: draftType ?? this.draftType,
    status: status ?? this.status,
    targetCoffeeId: targetCoffeeId.present
        ? targetCoffeeId.value
        : this.targetCoffeeId,
    temporaryImagePath: temporaryImagePath.present
        ? temporaryImagePath.value
        : this.temporaryImagePath,
    imageMimeType: imageMimeType.present
        ? imageMimeType.value
        : this.imageMimeType,
    name: name.present ? name.value : this.name,
    roastery: roastery.present ? roastery.value : this.roastery,
    originCountry: originCountry.present
        ? originCountry.value
        : this.originCountry,
    region: region.present ? region.value : this.region,
    producer: producer.present ? producer.value : this.producer,
    process: process.present ? process.value : this.process,
    originCountryCode: originCountryCode.present
        ? originCountryCode.value
        : this.originCountryCode,
    roastLevelKey: roastLevelKey.present
        ? roastLevelKey.value
        : this.roastLevelKey,
    roastLevelCustom: roastLevelCustom.present
        ? roastLevelCustom.value
        : this.roastLevelCustom,
    altitudeMinMeters: altitudeMinMeters.present
        ? altitudeMinMeters.value
        : this.altitudeMinMeters,
    altitudeMaxMeters: altitudeMaxMeters.present
        ? altitudeMaxMeters.value
        : this.altitudeMaxMeters,
    altitudeSourceText: altitudeSourceText.present
        ? altitudeSourceText.value
        : this.altitudeSourceText,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    packageWeightGrams: packageWeightGrams.present
        ? packageWeightGrams.value
        : this.packageWeightGrams,
    personalNote: personalNote.present ? personalNote.value : this.personalNote,
    failureCategory: failureCategory.present
        ? failureCategory.value
        : this.failureCategory,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
  );
  DraftRecord copyWithCompanion(CoffeeDraftsCompanion data) {
    return DraftRecord(
      reviewJson: data.reviewJson.present
          ? data.reviewJson.value
          : this.reviewJson,
      reviewRevision: data.reviewRevision.present
          ? data.reviewRevision.value
          : this.reviewRevision,
      ocrRawText: data.ocrRawText.present
          ? data.ocrRawText.value
          : this.ocrRawText,
      ocrLinesJson: data.ocrLinesJson.present
          ? data.ocrLinesJson.value
          : this.ocrLinesJson,
      scanRevision: data.scanRevision.present
          ? data.scanRevision.value
          : this.scanRevision,
      id: data.id.present ? data.id.value : this.id,
      draftType: data.draftType.present ? data.draftType.value : this.draftType,
      status: data.status.present ? data.status.value : this.status,
      targetCoffeeId: data.targetCoffeeId.present
          ? data.targetCoffeeId.value
          : this.targetCoffeeId,
      temporaryImagePath: data.temporaryImagePath.present
          ? data.temporaryImagePath.value
          : this.temporaryImagePath,
      imageMimeType: data.imageMimeType.present
          ? data.imageMimeType.value
          : this.imageMimeType,
      name: data.name.present ? data.name.value : this.name,
      roastery: data.roastery.present ? data.roastery.value : this.roastery,
      originCountry: data.originCountry.present
          ? data.originCountry.value
          : this.originCountry,
      region: data.region.present ? data.region.value : this.region,
      producer: data.producer.present ? data.producer.value : this.producer,
      process: data.process.present ? data.process.value : this.process,
      originCountryCode: data.originCountryCode.present
          ? data.originCountryCode.value
          : this.originCountryCode,
      roastLevelKey: data.roastLevelKey.present
          ? data.roastLevelKey.value
          : this.roastLevelKey,
      roastLevelCustom: data.roastLevelCustom.present
          ? data.roastLevelCustom.value
          : this.roastLevelCustom,
      altitudeMinMeters: data.altitudeMinMeters.present
          ? data.altitudeMinMeters.value
          : this.altitudeMinMeters,
      altitudeMaxMeters: data.altitudeMaxMeters.present
          ? data.altitudeMaxMeters.value
          : this.altitudeMaxMeters,
      altitudeSourceText: data.altitudeSourceText.present
          ? data.altitudeSourceText.value
          : this.altitudeSourceText,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      packageWeightGrams: data.packageWeightGrams.present
          ? data.packageWeightGrams.value
          : this.packageWeightGrams,
      personalNote: data.personalNote.present
          ? data.personalNote.value
          : this.personalNote,
      failureCategory: data.failureCategory.present
          ? data.failureCategory.value
          : this.failureCategory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftRecord(')
          ..write('reviewJson: $reviewJson, ')
          ..write('reviewRevision: $reviewRevision, ')
          ..write('ocrRawText: $ocrRawText, ')
          ..write('ocrLinesJson: $ocrLinesJson, ')
          ..write('scanRevision: $scanRevision, ')
          ..write('id: $id, ')
          ..write('draftType: $draftType, ')
          ..write('status: $status, ')
          ..write('targetCoffeeId: $targetCoffeeId, ')
          ..write('temporaryImagePath: $temporaryImagePath, ')
          ..write('imageMimeType: $imageMimeType, ')
          ..write('name: $name, ')
          ..write('roastery: $roastery, ')
          ..write('originCountry: $originCountry, ')
          ..write('region: $region, ')
          ..write('producer: $producer, ')
          ..write('process: $process, ')
          ..write('originCountryCode: $originCountryCode, ')
          ..write('roastLevelKey: $roastLevelKey, ')
          ..write('roastLevelCustom: $roastLevelCustom, ')
          ..write('altitudeMinMeters: $altitudeMinMeters, ')
          ..write('altitudeMaxMeters: $altitudeMaxMeters, ')
          ..write('altitudeSourceText: $altitudeSourceText, ')
          ..write('roastDate: $roastDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageWeightGrams: $packageWeightGrams, ')
          ..write('personalNote: $personalNote, ')
          ..write('failureCategory: $failureCategory, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    reviewJson,
    reviewRevision,
    ocrRawText,
    ocrLinesJson,
    scanRevision,
    id,
    draftType,
    status,
    targetCoffeeId,
    temporaryImagePath,
    imageMimeType,
    name,
    roastery,
    originCountry,
    region,
    producer,
    process,
    originCountryCode,
    roastLevelKey,
    roastLevelCustom,
    altitudeMinMeters,
    altitudeMaxMeters,
    altitudeSourceText,
    roastDate,
    purchaseDate,
    packageWeightGrams,
    personalNote,
    failureCategory,
    createdAt,
    updatedAt,
    expiresAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftRecord &&
          other.reviewJson == this.reviewJson &&
          other.reviewRevision == this.reviewRevision &&
          other.ocrRawText == this.ocrRawText &&
          other.ocrLinesJson == this.ocrLinesJson &&
          other.scanRevision == this.scanRevision &&
          other.id == this.id &&
          other.draftType == this.draftType &&
          other.status == this.status &&
          other.targetCoffeeId == this.targetCoffeeId &&
          other.temporaryImagePath == this.temporaryImagePath &&
          other.imageMimeType == this.imageMimeType &&
          other.name == this.name &&
          other.roastery == this.roastery &&
          other.originCountry == this.originCountry &&
          other.region == this.region &&
          other.producer == this.producer &&
          other.process == this.process &&
          other.originCountryCode == this.originCountryCode &&
          other.roastLevelKey == this.roastLevelKey &&
          other.roastLevelCustom == this.roastLevelCustom &&
          other.altitudeMinMeters == this.altitudeMinMeters &&
          other.altitudeMaxMeters == this.altitudeMaxMeters &&
          other.altitudeSourceText == this.altitudeSourceText &&
          other.roastDate == this.roastDate &&
          other.purchaseDate == this.purchaseDate &&
          other.packageWeightGrams == this.packageWeightGrams &&
          other.personalNote == this.personalNote &&
          other.failureCategory == this.failureCategory &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.expiresAt == this.expiresAt);
}

class CoffeeDraftsCompanion extends UpdateCompanion<DraftRecord> {
  final Value<String?> reviewJson;
  final Value<int> reviewRevision;
  final Value<String?> ocrRawText;
  final Value<String?> ocrLinesJson;
  final Value<int> scanRevision;
  final Value<String> id;
  final Value<String> draftType;
  final Value<String> status;
  final Value<String?> targetCoffeeId;
  final Value<String?> temporaryImagePath;
  final Value<String?> imageMimeType;
  final Value<String?> name;
  final Value<String?> roastery;
  final Value<String?> originCountry;
  final Value<String?> region;
  final Value<String?> producer;
  final Value<String?> process;
  final Value<String?> originCountryCode;
  final Value<String?> roastLevelKey;
  final Value<String?> roastLevelCustom;
  final Value<int?> altitudeMinMeters;
  final Value<int?> altitudeMaxMeters;
  final Value<String?> altitudeSourceText;
  final Value<String?> roastDate;
  final Value<String?> purchaseDate;
  final Value<int?> packageWeightGrams;
  final Value<String?> personalNote;
  final Value<String?> failureCategory;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> expiresAt;
  final Value<int> rowid;
  const CoffeeDraftsCompanion({
    this.reviewJson = const Value.absent(),
    this.reviewRevision = const Value.absent(),
    this.ocrRawText = const Value.absent(),
    this.ocrLinesJson = const Value.absent(),
    this.scanRevision = const Value.absent(),
    this.id = const Value.absent(),
    this.draftType = const Value.absent(),
    this.status = const Value.absent(),
    this.targetCoffeeId = const Value.absent(),
    this.temporaryImagePath = const Value.absent(),
    this.imageMimeType = const Value.absent(),
    this.name = const Value.absent(),
    this.roastery = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.region = const Value.absent(),
    this.producer = const Value.absent(),
    this.process = const Value.absent(),
    this.originCountryCode = const Value.absent(),
    this.roastLevelKey = const Value.absent(),
    this.roastLevelCustom = const Value.absent(),
    this.altitudeMinMeters = const Value.absent(),
    this.altitudeMaxMeters = const Value.absent(),
    this.altitudeSourceText = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageWeightGrams = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.failureCategory = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeDraftsCompanion.insert({
    this.reviewJson = const Value.absent(),
    this.reviewRevision = const Value.absent(),
    this.ocrRawText = const Value.absent(),
    this.ocrLinesJson = const Value.absent(),
    this.scanRevision = const Value.absent(),
    required String id,
    required String draftType,
    required String status,
    this.targetCoffeeId = const Value.absent(),
    this.temporaryImagePath = const Value.absent(),
    this.imageMimeType = const Value.absent(),
    this.name = const Value.absent(),
    this.roastery = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.region = const Value.absent(),
    this.producer = const Value.absent(),
    this.process = const Value.absent(),
    this.originCountryCode = const Value.absent(),
    this.roastLevelKey = const Value.absent(),
    this.roastLevelCustom = const Value.absent(),
    this.altitudeMinMeters = const Value.absent(),
    this.altitudeMaxMeters = const Value.absent(),
    this.altitudeSourceText = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.packageWeightGrams = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.failureCategory = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       draftType = Value(draftType),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DraftRecord> custom({
    Expression<String>? reviewJson,
    Expression<int>? reviewRevision,
    Expression<String>? ocrRawText,
    Expression<String>? ocrLinesJson,
    Expression<int>? scanRevision,
    Expression<String>? id,
    Expression<String>? draftType,
    Expression<String>? status,
    Expression<String>? targetCoffeeId,
    Expression<String>? temporaryImagePath,
    Expression<String>? imageMimeType,
    Expression<String>? name,
    Expression<String>? roastery,
    Expression<String>? originCountry,
    Expression<String>? region,
    Expression<String>? producer,
    Expression<String>? process,
    Expression<String>? originCountryCode,
    Expression<String>? roastLevelKey,
    Expression<String>? roastLevelCustom,
    Expression<int>? altitudeMinMeters,
    Expression<int>? altitudeMaxMeters,
    Expression<String>? altitudeSourceText,
    Expression<String>? roastDate,
    Expression<String>? purchaseDate,
    Expression<int>? packageWeightGrams,
    Expression<String>? personalNote,
    Expression<String>? failureCategory,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (reviewJson != null) 'review_json': reviewJson,
      if (reviewRevision != null) 'review_revision': reviewRevision,
      if (ocrRawText != null) 'ocr_raw_text': ocrRawText,
      if (ocrLinesJson != null) 'ocr_lines_json': ocrLinesJson,
      if (scanRevision != null) 'scan_revision': scanRevision,
      if (id != null) 'id': id,
      if (draftType != null) 'draft_type': draftType,
      if (status != null) 'status': status,
      if (targetCoffeeId != null) 'target_coffee_id': targetCoffeeId,
      if (temporaryImagePath != null)
        'temporary_image_path': temporaryImagePath,
      if (imageMimeType != null) 'image_mime_type': imageMimeType,
      if (name != null) 'name': name,
      if (roastery != null) 'roastery': roastery,
      if (originCountry != null) 'origin_country': originCountry,
      if (region != null) 'region': region,
      if (producer != null) 'producer': producer,
      if (process != null) 'process': process,
      if (originCountryCode != null) 'origin_country_code': originCountryCode,
      if (roastLevelKey != null) 'roast_level_key': roastLevelKey,
      if (roastLevelCustom != null) 'roast_level_custom': roastLevelCustom,
      if (altitudeMinMeters != null) 'altitude_min_meters': altitudeMinMeters,
      if (altitudeMaxMeters != null) 'altitude_max_meters': altitudeMaxMeters,
      if (altitudeSourceText != null)
        'altitude_source_text': altitudeSourceText,
      if (roastDate != null) 'roast_date': roastDate,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (packageWeightGrams != null)
        'package_weight_grams': packageWeightGrams,
      if (personalNote != null) 'personal_note': personalNote,
      if (failureCategory != null) 'failure_category': failureCategory,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeDraftsCompanion copyWith({
    Value<String?>? reviewJson,
    Value<int>? reviewRevision,
    Value<String?>? ocrRawText,
    Value<String?>? ocrLinesJson,
    Value<int>? scanRevision,
    Value<String>? id,
    Value<String>? draftType,
    Value<String>? status,
    Value<String?>? targetCoffeeId,
    Value<String?>? temporaryImagePath,
    Value<String?>? imageMimeType,
    Value<String?>? name,
    Value<String?>? roastery,
    Value<String?>? originCountry,
    Value<String?>? region,
    Value<String?>? producer,
    Value<String?>? process,
    Value<String?>? originCountryCode,
    Value<String?>? roastLevelKey,
    Value<String?>? roastLevelCustom,
    Value<int?>? altitudeMinMeters,
    Value<int?>? altitudeMaxMeters,
    Value<String?>? altitudeSourceText,
    Value<String?>? roastDate,
    Value<String?>? purchaseDate,
    Value<int?>? packageWeightGrams,
    Value<String?>? personalNote,
    Value<String?>? failureCategory,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? expiresAt,
    Value<int>? rowid,
  }) {
    return CoffeeDraftsCompanion(
      reviewJson: reviewJson ?? this.reviewJson,
      reviewRevision: reviewRevision ?? this.reviewRevision,
      ocrRawText: ocrRawText ?? this.ocrRawText,
      ocrLinesJson: ocrLinesJson ?? this.ocrLinesJson,
      scanRevision: scanRevision ?? this.scanRevision,
      id: id ?? this.id,
      draftType: draftType ?? this.draftType,
      status: status ?? this.status,
      targetCoffeeId: targetCoffeeId ?? this.targetCoffeeId,
      temporaryImagePath: temporaryImagePath ?? this.temporaryImagePath,
      imageMimeType: imageMimeType ?? this.imageMimeType,
      name: name ?? this.name,
      roastery: roastery ?? this.roastery,
      originCountry: originCountry ?? this.originCountry,
      region: region ?? this.region,
      producer: producer ?? this.producer,
      process: process ?? this.process,
      originCountryCode: originCountryCode ?? this.originCountryCode,
      roastLevelKey: roastLevelKey ?? this.roastLevelKey,
      roastLevelCustom: roastLevelCustom ?? this.roastLevelCustom,
      altitudeMinMeters: altitudeMinMeters ?? this.altitudeMinMeters,
      altitudeMaxMeters: altitudeMaxMeters ?? this.altitudeMaxMeters,
      altitudeSourceText: altitudeSourceText ?? this.altitudeSourceText,
      roastDate: roastDate ?? this.roastDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      packageWeightGrams: packageWeightGrams ?? this.packageWeightGrams,
      personalNote: personalNote ?? this.personalNote,
      failureCategory: failureCategory ?? this.failureCategory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (reviewJson.present) {
      map['review_json'] = Variable<String>(reviewJson.value);
    }
    if (reviewRevision.present) {
      map['review_revision'] = Variable<int>(reviewRevision.value);
    }
    if (ocrRawText.present) {
      map['ocr_raw_text'] = Variable<String>(ocrRawText.value);
    }
    if (ocrLinesJson.present) {
      map['ocr_lines_json'] = Variable<String>(ocrLinesJson.value);
    }
    if (scanRevision.present) {
      map['scan_revision'] = Variable<int>(scanRevision.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (draftType.present) {
      map['draft_type'] = Variable<String>(draftType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (targetCoffeeId.present) {
      map['target_coffee_id'] = Variable<String>(targetCoffeeId.value);
    }
    if (temporaryImagePath.present) {
      map['temporary_image_path'] = Variable<String>(temporaryImagePath.value);
    }
    if (imageMimeType.present) {
      map['image_mime_type'] = Variable<String>(imageMimeType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (roastery.present) {
      map['roastery'] = Variable<String>(roastery.value);
    }
    if (originCountry.present) {
      map['origin_country'] = Variable<String>(originCountry.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (process.present) {
      map['process'] = Variable<String>(process.value);
    }
    if (originCountryCode.present) {
      map['origin_country_code'] = Variable<String>(originCountryCode.value);
    }
    if (roastLevelKey.present) {
      map['roast_level_key'] = Variable<String>(roastLevelKey.value);
    }
    if (roastLevelCustom.present) {
      map['roast_level_custom'] = Variable<String>(roastLevelCustom.value);
    }
    if (altitudeMinMeters.present) {
      map['altitude_min_meters'] = Variable<int>(altitudeMinMeters.value);
    }
    if (altitudeMaxMeters.present) {
      map['altitude_max_meters'] = Variable<int>(altitudeMaxMeters.value);
    }
    if (altitudeSourceText.present) {
      map['altitude_source_text'] = Variable<String>(altitudeSourceText.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<String>(roastDate.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<String>(purchaseDate.value);
    }
    if (packageWeightGrams.present) {
      map['package_weight_grams'] = Variable<int>(packageWeightGrams.value);
    }
    if (personalNote.present) {
      map['personal_note'] = Variable<String>(personalNote.value);
    }
    if (failureCategory.present) {
      map['failure_category'] = Variable<String>(failureCategory.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeDraftsCompanion(')
          ..write('reviewJson: $reviewJson, ')
          ..write('reviewRevision: $reviewRevision, ')
          ..write('ocrRawText: $ocrRawText, ')
          ..write('ocrLinesJson: $ocrLinesJson, ')
          ..write('scanRevision: $scanRevision, ')
          ..write('id: $id, ')
          ..write('draftType: $draftType, ')
          ..write('status: $status, ')
          ..write('targetCoffeeId: $targetCoffeeId, ')
          ..write('temporaryImagePath: $temporaryImagePath, ')
          ..write('imageMimeType: $imageMimeType, ')
          ..write('name: $name, ')
          ..write('roastery: $roastery, ')
          ..write('originCountry: $originCountry, ')
          ..write('region: $region, ')
          ..write('producer: $producer, ')
          ..write('process: $process, ')
          ..write('originCountryCode: $originCountryCode, ')
          ..write('roastLevelKey: $roastLevelKey, ')
          ..write('roastLevelCustom: $roastLevelCustom, ')
          ..write('altitudeMinMeters: $altitudeMinMeters, ')
          ..write('altitudeMaxMeters: $altitudeMaxMeters, ')
          ..write('altitudeSourceText: $altitudeSourceText, ')
          ..write('roastDate: $roastDate, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('packageWeightGrams: $packageWeightGrams, ')
          ..write('personalNote: $personalNote, ')
          ..write('failureCategory: $failureCategory, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScanExtractedFieldsTable extends ScanExtractedFields
    with TableInfo<$ScanExtractedFieldsTable, ScanExtractedFieldRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanExtractedFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeDraftIdMeta = const VerificationMeta(
    'coffeeDraftId',
  );
  @override
  late final GeneratedColumn<String> coffeeDraftId = GeneratedColumn<String>(
    'coffee_draft_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffee_drafts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldKeyMeta = const VerificationMeta(
    'fieldKey',
  );
  @override
  late final GeneratedColumn<String> fieldKey = GeneratedColumn<String>(
    'field_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<String> rawValue = GeneratedColumn<String>(
    'raw_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceBasisPointsMeta =
      const VerificationMeta('confidenceBasisPoints');
  @override
  late final GeneratedColumn<int> confidenceBasisPoints = GeneratedColumn<int>(
    'confidence_basis_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewStatusMeta = const VerificationMeta(
    'reviewStatus',
  );
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
    'review_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRegionMeta = const VerificationMeta(
    'sourceRegion',
  );
  @override
  late final GeneratedColumn<String> sourceRegion = GeneratedColumn<String>(
    'source_region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeDraftId,
    fieldKey,
    rawValue,
    normalizedValue,
    confidenceBasisPoints,
    reviewStatus,
    sourceRegion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_extracted_fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanExtractedFieldRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_draft_id')) {
      context.handle(
        _coffeeDraftIdMeta,
        coffeeDraftId.isAcceptableOrUnknown(
          data['coffee_draft_id']!,
          _coffeeDraftIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeDraftIdMeta);
    }
    if (data.containsKey('field_key')) {
      context.handle(
        _fieldKeyMeta,
        fieldKey.isAcceptableOrUnknown(data['field_key']!, _fieldKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldKeyMeta);
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    }
    if (data.containsKey('confidence_basis_points')) {
      context.handle(
        _confidenceBasisPointsMeta,
        confidenceBasisPoints.isAcceptableOrUnknown(
          data['confidence_basis_points']!,
          _confidenceBasisPointsMeta,
        ),
      );
    }
    if (data.containsKey('review_status')) {
      context.handle(
        _reviewStatusMeta,
        reviewStatus.isAcceptableOrUnknown(
          data['review_status']!,
          _reviewStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewStatusMeta);
    }
    if (data.containsKey('source_region')) {
      context.handle(
        _sourceRegionMeta,
        sourceRegion.isAcceptableOrUnknown(
          data['source_region']!,
          _sourceRegionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanExtractedFieldRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanExtractedFieldRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeDraftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_draft_id'],
      )!,
      fieldKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_key'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_value'],
      ),
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      ),
      confidenceBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_basis_points'],
      ),
      reviewStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_status'],
      )!,
      sourceRegion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_region'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ScanExtractedFieldsTable createAlias(String alias) {
    return $ScanExtractedFieldsTable(attachedDatabase, alias);
  }
}

class ScanExtractedFieldRecord extends DataClass
    implements Insertable<ScanExtractedFieldRecord> {
  final String id;
  final String coffeeDraftId;
  final String fieldKey;
  final String? rawValue;
  final String? normalizedValue;
  final int? confidenceBasisPoints;
  final String reviewStatus;
  final String? sourceRegion;
  final int createdAt;
  final int updatedAt;
  const ScanExtractedFieldRecord({
    required this.id,
    required this.coffeeDraftId,
    required this.fieldKey,
    this.rawValue,
    this.normalizedValue,
    this.confidenceBasisPoints,
    required this.reviewStatus,
    this.sourceRegion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_draft_id'] = Variable<String>(coffeeDraftId);
    map['field_key'] = Variable<String>(fieldKey);
    if (!nullToAbsent || rawValue != null) {
      map['raw_value'] = Variable<String>(rawValue);
    }
    if (!nullToAbsent || normalizedValue != null) {
      map['normalized_value'] = Variable<String>(normalizedValue);
    }
    if (!nullToAbsent || confidenceBasisPoints != null) {
      map['confidence_basis_points'] = Variable<int>(confidenceBasisPoints);
    }
    map['review_status'] = Variable<String>(reviewStatus);
    if (!nullToAbsent || sourceRegion != null) {
      map['source_region'] = Variable<String>(sourceRegion);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  ScanExtractedFieldsCompanion toCompanion(bool nullToAbsent) {
    return ScanExtractedFieldsCompanion(
      id: Value(id),
      coffeeDraftId: Value(coffeeDraftId),
      fieldKey: Value(fieldKey),
      rawValue: rawValue == null && nullToAbsent
          ? const Value.absent()
          : Value(rawValue),
      normalizedValue: normalizedValue == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedValue),
      confidenceBasisPoints: confidenceBasisPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(confidenceBasisPoints),
      reviewStatus: Value(reviewStatus),
      sourceRegion: sourceRegion == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRegion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScanExtractedFieldRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanExtractedFieldRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeDraftId: serializer.fromJson<String>(json['coffeeDraftId']),
      fieldKey: serializer.fromJson<String>(json['fieldKey']),
      rawValue: serializer.fromJson<String?>(json['rawValue']),
      normalizedValue: serializer.fromJson<String?>(json['normalizedValue']),
      confidenceBasisPoints: serializer.fromJson<int?>(
        json['confidenceBasisPoints'],
      ),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      sourceRegion: serializer.fromJson<String?>(json['sourceRegion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeDraftId': serializer.toJson<String>(coffeeDraftId),
      'fieldKey': serializer.toJson<String>(fieldKey),
      'rawValue': serializer.toJson<String?>(rawValue),
      'normalizedValue': serializer.toJson<String?>(normalizedValue),
      'confidenceBasisPoints': serializer.toJson<int?>(confidenceBasisPoints),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'sourceRegion': serializer.toJson<String?>(sourceRegion),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  ScanExtractedFieldRecord copyWith({
    String? id,
    String? coffeeDraftId,
    String? fieldKey,
    Value<String?> rawValue = const Value.absent(),
    Value<String?> normalizedValue = const Value.absent(),
    Value<int?> confidenceBasisPoints = const Value.absent(),
    String? reviewStatus,
    Value<String?> sourceRegion = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => ScanExtractedFieldRecord(
    id: id ?? this.id,
    coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
    fieldKey: fieldKey ?? this.fieldKey,
    rawValue: rawValue.present ? rawValue.value : this.rawValue,
    normalizedValue: normalizedValue.present
        ? normalizedValue.value
        : this.normalizedValue,
    confidenceBasisPoints: confidenceBasisPoints.present
        ? confidenceBasisPoints.value
        : this.confidenceBasisPoints,
    reviewStatus: reviewStatus ?? this.reviewStatus,
    sourceRegion: sourceRegion.present ? sourceRegion.value : this.sourceRegion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScanExtractedFieldRecord copyWithCompanion(
    ScanExtractedFieldsCompanion data,
  ) {
    return ScanExtractedFieldRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeDraftId: data.coffeeDraftId.present
          ? data.coffeeDraftId.value
          : this.coffeeDraftId,
      fieldKey: data.fieldKey.present ? data.fieldKey.value : this.fieldKey,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      confidenceBasisPoints: data.confidenceBasisPoints.present
          ? data.confidenceBasisPoints.value
          : this.confidenceBasisPoints,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      sourceRegion: data.sourceRegion.present
          ? data.sourceRegion.value
          : this.sourceRegion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanExtractedFieldRecord(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('rawValue: $rawValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('confidenceBasisPoints: $confidenceBasisPoints, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('sourceRegion: $sourceRegion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeDraftId,
    fieldKey,
    rawValue,
    normalizedValue,
    confidenceBasisPoints,
    reviewStatus,
    sourceRegion,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanExtractedFieldRecord &&
          other.id == this.id &&
          other.coffeeDraftId == this.coffeeDraftId &&
          other.fieldKey == this.fieldKey &&
          other.rawValue == this.rawValue &&
          other.normalizedValue == this.normalizedValue &&
          other.confidenceBasisPoints == this.confidenceBasisPoints &&
          other.reviewStatus == this.reviewStatus &&
          other.sourceRegion == this.sourceRegion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScanExtractedFieldsCompanion
    extends UpdateCompanion<ScanExtractedFieldRecord> {
  final Value<String> id;
  final Value<String> coffeeDraftId;
  final Value<String> fieldKey;
  final Value<String?> rawValue;
  final Value<String?> normalizedValue;
  final Value<int?> confidenceBasisPoints;
  final Value<String> reviewStatus;
  final Value<String?> sourceRegion;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const ScanExtractedFieldsCompanion({
    this.id = const Value.absent(),
    this.coffeeDraftId = const Value.absent(),
    this.fieldKey = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.confidenceBasisPoints = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.sourceRegion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanExtractedFieldsCompanion.insert({
    required String id,
    required String coffeeDraftId,
    required String fieldKey,
    this.rawValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.confidenceBasisPoints = const Value.absent(),
    required String reviewStatus,
    this.sourceRegion = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeDraftId = Value(coffeeDraftId),
       fieldKey = Value(fieldKey),
       reviewStatus = Value(reviewStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScanExtractedFieldRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeDraftId,
    Expression<String>? fieldKey,
    Expression<String>? rawValue,
    Expression<String>? normalizedValue,
    Expression<int>? confidenceBasisPoints,
    Expression<String>? reviewStatus,
    Expression<String>? sourceRegion,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeDraftId != null) 'coffee_draft_id': coffeeDraftId,
      if (fieldKey != null) 'field_key': fieldKey,
      if (rawValue != null) 'raw_value': rawValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (confidenceBasisPoints != null)
        'confidence_basis_points': confidenceBasisPoints,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (sourceRegion != null) 'source_region': sourceRegion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanExtractedFieldsCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeDraftId,
    Value<String>? fieldKey,
    Value<String?>? rawValue,
    Value<String?>? normalizedValue,
    Value<int?>? confidenceBasisPoints,
    Value<String>? reviewStatus,
    Value<String?>? sourceRegion,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScanExtractedFieldsCompanion(
      id: id ?? this.id,
      coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
      fieldKey: fieldKey ?? this.fieldKey,
      rawValue: rawValue ?? this.rawValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      confidenceBasisPoints:
          confidenceBasisPoints ?? this.confidenceBasisPoints,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      sourceRegion: sourceRegion ?? this.sourceRegion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeDraftId.present) {
      map['coffee_draft_id'] = Variable<String>(coffeeDraftId.value);
    }
    if (fieldKey.present) {
      map['field_key'] = Variable<String>(fieldKey.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<String>(rawValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (confidenceBasisPoints.present) {
      map['confidence_basis_points'] = Variable<int>(
        confidenceBasisPoints.value,
      );
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (sourceRegion.present) {
      map['source_region'] = Variable<String>(sourceRegion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanExtractedFieldsCompanion(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('rawValue: $rawValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('confidenceBasisPoints: $confidenceBasisPoints, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('sourceRegion: $sourceRegion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeeVarietiesTable extends CoffeeVarieties
    with TableInfo<$CoffeeVarietiesTable, CoffeeVarietyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeVarietiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_varieties';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeVarietyRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayValueMeta);
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedValueMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {coffeeId, normalizedValue},
    {coffeeId, position},
  ];
  @override
  CoffeeVarietyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeVarietyRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      )!,
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CoffeeVarietiesTable createAlias(String alias) {
    return $CoffeeVarietiesTable(attachedDatabase, alias);
  }
}

class CoffeeVarietyRecord extends DataClass
    implements Insertable<CoffeeVarietyRecord> {
  final String id;
  final String coffeeId;
  final String displayValue;
  final String normalizedValue;
  final int position;
  final int createdAt;
  const CoffeeVarietyRecord({
    required this.id,
    required this.coffeeId,
    required this.displayValue,
    required this.normalizedValue,
    required this.position,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_id'] = Variable<String>(coffeeId);
    map['display_value'] = Variable<String>(displayValue);
    map['normalized_value'] = Variable<String>(normalizedValue);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CoffeeVarietiesCompanion toCompanion(bool nullToAbsent) {
    return CoffeeVarietiesCompanion(
      id: Value(id),
      coffeeId: Value(coffeeId),
      displayValue: Value(displayValue),
      normalizedValue: Value(normalizedValue),
      position: Value(position),
      createdAt: Value(createdAt),
    );
  }

  factory CoffeeVarietyRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeVarietyRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      displayValue: serializer.fromJson<String>(json['displayValue']),
      normalizedValue: serializer.fromJson<String>(json['normalizedValue']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeId': serializer.toJson<String>(coffeeId),
      'displayValue': serializer.toJson<String>(displayValue),
      'normalizedValue': serializer.toJson<String>(normalizedValue),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CoffeeVarietyRecord copyWith({
    String? id,
    String? coffeeId,
    String? displayValue,
    String? normalizedValue,
    int? position,
    int? createdAt,
  }) => CoffeeVarietyRecord(
    id: id ?? this.id,
    coffeeId: coffeeId ?? this.coffeeId,
    displayValue: displayValue ?? this.displayValue,
    normalizedValue: normalizedValue ?? this.normalizedValue,
    position: position ?? this.position,
    createdAt: createdAt ?? this.createdAt,
  );
  CoffeeVarietyRecord copyWithCompanion(CoffeeVarietiesCompanion data) {
    return CoffeeVarietyRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeVarietyRecord(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeVarietyRecord &&
          other.id == this.id &&
          other.coffeeId == this.coffeeId &&
          other.displayValue == this.displayValue &&
          other.normalizedValue == this.normalizedValue &&
          other.position == this.position &&
          other.createdAt == this.createdAt);
}

class CoffeeVarietiesCompanion extends UpdateCompanion<CoffeeVarietyRecord> {
  final Value<String> id;
  final Value<String> coffeeId;
  final Value<String> displayValue;
  final Value<String> normalizedValue;
  final Value<int> position;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CoffeeVarietiesCompanion({
    this.id = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeVarietiesCompanion.insert({
    required String id,
    required String coffeeId,
    required String displayValue,
    required String normalizedValue,
    required int position,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeId = Value(coffeeId),
       displayValue = Value(displayValue),
       normalizedValue = Value(normalizedValue),
       position = Value(position),
       createdAt = Value(createdAt);
  static Insertable<CoffeeVarietyRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeId,
    Expression<String>? displayValue,
    Expression<String>? normalizedValue,
    Expression<int>? position,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (displayValue != null) 'display_value': displayValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeVarietiesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeId,
    Value<String>? displayValue,
    Value<String>? normalizedValue,
    Value<int>? position,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CoffeeVarietiesCompanion(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      displayValue: displayValue ?? this.displayValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeVarietiesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeeTastingNotesTable extends CoffeeTastingNotes
    with TableInfo<$CoffeeTastingNotesTable, CoffeeTastingNoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeTastingNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_tasting_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeTastingNoteRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayValueMeta);
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedValueMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {coffeeId, normalizedValue},
    {coffeeId, position},
  ];
  @override
  CoffeeTastingNoteRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeTastingNoteRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      )!,
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CoffeeTastingNotesTable createAlias(String alias) {
    return $CoffeeTastingNotesTable(attachedDatabase, alias);
  }
}

class CoffeeTastingNoteRecord extends DataClass
    implements Insertable<CoffeeTastingNoteRecord> {
  final String id;
  final String coffeeId;
  final String displayValue;
  final String normalizedValue;
  final int position;
  final int createdAt;
  const CoffeeTastingNoteRecord({
    required this.id,
    required this.coffeeId,
    required this.displayValue,
    required this.normalizedValue,
    required this.position,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_id'] = Variable<String>(coffeeId);
    map['display_value'] = Variable<String>(displayValue);
    map['normalized_value'] = Variable<String>(normalizedValue);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CoffeeTastingNotesCompanion toCompanion(bool nullToAbsent) {
    return CoffeeTastingNotesCompanion(
      id: Value(id),
      coffeeId: Value(coffeeId),
      displayValue: Value(displayValue),
      normalizedValue: Value(normalizedValue),
      position: Value(position),
      createdAt: Value(createdAt),
    );
  }

  factory CoffeeTastingNoteRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeTastingNoteRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      displayValue: serializer.fromJson<String>(json['displayValue']),
      normalizedValue: serializer.fromJson<String>(json['normalizedValue']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeId': serializer.toJson<String>(coffeeId),
      'displayValue': serializer.toJson<String>(displayValue),
      'normalizedValue': serializer.toJson<String>(normalizedValue),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CoffeeTastingNoteRecord copyWith({
    String? id,
    String? coffeeId,
    String? displayValue,
    String? normalizedValue,
    int? position,
    int? createdAt,
  }) => CoffeeTastingNoteRecord(
    id: id ?? this.id,
    coffeeId: coffeeId ?? this.coffeeId,
    displayValue: displayValue ?? this.displayValue,
    normalizedValue: normalizedValue ?? this.normalizedValue,
    position: position ?? this.position,
    createdAt: createdAt ?? this.createdAt,
  );
  CoffeeTastingNoteRecord copyWithCompanion(CoffeeTastingNotesCompanion data) {
    return CoffeeTastingNoteRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeTastingNoteRecord(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeTastingNoteRecord &&
          other.id == this.id &&
          other.coffeeId == this.coffeeId &&
          other.displayValue == this.displayValue &&
          other.normalizedValue == this.normalizedValue &&
          other.position == this.position &&
          other.createdAt == this.createdAt);
}

class CoffeeTastingNotesCompanion
    extends UpdateCompanion<CoffeeTastingNoteRecord> {
  final Value<String> id;
  final Value<String> coffeeId;
  final Value<String> displayValue;
  final Value<String> normalizedValue;
  final Value<int> position;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CoffeeTastingNotesCompanion({
    this.id = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeTastingNotesCompanion.insert({
    required String id,
    required String coffeeId,
    required String displayValue,
    required String normalizedValue,
    required int position,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeId = Value(coffeeId),
       displayValue = Value(displayValue),
       normalizedValue = Value(normalizedValue),
       position = Value(position),
       createdAt = Value(createdAt);
  static Insertable<CoffeeTastingNoteRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeId,
    Expression<String>? displayValue,
    Expression<String>? normalizedValue,
    Expression<int>? position,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (displayValue != null) 'display_value': displayValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeTastingNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeId,
    Value<String>? displayValue,
    Value<String>? normalizedValue,
    Value<int>? position,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CoffeeTastingNotesCompanion(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      displayValue: displayValue ?? this.displayValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeTastingNotesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeePhotosTable extends CoffeePhotos
    with TableInfo<$CoffeePhotosTable, CoffeePhotoRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthPixelsMeta = const VerificationMeta(
    'widthPixels',
  );
  @override
  late final GeneratedColumn<int> widthPixels = GeneratedColumn<int>(
    'width_pixels',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightPixelsMeta = const VerificationMeta(
    'heightPixels',
  );
  @override
  late final GeneratedColumn<int> heightPixels = GeneratedColumn<int>(
    'height_pixels',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteSizeMeta = const VerificationMeta(
    'byteSize',
  );
  @override
  late final GeneratedColumn<int> byteSize = GeneratedColumn<int>(
    'byte_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeId,
    localPath,
    role,
    mimeType,
    widthPixels,
    heightPixels,
    byteSize,
    contentHash,
    source,
    position,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeePhotoRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('width_pixels')) {
      context.handle(
        _widthPixelsMeta,
        widthPixels.isAcceptableOrUnknown(
          data['width_pixels']!,
          _widthPixelsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_widthPixelsMeta);
    }
    if (data.containsKey('height_pixels')) {
      context.handle(
        _heightPixelsMeta,
        heightPixels.isAcceptableOrUnknown(
          data['height_pixels']!,
          _heightPixelsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_heightPixelsMeta);
    }
    if (data.containsKey('byte_size')) {
      context.handle(
        _byteSizeMeta,
        byteSize.isAcceptableOrUnknown(data['byte_size']!, _byteSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_byteSizeMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {coffeeId, role},
  ];
  @override
  CoffeePhotoRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeePhotoRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      widthPixels: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width_pixels'],
      )!,
      heightPixels: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_pixels'],
      )!,
      byteSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_size'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CoffeePhotosTable createAlias(String alias) {
    return $CoffeePhotosTable(attachedDatabase, alias);
  }
}

class CoffeePhotoRecord extends DataClass
    implements Insertable<CoffeePhotoRecord> {
  final String id;
  final String coffeeId;
  final String localPath;
  final String role;
  final String mimeType;
  final int widthPixels;
  final int heightPixels;
  final int byteSize;
  final String? contentHash;
  final String source;
  final int position;
  final int createdAt;
  const CoffeePhotoRecord({
    required this.id,
    required this.coffeeId,
    required this.localPath,
    required this.role,
    required this.mimeType,
    required this.widthPixels,
    required this.heightPixels,
    required this.byteSize,
    this.contentHash,
    required this.source,
    required this.position,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_id'] = Variable<String>(coffeeId);
    map['local_path'] = Variable<String>(localPath);
    map['role'] = Variable<String>(role);
    map['mime_type'] = Variable<String>(mimeType);
    map['width_pixels'] = Variable<int>(widthPixels);
    map['height_pixels'] = Variable<int>(heightPixels);
    map['byte_size'] = Variable<int>(byteSize);
    if (!nullToAbsent || contentHash != null) {
      map['content_hash'] = Variable<String>(contentHash);
    }
    map['source'] = Variable<String>(source);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CoffeePhotosCompanion toCompanion(bool nullToAbsent) {
    return CoffeePhotosCompanion(
      id: Value(id),
      coffeeId: Value(coffeeId),
      localPath: Value(localPath),
      role: Value(role),
      mimeType: Value(mimeType),
      widthPixels: Value(widthPixels),
      heightPixels: Value(heightPixels),
      byteSize: Value(byteSize),
      contentHash: contentHash == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHash),
      source: Value(source),
      position: Value(position),
      createdAt: Value(createdAt),
    );
  }

  factory CoffeePhotoRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeePhotoRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      role: serializer.fromJson<String>(json['role']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      widthPixels: serializer.fromJson<int>(json['widthPixels']),
      heightPixels: serializer.fromJson<int>(json['heightPixels']),
      byteSize: serializer.fromJson<int>(json['byteSize']),
      contentHash: serializer.fromJson<String?>(json['contentHash']),
      source: serializer.fromJson<String>(json['source']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeId': serializer.toJson<String>(coffeeId),
      'localPath': serializer.toJson<String>(localPath),
      'role': serializer.toJson<String>(role),
      'mimeType': serializer.toJson<String>(mimeType),
      'widthPixels': serializer.toJson<int>(widthPixels),
      'heightPixels': serializer.toJson<int>(heightPixels),
      'byteSize': serializer.toJson<int>(byteSize),
      'contentHash': serializer.toJson<String?>(contentHash),
      'source': serializer.toJson<String>(source),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CoffeePhotoRecord copyWith({
    String? id,
    String? coffeeId,
    String? localPath,
    String? role,
    String? mimeType,
    int? widthPixels,
    int? heightPixels,
    int? byteSize,
    Value<String?> contentHash = const Value.absent(),
    String? source,
    int? position,
    int? createdAt,
  }) => CoffeePhotoRecord(
    id: id ?? this.id,
    coffeeId: coffeeId ?? this.coffeeId,
    localPath: localPath ?? this.localPath,
    role: role ?? this.role,
    mimeType: mimeType ?? this.mimeType,
    widthPixels: widthPixels ?? this.widthPixels,
    heightPixels: heightPixels ?? this.heightPixels,
    byteSize: byteSize ?? this.byteSize,
    contentHash: contentHash.present ? contentHash.value : this.contentHash,
    source: source ?? this.source,
    position: position ?? this.position,
    createdAt: createdAt ?? this.createdAt,
  );
  CoffeePhotoRecord copyWithCompanion(CoffeePhotosCompanion data) {
    return CoffeePhotoRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      role: data.role.present ? data.role.value : this.role,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      widthPixels: data.widthPixels.present
          ? data.widthPixels.value
          : this.widthPixels,
      heightPixels: data.heightPixels.present
          ? data.heightPixels.value
          : this.heightPixels,
      byteSize: data.byteSize.present ? data.byteSize.value : this.byteSize,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      source: data.source.present ? data.source.value : this.source,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeePhotoRecord(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('localPath: $localPath, ')
          ..write('role: $role, ')
          ..write('mimeType: $mimeType, ')
          ..write('widthPixels: $widthPixels, ')
          ..write('heightPixels: $heightPixels, ')
          ..write('byteSize: $byteSize, ')
          ..write('contentHash: $contentHash, ')
          ..write('source: $source, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeId,
    localPath,
    role,
    mimeType,
    widthPixels,
    heightPixels,
    byteSize,
    contentHash,
    source,
    position,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeePhotoRecord &&
          other.id == this.id &&
          other.coffeeId == this.coffeeId &&
          other.localPath == this.localPath &&
          other.role == this.role &&
          other.mimeType == this.mimeType &&
          other.widthPixels == this.widthPixels &&
          other.heightPixels == this.heightPixels &&
          other.byteSize == this.byteSize &&
          other.contentHash == this.contentHash &&
          other.source == this.source &&
          other.position == this.position &&
          other.createdAt == this.createdAt);
}

class CoffeePhotosCompanion extends UpdateCompanion<CoffeePhotoRecord> {
  final Value<String> id;
  final Value<String> coffeeId;
  final Value<String> localPath;
  final Value<String> role;
  final Value<String> mimeType;
  final Value<int> widthPixels;
  final Value<int> heightPixels;
  final Value<int> byteSize;
  final Value<String?> contentHash;
  final Value<String> source;
  final Value<int> position;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CoffeePhotosCompanion({
    this.id = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.role = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.widthPixels = const Value.absent(),
    this.heightPixels = const Value.absent(),
    this.byteSize = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.source = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeePhotosCompanion.insert({
    required String id,
    required String coffeeId,
    required String localPath,
    required String role,
    required String mimeType,
    required int widthPixels,
    required int heightPixels,
    required int byteSize,
    this.contentHash = const Value.absent(),
    required String source,
    required int position,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeId = Value(coffeeId),
       localPath = Value(localPath),
       role = Value(role),
       mimeType = Value(mimeType),
       widthPixels = Value(widthPixels),
       heightPixels = Value(heightPixels),
       byteSize = Value(byteSize),
       source = Value(source),
       position = Value(position),
       createdAt = Value(createdAt);
  static Insertable<CoffeePhotoRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeId,
    Expression<String>? localPath,
    Expression<String>? role,
    Expression<String>? mimeType,
    Expression<int>? widthPixels,
    Expression<int>? heightPixels,
    Expression<int>? byteSize,
    Expression<String>? contentHash,
    Expression<String>? source,
    Expression<int>? position,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (localPath != null) 'local_path': localPath,
      if (role != null) 'role': role,
      if (mimeType != null) 'mime_type': mimeType,
      if (widthPixels != null) 'width_pixels': widthPixels,
      if (heightPixels != null) 'height_pixels': heightPixels,
      if (byteSize != null) 'byte_size': byteSize,
      if (contentHash != null) 'content_hash': contentHash,
      if (source != null) 'source': source,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeePhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeId,
    Value<String>? localPath,
    Value<String>? role,
    Value<String>? mimeType,
    Value<int>? widthPixels,
    Value<int>? heightPixels,
    Value<int>? byteSize,
    Value<String?>? contentHash,
    Value<String>? source,
    Value<int>? position,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CoffeePhotosCompanion(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      localPath: localPath ?? this.localPath,
      role: role ?? this.role,
      mimeType: mimeType ?? this.mimeType,
      widthPixels: widthPixels ?? this.widthPixels,
      heightPixels: heightPixels ?? this.heightPixels,
      byteSize: byteSize ?? this.byteSize,
      contentHash: contentHash ?? this.contentHash,
      source: source ?? this.source,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (widthPixels.present) {
      map['width_pixels'] = Variable<int>(widthPixels.value);
    }
    if (heightPixels.present) {
      map['height_pixels'] = Variable<int>(heightPixels.value);
    }
    if (byteSize.present) {
      map['byte_size'] = Variable<int>(byteSize.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeePhotosCompanion(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('localPath: $localPath, ')
          ..write('role: $role, ')
          ..write('mimeType: $mimeType, ')
          ..write('widthPixels: $widthPixels, ')
          ..write('heightPixels: $heightPixels, ')
          ..write('byteSize: $byteSize, ')
          ..write('contentHash: $contentHash, ')
          ..write('source: $source, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalTastingNotesTable extends JournalTastingNotes
    with TableInfo<$JournalTastingNotesTable, JournalTastingNoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalTastingNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _journalEntryIdMeta = const VerificationMeta(
    'journalEntryId',
  );
  @override
  late final GeneratedColumn<String> journalEntryId = GeneratedColumn<String>(
    'journal_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES journal_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    journalEntryId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_tasting_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalTastingNoteRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('journal_entry_id')) {
      context.handle(
        _journalEntryIdMeta,
        journalEntryId.isAcceptableOrUnknown(
          data['journal_entry_id']!,
          _journalEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_journalEntryIdMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayValueMeta);
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedValueMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {journalEntryId, normalizedValue},
    {journalEntryId, position},
  ];
  @override
  JournalTastingNoteRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalTastingNoteRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      journalEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}journal_entry_id'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      )!,
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalTastingNotesTable createAlias(String alias) {
    return $JournalTastingNotesTable(attachedDatabase, alias);
  }
}

class JournalTastingNoteRecord extends DataClass
    implements Insertable<JournalTastingNoteRecord> {
  final String id;
  final String journalEntryId;
  final String displayValue;
  final String normalizedValue;
  final int position;
  final int createdAt;
  const JournalTastingNoteRecord({
    required this.id,
    required this.journalEntryId,
    required this.displayValue,
    required this.normalizedValue,
    required this.position,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['journal_entry_id'] = Variable<String>(journalEntryId);
    map['display_value'] = Variable<String>(displayValue);
    map['normalized_value'] = Variable<String>(normalizedValue);
    map['position'] = Variable<int>(position);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  JournalTastingNotesCompanion toCompanion(bool nullToAbsent) {
    return JournalTastingNotesCompanion(
      id: Value(id),
      journalEntryId: Value(journalEntryId),
      displayValue: Value(displayValue),
      normalizedValue: Value(normalizedValue),
      position: Value(position),
      createdAt: Value(createdAt),
    );
  }

  factory JournalTastingNoteRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalTastingNoteRecord(
      id: serializer.fromJson<String>(json['id']),
      journalEntryId: serializer.fromJson<String>(json['journalEntryId']),
      displayValue: serializer.fromJson<String>(json['displayValue']),
      normalizedValue: serializer.fromJson<String>(json['normalizedValue']),
      position: serializer.fromJson<int>(json['position']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'journalEntryId': serializer.toJson<String>(journalEntryId),
      'displayValue': serializer.toJson<String>(displayValue),
      'normalizedValue': serializer.toJson<String>(normalizedValue),
      'position': serializer.toJson<int>(position),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  JournalTastingNoteRecord copyWith({
    String? id,
    String? journalEntryId,
    String? displayValue,
    String? normalizedValue,
    int? position,
    int? createdAt,
  }) => JournalTastingNoteRecord(
    id: id ?? this.id,
    journalEntryId: journalEntryId ?? this.journalEntryId,
    displayValue: displayValue ?? this.displayValue,
    normalizedValue: normalizedValue ?? this.normalizedValue,
    position: position ?? this.position,
    createdAt: createdAt ?? this.createdAt,
  );
  JournalTastingNoteRecord copyWithCompanion(
    JournalTastingNotesCompanion data,
  ) {
    return JournalTastingNoteRecord(
      id: data.id.present ? data.id.value : this.id,
      journalEntryId: data.journalEntryId.present
          ? data.journalEntryId.value
          : this.journalEntryId,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      position: data.position.present ? data.position.value : this.position,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalTastingNoteRecord(')
          ..write('id: $id, ')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    journalEntryId,
    displayValue,
    normalizedValue,
    position,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalTastingNoteRecord &&
          other.id == this.id &&
          other.journalEntryId == this.journalEntryId &&
          other.displayValue == this.displayValue &&
          other.normalizedValue == this.normalizedValue &&
          other.position == this.position &&
          other.createdAt == this.createdAt);
}

class JournalTastingNotesCompanion
    extends UpdateCompanion<JournalTastingNoteRecord> {
  final Value<String> id;
  final Value<String> journalEntryId;
  final Value<String> displayValue;
  final Value<String> normalizedValue;
  final Value<int> position;
  final Value<int> createdAt;
  final Value<int> rowid;
  const JournalTastingNotesCompanion({
    this.id = const Value.absent(),
    this.journalEntryId = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.position = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalTastingNotesCompanion.insert({
    required String id,
    required String journalEntryId,
    required String displayValue,
    required String normalizedValue,
    required int position,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       journalEntryId = Value(journalEntryId),
       displayValue = Value(displayValue),
       normalizedValue = Value(normalizedValue),
       position = Value(position),
       createdAt = Value(createdAt);
  static Insertable<JournalTastingNoteRecord> custom({
    Expression<String>? id,
    Expression<String>? journalEntryId,
    Expression<String>? displayValue,
    Expression<String>? normalizedValue,
    Expression<int>? position,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (journalEntryId != null) 'journal_entry_id': journalEntryId,
      if (displayValue != null) 'display_value': displayValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (position != null) 'position': position,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalTastingNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? journalEntryId,
    Value<String>? displayValue,
    Value<String>? normalizedValue,
    Value<int>? position,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return JournalTastingNotesCompanion(
      id: id ?? this.id,
      journalEntryId: journalEntryId ?? this.journalEntryId,
      displayValue: displayValue ?? this.displayValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (journalEntryId.present) {
      map['journal_entry_id'] = Variable<String>(journalEntryId.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalTastingNotesCompanion(')
          ..write('id: $id, ')
          ..write('journalEntryId: $journalEntryId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftVarietiesTable extends DraftVarieties
    with TableInfo<$DraftVarietiesTable, DraftVarietyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftVarietiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeDraftIdMeta = const VerificationMeta(
    'coffeeDraftId',
  );
  @override
  late final GeneratedColumn<String> coffeeDraftId = GeneratedColumn<String>(
    'coffee_draft_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffee_drafts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeDraftId,
    displayValue,
    normalizedValue,
    position,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_varieties';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftVarietyRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_draft_id')) {
      context.handle(
        _coffeeDraftIdMeta,
        coffeeDraftId.isAcceptableOrUnknown(
          data['coffee_draft_id']!,
          _coffeeDraftIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeDraftIdMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayValueMeta);
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedValueMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {coffeeDraftId, normalizedValue},
    {coffeeDraftId, position},
  ];
  @override
  DraftVarietyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftVarietyRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeDraftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_draft_id'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      )!,
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $DraftVarietiesTable createAlias(String alias) {
    return $DraftVarietiesTable(attachedDatabase, alias);
  }
}

class DraftVarietyRecord extends DataClass
    implements Insertable<DraftVarietyRecord> {
  final String id;
  final String coffeeDraftId;
  final String displayValue;
  final String normalizedValue;
  final int position;
  final String source;
  const DraftVarietyRecord({
    required this.id,
    required this.coffeeDraftId,
    required this.displayValue,
    required this.normalizedValue,
    required this.position,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_draft_id'] = Variable<String>(coffeeDraftId);
    map['display_value'] = Variable<String>(displayValue);
    map['normalized_value'] = Variable<String>(normalizedValue);
    map['position'] = Variable<int>(position);
    map['source'] = Variable<String>(source);
    return map;
  }

  DraftVarietiesCompanion toCompanion(bool nullToAbsent) {
    return DraftVarietiesCompanion(
      id: Value(id),
      coffeeDraftId: Value(coffeeDraftId),
      displayValue: Value(displayValue),
      normalizedValue: Value(normalizedValue),
      position: Value(position),
      source: Value(source),
    );
  }

  factory DraftVarietyRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftVarietyRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeDraftId: serializer.fromJson<String>(json['coffeeDraftId']),
      displayValue: serializer.fromJson<String>(json['displayValue']),
      normalizedValue: serializer.fromJson<String>(json['normalizedValue']),
      position: serializer.fromJson<int>(json['position']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeDraftId': serializer.toJson<String>(coffeeDraftId),
      'displayValue': serializer.toJson<String>(displayValue),
      'normalizedValue': serializer.toJson<String>(normalizedValue),
      'position': serializer.toJson<int>(position),
      'source': serializer.toJson<String>(source),
    };
  }

  DraftVarietyRecord copyWith({
    String? id,
    String? coffeeDraftId,
    String? displayValue,
    String? normalizedValue,
    int? position,
    String? source,
  }) => DraftVarietyRecord(
    id: id ?? this.id,
    coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
    displayValue: displayValue ?? this.displayValue,
    normalizedValue: normalizedValue ?? this.normalizedValue,
    position: position ?? this.position,
    source: source ?? this.source,
  );
  DraftVarietyRecord copyWithCompanion(DraftVarietiesCompanion data) {
    return DraftVarietyRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeDraftId: data.coffeeDraftId.present
          ? data.coffeeDraftId.value
          : this.coffeeDraftId,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      position: data.position.present ? data.position.value : this.position,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftVarietyRecord(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeDraftId,
    displayValue,
    normalizedValue,
    position,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftVarietyRecord &&
          other.id == this.id &&
          other.coffeeDraftId == this.coffeeDraftId &&
          other.displayValue == this.displayValue &&
          other.normalizedValue == this.normalizedValue &&
          other.position == this.position &&
          other.source == this.source);
}

class DraftVarietiesCompanion extends UpdateCompanion<DraftVarietyRecord> {
  final Value<String> id;
  final Value<String> coffeeDraftId;
  final Value<String> displayValue;
  final Value<String> normalizedValue;
  final Value<int> position;
  final Value<String> source;
  final Value<int> rowid;
  const DraftVarietiesCompanion({
    this.id = const Value.absent(),
    this.coffeeDraftId = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.position = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftVarietiesCompanion.insert({
    required String id,
    required String coffeeDraftId,
    required String displayValue,
    required String normalizedValue,
    required int position,
    required String source,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeDraftId = Value(coffeeDraftId),
       displayValue = Value(displayValue),
       normalizedValue = Value(normalizedValue),
       position = Value(position),
       source = Value(source);
  static Insertable<DraftVarietyRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeDraftId,
    Expression<String>? displayValue,
    Expression<String>? normalizedValue,
    Expression<int>? position,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeDraftId != null) 'coffee_draft_id': coffeeDraftId,
      if (displayValue != null) 'display_value': displayValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (position != null) 'position': position,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftVarietiesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeDraftId,
    Value<String>? displayValue,
    Value<String>? normalizedValue,
    Value<int>? position,
    Value<String>? source,
    Value<int>? rowid,
  }) {
    return DraftVarietiesCompanion(
      id: id ?? this.id,
      coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
      displayValue: displayValue ?? this.displayValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      position: position ?? this.position,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeDraftId.present) {
      map['coffee_draft_id'] = Variable<String>(coffeeDraftId.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftVarietiesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftTastingNotesTable extends DraftTastingNotes
    with TableInfo<$DraftTastingNotesTable, DraftTastingNoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftTastingNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeDraftIdMeta = const VerificationMeta(
    'coffeeDraftId',
  );
  @override
  late final GeneratedColumn<String> coffeeDraftId = GeneratedColumn<String>(
    'coffee_draft_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffee_drafts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayValueMeta = const VerificationMeta(
    'displayValue',
  );
  @override
  late final GeneratedColumn<String> displayValue = GeneratedColumn<String>(
    'display_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedValueMeta = const VerificationMeta(
    'normalizedValue',
  );
  @override
  late final GeneratedColumn<String> normalizedValue = GeneratedColumn<String>(
    'normalized_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeDraftId,
    displayValue,
    normalizedValue,
    position,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_tasting_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftTastingNoteRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_draft_id')) {
      context.handle(
        _coffeeDraftIdMeta,
        coffeeDraftId.isAcceptableOrUnknown(
          data['coffee_draft_id']!,
          _coffeeDraftIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeDraftIdMeta);
    }
    if (data.containsKey('display_value')) {
      context.handle(
        _displayValueMeta,
        displayValue.isAcceptableOrUnknown(
          data['display_value']!,
          _displayValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayValueMeta);
    }
    if (data.containsKey('normalized_value')) {
      context.handle(
        _normalizedValueMeta,
        normalizedValue.isAcceptableOrUnknown(
          data['normalized_value']!,
          _normalizedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedValueMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {coffeeDraftId, normalizedValue},
    {coffeeDraftId, position},
  ];
  @override
  DraftTastingNoteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftTastingNoteRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeDraftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_draft_id'],
      )!,
      displayValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_value'],
      )!,
      normalizedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_value'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $DraftTastingNotesTable createAlias(String alias) {
    return $DraftTastingNotesTable(attachedDatabase, alias);
  }
}

class DraftTastingNoteRecord extends DataClass
    implements Insertable<DraftTastingNoteRecord> {
  final String id;
  final String coffeeDraftId;
  final String displayValue;
  final String normalizedValue;
  final int position;
  final String source;
  const DraftTastingNoteRecord({
    required this.id,
    required this.coffeeDraftId,
    required this.displayValue,
    required this.normalizedValue,
    required this.position,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_draft_id'] = Variable<String>(coffeeDraftId);
    map['display_value'] = Variable<String>(displayValue);
    map['normalized_value'] = Variable<String>(normalizedValue);
    map['position'] = Variable<int>(position);
    map['source'] = Variable<String>(source);
    return map;
  }

  DraftTastingNotesCompanion toCompanion(bool nullToAbsent) {
    return DraftTastingNotesCompanion(
      id: Value(id),
      coffeeDraftId: Value(coffeeDraftId),
      displayValue: Value(displayValue),
      normalizedValue: Value(normalizedValue),
      position: Value(position),
      source: Value(source),
    );
  }

  factory DraftTastingNoteRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftTastingNoteRecord(
      id: serializer.fromJson<String>(json['id']),
      coffeeDraftId: serializer.fromJson<String>(json['coffeeDraftId']),
      displayValue: serializer.fromJson<String>(json['displayValue']),
      normalizedValue: serializer.fromJson<String>(json['normalizedValue']),
      position: serializer.fromJson<int>(json['position']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeDraftId': serializer.toJson<String>(coffeeDraftId),
      'displayValue': serializer.toJson<String>(displayValue),
      'normalizedValue': serializer.toJson<String>(normalizedValue),
      'position': serializer.toJson<int>(position),
      'source': serializer.toJson<String>(source),
    };
  }

  DraftTastingNoteRecord copyWith({
    String? id,
    String? coffeeDraftId,
    String? displayValue,
    String? normalizedValue,
    int? position,
    String? source,
  }) => DraftTastingNoteRecord(
    id: id ?? this.id,
    coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
    displayValue: displayValue ?? this.displayValue,
    normalizedValue: normalizedValue ?? this.normalizedValue,
    position: position ?? this.position,
    source: source ?? this.source,
  );
  DraftTastingNoteRecord copyWithCompanion(DraftTastingNotesCompanion data) {
    return DraftTastingNoteRecord(
      id: data.id.present ? data.id.value : this.id,
      coffeeDraftId: data.coffeeDraftId.present
          ? data.coffeeDraftId.value
          : this.coffeeDraftId,
      displayValue: data.displayValue.present
          ? data.displayValue.value
          : this.displayValue,
      normalizedValue: data.normalizedValue.present
          ? data.normalizedValue.value
          : this.normalizedValue,
      position: data.position.present ? data.position.value : this.position,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftTastingNoteRecord(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    coffeeDraftId,
    displayValue,
    normalizedValue,
    position,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftTastingNoteRecord &&
          other.id == this.id &&
          other.coffeeDraftId == this.coffeeDraftId &&
          other.displayValue == this.displayValue &&
          other.normalizedValue == this.normalizedValue &&
          other.position == this.position &&
          other.source == this.source);
}

class DraftTastingNotesCompanion
    extends UpdateCompanion<DraftTastingNoteRecord> {
  final Value<String> id;
  final Value<String> coffeeDraftId;
  final Value<String> displayValue;
  final Value<String> normalizedValue;
  final Value<int> position;
  final Value<String> source;
  final Value<int> rowid;
  const DraftTastingNotesCompanion({
    this.id = const Value.absent(),
    this.coffeeDraftId = const Value.absent(),
    this.displayValue = const Value.absent(),
    this.normalizedValue = const Value.absent(),
    this.position = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftTastingNotesCompanion.insert({
    required String id,
    required String coffeeDraftId,
    required String displayValue,
    required String normalizedValue,
    required int position,
    required String source,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeDraftId = Value(coffeeDraftId),
       displayValue = Value(displayValue),
       normalizedValue = Value(normalizedValue),
       position = Value(position),
       source = Value(source);
  static Insertable<DraftTastingNoteRecord> custom({
    Expression<String>? id,
    Expression<String>? coffeeDraftId,
    Expression<String>? displayValue,
    Expression<String>? normalizedValue,
    Expression<int>? position,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeDraftId != null) 'coffee_draft_id': coffeeDraftId,
      if (displayValue != null) 'display_value': displayValue,
      if (normalizedValue != null) 'normalized_value': normalizedValue,
      if (position != null) 'position': position,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftTastingNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeDraftId,
    Value<String>? displayValue,
    Value<String>? normalizedValue,
    Value<int>? position,
    Value<String>? source,
    Value<int>? rowid,
  }) {
    return DraftTastingNotesCompanion(
      id: id ?? this.id,
      coffeeDraftId: coffeeDraftId ?? this.coffeeDraftId,
      displayValue: displayValue ?? this.displayValue,
      normalizedValue: normalizedValue ?? this.normalizedValue,
      position: position ?? this.position,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeDraftId.present) {
      map['coffee_draft_id'] = Variable<String>(coffeeDraftId.value);
    }
    if (displayValue.present) {
      map['display_value'] = Variable<String>(displayValue.value);
    }
    if (normalizedValue.present) {
      map['normalized_value'] = Variable<String>(normalizedValue.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftTastingNotesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeDraftId: $coffeeDraftId, ')
          ..write('displayValue: $displayValue, ')
          ..write('normalizedValue: $normalizedValue, ')
          ..write('position: $position, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FileCleanupTasksTable extends FileCleanupTasks
    with TableInfo<$FileCleanupTasksTable, FileCleanupRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileCleanupTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, localPath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_cleanup_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<FileCleanupRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localPath},
  ];
  @override
  FileCleanupRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileCleanupRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FileCleanupTasksTable createAlias(String alias) {
    return $FileCleanupTasksTable(attachedDatabase, alias);
  }
}

class FileCleanupRecord extends DataClass
    implements Insertable<FileCleanupRecord> {
  final String id;
  final String localPath;
  final int createdAt;
  const FileCleanupRecord({
    required this.id,
    required this.localPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_path'] = Variable<String>(localPath);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  FileCleanupTasksCompanion toCompanion(bool nullToAbsent) {
    return FileCleanupTasksCompanion(
      id: Value(id),
      localPath: Value(localPath),
      createdAt: Value(createdAt),
    );
  }

  factory FileCleanupRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileCleanupRecord(
      id: serializer.fromJson<String>(json['id']),
      localPath: serializer.fromJson<String>(json['localPath']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localPath': serializer.toJson<String>(localPath),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  FileCleanupRecord copyWith({String? id, String? localPath, int? createdAt}) =>
      FileCleanupRecord(
        id: id ?? this.id,
        localPath: localPath ?? this.localPath,
        createdAt: createdAt ?? this.createdAt,
      );
  FileCleanupRecord copyWithCompanion(FileCleanupTasksCompanion data) {
    return FileCleanupRecord(
      id: data.id.present ? data.id.value : this.id,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FileCleanupRecord(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, localPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileCleanupRecord &&
          other.id == this.id &&
          other.localPath == this.localPath &&
          other.createdAt == this.createdAt);
}

class FileCleanupTasksCompanion extends UpdateCompanion<FileCleanupRecord> {
  final Value<String> id;
  final Value<String> localPath;
  final Value<int> createdAt;
  final Value<int> rowid;
  const FileCleanupTasksCompanion({
    this.id = const Value.absent(),
    this.localPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FileCleanupTasksCompanion.insert({
    required String id,
    required String localPath,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPath = Value(localPath),
       createdAt = Value(createdAt);
  static Insertable<FileCleanupRecord> custom({
    Expression<String>? id,
    Expression<String>? localPath,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localPath != null) 'local_path': localPath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FileCleanupTasksCompanion copyWith({
    Value<String>? id,
    Value<String>? localPath,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return FileCleanupTasksCompanion(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileCleanupTasksCompanion(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoffeesTable coffees = $CoffeesTable(this);
  late final Index coffeesQuery0 = Index(
    'coffees_query_0',
    'CREATE INDEX coffees_query_0 ON coffees (created_at DESC, id)',
  );
  late final Index coffeesQuery1 = Index(
    'coffees_query_1',
    'CREATE INDEX coffees_query_1 ON coffees (updated_at DESC)',
  );
  late final Index coffeesQuery2 = Index(
    'coffees_query_2',
    'CREATE INDEX coffees_query_2 ON coffees (name_normalized)',
  );
  late final Index coffeesQuery3 = Index(
    'coffees_query_3',
    'CREATE INDEX coffees_query_3 ON coffees (roastery_normalized)',
  );
  late final Index coffeesQuery4 = Index(
    'coffees_query_4',
    'CREATE INDEX coffees_query_4 ON coffees (origin_country_normalized)',
  );
  late final Index coffeesQuery5 = Index(
    'coffees_query_5',
    'CREATE INDEX coffees_query_5 ON coffees (process_normalized)',
  );
  late final Index coffeesQuery6 = Index(
    'coffees_query_6',
    'CREATE INDEX coffees_query_6 ON coffees (roast_level_key)',
  );
  late final Index coffeesQuery7 = Index(
    'coffees_query_7',
    'CREATE INDEX coffees_query_7 ON coffees (roast_date)',
  );
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final Index journalEntriesQuery0 = Index(
    'journal_entries_query_0',
    'CREATE INDEX journal_entries_query_0 ON journal_entries (coffee_id, brewed_at DESC)',
  );
  late final Index journalEntriesQuery1 = Index(
    'journal_entries_query_1',
    'CREATE INDEX journal_entries_query_1 ON journal_entries (brewed_at DESC)',
  );
  late final Index journalEntriesQuery2 = Index(
    'journal_entries_query_2',
    'CREATE INDEX journal_entries_query_2 ON journal_entries (brew_method_key)',
  );
  late final Index journalEntriesQuery3 = Index(
    'journal_entries_query_3',
    'CREATE INDEX journal_entries_query_3 ON journal_entries (rating)',
  );
  late final $CoffeeDraftsTable coffeeDrafts = $CoffeeDraftsTable(this);
  late final Index coffeeDraftsQuery0 = Index(
    'coffee_drafts_query_0',
    'CREATE INDEX coffee_drafts_query_0 ON coffee_drafts (status, updated_at)',
  );
  late final Index coffeeDraftsQuery1 = Index(
    'coffee_drafts_query_1',
    'CREATE INDEX coffee_drafts_query_1 ON coffee_drafts (target_coffee_id)',
  );
  late final $ScanExtractedFieldsTable scanExtractedFields =
      $ScanExtractedFieldsTable(this);
  late final Index scanExtractedFieldsQuery0 = Index(
    'scan_extracted_fields_query_0',
    'CREATE INDEX scan_extracted_fields_query_0 ON scan_extracted_fields (coffee_draft_id, field_key)',
  );
  late final Trigger coffeeRevision = Trigger(
    'CREATE TRIGGER coffee_revision AFTER UPDATE ON coffees WHEN NEW.revision = OLD.revision BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = NEW.id;END',
    'coffee_revision',
  );
  late final $CoffeeVarietiesTable coffeeVarieties = $CoffeeVarietiesTable(
    this,
  );
  late final Trigger coffeeVarietiesInsertRevision = Trigger(
    'CREATE TRIGGER coffee_varieties_insert_revision AFTER INSERT ON coffee_varieties BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = NEW.coffee_id;END',
    'coffee_varieties_insert_revision',
  );
  late final Trigger coffeeVarietiesUpdateRevision = Trigger(
    'CREATE TRIGGER coffee_varieties_update_revision AFTER UPDATE ON coffee_varieties BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id OR id = NEW.coffee_id;END',
    'coffee_varieties_update_revision',
  );
  late final Trigger coffeeVarietiesDeleteRevision = Trigger(
    'CREATE TRIGGER coffee_varieties_delete_revision AFTER DELETE ON coffee_varieties BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id;END',
    'coffee_varieties_delete_revision',
  );
  late final $CoffeeTastingNotesTable coffeeTastingNotes =
      $CoffeeTastingNotesTable(this);
  late final Trigger coffeeTastingNotesInsertRevision = Trigger(
    'CREATE TRIGGER coffee_tasting_notes_insert_revision AFTER INSERT ON coffee_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = NEW.coffee_id;END',
    'coffee_tasting_notes_insert_revision',
  );
  late final Trigger coffeeTastingNotesUpdateRevision = Trigger(
    'CREATE TRIGGER coffee_tasting_notes_update_revision AFTER UPDATE ON coffee_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id OR id = NEW.coffee_id;END',
    'coffee_tasting_notes_update_revision',
  );
  late final Trigger coffeeTastingNotesDeleteRevision = Trigger(
    'CREATE TRIGGER coffee_tasting_notes_delete_revision AFTER DELETE ON coffee_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id;END',
    'coffee_tasting_notes_delete_revision',
  );
  late final $CoffeePhotosTable coffeePhotos = $CoffeePhotosTable(this);
  late final Trigger coffeePhotosInsertRevision = Trigger(
    'CREATE TRIGGER coffee_photos_insert_revision AFTER INSERT ON coffee_photos BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = NEW.coffee_id;END',
    'coffee_photos_insert_revision',
  );
  late final Trigger coffeePhotosUpdateRevision = Trigger(
    'CREATE TRIGGER coffee_photos_update_revision AFTER UPDATE ON coffee_photos BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id OR id = NEW.coffee_id;END',
    'coffee_photos_update_revision',
  );
  late final Trigger coffeePhotosDeleteRevision = Trigger(
    'CREATE TRIGGER coffee_photos_delete_revision AFTER DELETE ON coffee_photos BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id;END',
    'coffee_photos_delete_revision',
  );
  late final Trigger journalEntriesInsertRevision = Trigger(
    'CREATE TRIGGER journal_entries_insert_revision AFTER INSERT ON journal_entries BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = NEW.coffee_id;END',
    'journal_entries_insert_revision',
  );
  late final Trigger journalEntriesUpdateRevision = Trigger(
    'CREATE TRIGGER journal_entries_update_revision AFTER UPDATE ON journal_entries BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id OR id = NEW.coffee_id;END',
    'journal_entries_update_revision',
  );
  late final Trigger journalEntriesDeleteRevision = Trigger(
    'CREATE TRIGGER journal_entries_delete_revision AFTER DELETE ON journal_entries BEGIN UPDATE coffees SET revision = revision + 1 WHERE id = OLD.coffee_id;END',
    'journal_entries_delete_revision',
  );
  late final $JournalTastingNotesTable journalTastingNotes =
      $JournalTastingNotesTable(this);
  late final Trigger journalNotesInsertRevision = Trigger(
    'CREATE TRIGGER journal_notes_insert_revision AFTER INSERT ON journal_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id IN (SELECT coffee_id FROM journal_entries WHERE id = NEW.journal_entry_id);END',
    'journal_notes_insert_revision',
  );
  late final Trigger journalNotesUpdateRevision = Trigger(
    'CREATE TRIGGER journal_notes_update_revision AFTER UPDATE ON journal_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id IN (SELECT coffee_id FROM journal_entries WHERE id = OLD.journal_entry_id OR id = NEW.journal_entry_id);END',
    'journal_notes_update_revision',
  );
  late final Trigger journalNotesDeleteRevision = Trigger(
    'CREATE TRIGGER journal_notes_delete_revision AFTER DELETE ON journal_tasting_notes BEGIN UPDATE coffees SET revision = revision + 1 WHERE id IN (SELECT coffee_id FROM journal_entries WHERE id = OLD.journal_entry_id);END',
    'journal_notes_delete_revision',
  );
  late final $DraftVarietiesTable draftVarieties = $DraftVarietiesTable(this);
  late final $DraftTastingNotesTable draftTastingNotes =
      $DraftTastingNotesTable(this);
  late final $FileCleanupTasksTable fileCleanupTasks = $FileCleanupTasksTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    coffees,
    coffeesQuery0,
    coffeesQuery1,
    coffeesQuery2,
    coffeesQuery3,
    coffeesQuery4,
    coffeesQuery5,
    coffeesQuery6,
    coffeesQuery7,
    journalEntries,
    journalEntriesQuery0,
    journalEntriesQuery1,
    journalEntriesQuery2,
    journalEntriesQuery3,
    coffeeDrafts,
    coffeeDraftsQuery0,
    coffeeDraftsQuery1,
    scanExtractedFields,
    scanExtractedFieldsQuery0,
    coffeeRevision,
    coffeeVarieties,
    coffeeVarietiesInsertRevision,
    coffeeVarietiesUpdateRevision,
    coffeeVarietiesDeleteRevision,
    coffeeTastingNotes,
    coffeeTastingNotesInsertRevision,
    coffeeTastingNotesUpdateRevision,
    coffeeTastingNotesDeleteRevision,
    coffeePhotos,
    coffeePhotosInsertRevision,
    coffeePhotosUpdateRevision,
    coffeePhotosDeleteRevision,
    journalEntriesInsertRevision,
    journalEntriesUpdateRevision,
    journalEntriesDeleteRevision,
    journalTastingNotes,
    journalNotesInsertRevision,
    journalNotesUpdateRevision,
    journalNotesDeleteRevision,
    draftVarieties,
    draftTastingNotes,
    fileCleanupTasks,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_drafts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_drafts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scan_extracted_fields', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_varieties', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_varieties',
        limitUpdateKind: UpdateKind.insert,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_varieties',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_varieties',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_tasting_notes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_tasting_notes',
        limitUpdateKind: UpdateKind.insert,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_tasting_notes',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_tasting_notes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_photos',
        limitUpdateKind: UpdateKind.insert,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_photos',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_photos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.insert,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_tasting_notes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_tasting_notes',
        limitUpdateKind: UpdateKind.insert,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_tasting_notes',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'journal_tasting_notes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffees', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_drafts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('draft_varieties', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffee_drafts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('draft_tasting_notes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CoffeesTableCreateCompanionBuilder = CoffeesCompanion Function({
  required String id,
  required String name,
  required String nameNormalized,
  required String roastery,
  required String roasteryNormalized,
  Value<String?> originCountry,
  Value<String?> originCountryNormalized,
  Value<String?> region,
  Value<String?> regionNormalized,
  Value<String?> producer,
  Value<String?> producerNormalized,
  Value<String?> process,
  Value<String?> processNormalized,
  Value<String?> originCountryCode,
  Value<String?> roastLevelKey,
  Value<String?> roastLevelCustom,
  Value<int?> altitudeMinMeters,
  Value<int?> altitudeMaxMeters,
  Value<String?> altitudeSourceText,
  Value<String?> roastDate,
  Value<String?> purchaseDate,
  Value<int?> packageWeightGrams,
  Value<String?> personalNote,
  Value<bool> isFavorite,
  Value<int> revision,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$CoffeesTableUpdateCompanionBuilder = CoffeesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> nameNormalized,
  Value<String> roastery,
  Value<String> roasteryNormalized,
  Value<String?> originCountry,
  Value<String?> originCountryNormalized,
  Value<String?> region,
  Value<String?> regionNormalized,
  Value<String?> producer,
  Value<String?> producerNormalized,
  Value<String?> process,
  Value<String?> processNormalized,
  Value<String?> originCountryCode,
  Value<String?> roastLevelKey,
  Value<String?> roastLevelCustom,
  Value<int?> altitudeMinMeters,
  Value<int?> altitudeMaxMeters,
  Value<String?> altitudeSourceText,
  Value<String?> roastDate,
  Value<String?> purchaseDate,
  Value<int?> packageWeightGrams,
  Value<String?> personalNote,
  Value<bool> isFavorite,
  Value<int> revision,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

final class $$CoffeesTableReferences
    extends BaseReferences<_$AppDatabase, $CoffeesTable, CoffeeRecord> {
  $$CoffeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalRecord>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: 'coffees__id__journal_entries__coffee_id',
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoffeeDraftsTable, List<DraftRecord>>
  _coffeeDraftsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeeDrafts,
    aliasName: 'coffees__id__coffee_drafts__target_coffee_id',
  );

  $$CoffeeDraftsTableProcessedTableManager get coffeeDraftsRefs {
    final manager = $$CoffeeDraftsTableTableManager(
      $_db,
      $_db.coffeeDrafts,
    ).filter((f) => f.targetCoffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_coffeeDraftsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoffeeVarietiesTable, List<CoffeeVarietyRecord>>
  _coffeeVarietiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeeVarieties,
    aliasName: 'coffees__id__coffee_varieties__coffee_id',
  );

  $$CoffeeVarietiesTableProcessedTableManager get coffeeVarietiesRefs {
    final manager = $$CoffeeVarietiesTableTableManager(
      $_db,
      $_db.coffeeVarieties,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coffeeVarietiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CoffeeTastingNotesTable,
    List<CoffeeTastingNoteRecord>
  >
  _coffeeTastingNotesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.coffeeTastingNotes,
        aliasName: 'coffees__id__coffee_tasting_notes__coffee_id',
      );

  $$CoffeeTastingNotesTableProcessedTableManager get coffeeTastingNotesRefs {
    final manager = $$CoffeeTastingNotesTableTableManager(
      $_db,
      $_db.coffeeTastingNotes,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coffeeTastingNotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoffeePhotosTable, List<CoffeePhotoRecord>>
  _coffeePhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeePhotos,
    aliasName: 'coffees__id__coffee_photos__coffee_id',
  );

  $$CoffeePhotosTableProcessedTableManager get coffeePhotosRefs {
    final manager = $$CoffeePhotosTableTableManager(
      $_db,
      $_db.coffeePhotos,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_coffeePhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoffeesTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastery => $composableBuilder(
    column: $table.roastery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roasteryNormalized => $composableBuilder(
    column: $table.roasteryNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountryNormalized => $composableBuilder(
    column: $table.originCountryNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionNormalized => $composableBuilder(
    column: $table.regionNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get producerNormalized => $composableBuilder(
    column: $table.producerNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processNormalized => $composableBuilder(
    column: $table.processNormalized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coffeeDraftsRefs(
    Expression<bool> Function($$CoffeeDraftsTableFilterComposer f) f,
  ) {
    final $$CoffeeDraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.targetCoffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coffeeVarietiesRefs(
    Expression<bool> Function($$CoffeeVarietiesTableFilterComposer f) f,
  ) {
    final $$CoffeeVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeVarieties,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.coffeeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coffeeTastingNotesRefs(
    Expression<bool> Function($$CoffeeTastingNotesTableFilterComposer f) f,
  ) {
    final $$CoffeeTastingNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeTastingNotes,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeTastingNotesTableFilterComposer(
            $db: $db,
            $table: $db.coffeeTastingNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coffeePhotosRefs(
    Expression<bool> Function($$CoffeePhotosTableFilterComposer f) f,
  ) {
    final $$CoffeePhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeePhotos,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeePhotosTableFilterComposer(
            $db: $db,
            $table: $db.coffeePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoffeesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastery => $composableBuilder(
    column: $table.roastery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roasteryNormalized => $composableBuilder(
    column: $table.roasteryNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountryNormalized => $composableBuilder(
    column: $table.originCountryNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionNormalized => $composableBuilder(
    column: $table.regionNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get producerNormalized => $composableBuilder(
    column: $table.producerNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processNormalized => $composableBuilder(
    column: $table.processNormalized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoffeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameNormalized => $composableBuilder(
    column: $table.nameNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastery =>
      $composableBuilder(column: $table.roastery, builder: (column) => column);

  GeneratedColumn<String> get roasteryNormalized => $composableBuilder(
    column: $table.roasteryNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originCountryNormalized => $composableBuilder(
    column: $table.originCountryNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get regionNormalized => $composableBuilder(
    column: $table.regionNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<String> get producerNormalized => $composableBuilder(
    column: $table.producerNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get process =>
      $composableBuilder(column: $table.process, builder: (column) => column);

  GeneratedColumn<String> get processNormalized => $composableBuilder(
    column: $table.processNormalized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coffeeDraftsRefs<T extends Object>(
    Expression<T> Function($$CoffeeDraftsTableAnnotationComposer a) f,
  ) {
    final $$CoffeeDraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.targetCoffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coffeeVarietiesRefs<T extends Object>(
    Expression<T> Function($$CoffeeVarietiesTableAnnotationComposer a) f,
  ) {
    final $$CoffeeVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeVarieties,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coffeeTastingNotesRefs<T extends Object>(
    Expression<T> Function($$CoffeeTastingNotesTableAnnotationComposer a) f,
  ) {
    final $$CoffeeTastingNotesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.coffeeTastingNotes,
          getReferencedColumn: (t) => t.coffeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CoffeeTastingNotesTableAnnotationComposer(
                $db: $db,
                $table: $db.coffeeTastingNotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> coffeePhotosRefs<T extends Object>(
    Expression<T> Function($$CoffeePhotosTableAnnotationComposer a) f,
  ) {
    final $$CoffeePhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeePhotos,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeePhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoffeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeesTable,
          CoffeeRecord,
          $$CoffeesTableFilterComposer,
          $$CoffeesTableOrderingComposer,
          $$CoffeesTableAnnotationComposer,
          $$CoffeesTableCreateCompanionBuilder,
          $$CoffeesTableUpdateCompanionBuilder,
          (CoffeeRecord, $$CoffeesTableReferences),
          CoffeeRecord,
          PrefetchHooks Function({
            bool journalEntriesRefs,
            bool coffeeDraftsRefs,
            bool coffeeVarietiesRefs,
            bool coffeeTastingNotesRefs,
            bool coffeePhotosRefs,
          })
        > {
  $$CoffeesTableTableManager(_$AppDatabase db, $CoffeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameNormalized = const Value.absent(),
                Value<String> roastery = const Value.absent(),
                Value<String> roasteryNormalized = const Value.absent(),
                Value<String?> originCountry = const Value.absent(),
                Value<String?> originCountryNormalized = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> regionNormalized = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> producerNormalized = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> processNormalized = const Value.absent(),
                Value<String?> originCountryCode = const Value.absent(),
                Value<String?> roastLevelKey = const Value.absent(),
                Value<String?> roastLevelCustom = const Value.absent(),
                Value<int?> altitudeMinMeters = const Value.absent(),
                Value<int?> altitudeMaxMeters = const Value.absent(),
                Value<String?> altitudeSourceText = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String?> purchaseDate = const Value.absent(),
                Value<int?> packageWeightGrams = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeesCompanion(
                id: id,
                name: name,
                nameNormalized: nameNormalized,
                roastery: roastery,
                roasteryNormalized: roasteryNormalized,
                originCountry: originCountry,
                originCountryNormalized: originCountryNormalized,
                region: region,
                regionNormalized: regionNormalized,
                producer: producer,
                producerNormalized: producerNormalized,
                process: process,
                processNormalized: processNormalized,
                originCountryCode: originCountryCode,
                roastLevelKey: roastLevelKey,
                roastLevelCustom: roastLevelCustom,
                altitudeMinMeters: altitudeMinMeters,
                altitudeMaxMeters: altitudeMaxMeters,
                altitudeSourceText: altitudeSourceText,
                roastDate: roastDate,
                purchaseDate: purchaseDate,
                packageWeightGrams: packageWeightGrams,
                personalNote: personalNote,
                isFavorite: isFavorite,
                revision: revision,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String nameNormalized,
                required String roastery,
                required String roasteryNormalized,
                Value<String?> originCountry = const Value.absent(),
                Value<String?> originCountryNormalized = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> regionNormalized = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> producerNormalized = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> processNormalized = const Value.absent(),
                Value<String?> originCountryCode = const Value.absent(),
                Value<String?> roastLevelKey = const Value.absent(),
                Value<String?> roastLevelCustom = const Value.absent(),
                Value<int?> altitudeMinMeters = const Value.absent(),
                Value<int?> altitudeMaxMeters = const Value.absent(),
                Value<String?> altitudeSourceText = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String?> purchaseDate = const Value.absent(),
                Value<int?> packageWeightGrams = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeesCompanion.insert(
                id: id,
                name: name,
                nameNormalized: nameNormalized,
                roastery: roastery,
                roasteryNormalized: roasteryNormalized,
                originCountry: originCountry,
                originCountryNormalized: originCountryNormalized,
                region: region,
                regionNormalized: regionNormalized,
                producer: producer,
                producerNormalized: producerNormalized,
                process: process,
                processNormalized: processNormalized,
                originCountryCode: originCountryCode,
                roastLevelKey: roastLevelKey,
                roastLevelCustom: roastLevelCustom,
                altitudeMinMeters: altitudeMinMeters,
                altitudeMaxMeters: altitudeMaxMeters,
                altitudeSourceText: altitudeSourceText,
                roastDate: roastDate,
                purchaseDate: purchaseDate,
                packageWeightGrams: packageWeightGrams,
                personalNote: personalNote,
                isFavorite: isFavorite,
                revision: revision,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoffeesTable, CoffeeRecord>(table),
                  $$CoffeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                journalEntriesRefs = false,
                coffeeDraftsRefs = false,
                coffeeVarietiesRefs = false,
                coffeeTastingNotesRefs = false,
                coffeePhotosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (journalEntriesRefs) db.journalEntries,
                    if (coffeeDraftsRefs) db.coffeeDrafts,
                    if (coffeeVarietiesRefs) db.coffeeVarieties,
                    if (coffeeTastingNotesRefs) db.coffeeTastingNotes,
                    if (coffeePhotosRefs) db.coffeePhotos,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          CoffeeRecord,
                          $CoffeesTable,
                          JournalRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeeDraftsRefs)
                        await $_getPrefetchedData<
                          CoffeeRecord,
                          $CoffeesTable,
                          DraftRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._coffeeDraftsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeeDraftsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetCoffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeeVarietiesRefs)
                        await $_getPrefetchedData<
                          CoffeeRecord,
                          $CoffeesTable,
                          CoffeeVarietyRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._coffeeVarietiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeeVarietiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeeTastingNotesRefs)
                        await $_getPrefetchedData<
                          CoffeeRecord,
                          $CoffeesTable,
                          CoffeeTastingNoteRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._coffeeTastingNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeeTastingNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeePhotosRefs)
                        await $_getPrefetchedData<
                          CoffeeRecord,
                          $CoffeesTable,
                          CoffeePhotoRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._coffeePhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeePhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CoffeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeesTable,
      CoffeeRecord,
      $$CoffeesTableFilterComposer,
      $$CoffeesTableOrderingComposer,
      $$CoffeesTableAnnotationComposer,
      $$CoffeesTableCreateCompanionBuilder,
      $$CoffeesTableUpdateCompanionBuilder,
      (CoffeeRecord, $$CoffeesTableReferences),
      CoffeeRecord,
      PrefetchHooks Function({
        bool journalEntriesRefs,
        bool coffeeDraftsRefs,
        bool coffeeVarietiesRefs,
        bool coffeeTastingNotesRefs,
        bool coffeePhotosRefs,
      })
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      required String id,
      required String coffeeId,
      required int brewedAt,
      required int brewedAtOffsetMinutes,
      required String brewMethodKey,
      Value<String?> brewMethodCustom,
      Value<int?> doseMilligrams,
      Value<int?> waterMilligrams,
      Value<int?> waterTemperatureDeciCelsius,
      Value<String?> grindSize,
      Value<int?> brewTimeSeconds,
      Value<int?> rating,
      Value<String?> note,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<String> coffeeId,
      Value<int> brewedAt,
      Value<int> brewedAtOffsetMinutes,
      Value<String> brewMethodKey,
      Value<String?> brewMethodCustom,
      Value<int?> doseMilligrams,
      Value<int?> waterMilligrams,
      Value<int?> waterTemperatureDeciCelsius,
      Value<String?> grindSize,
      Value<int?> brewTimeSeconds,
      Value<int?> rating,
      Value<String?> note,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$JournalEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalRecord> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) =>
      db.coffees.createAlias('journal_entries__coffee_id__coffees__id');

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $JournalTastingNotesTable,
    List<JournalTastingNoteRecord>
  >
  _journalTastingNotesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.journalTastingNotes,
        aliasName:
            'journal_entries__id__journal_tasting_notes__journal_entry_id',
      );

  $$JournalTastingNotesTableProcessedTableManager get journalTastingNotesRefs {
    final manager = $$JournalTastingNotesTableTableManager(
      $_db,
      $_db.journalTastingNotes,
    ).filter((f) => f.journalEntryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _journalTastingNotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brewedAt => $composableBuilder(
    column: $table.brewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brewedAtOffsetMinutes => $composableBuilder(
    column: $table.brewedAtOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brewMethodKey => $composableBuilder(
    column: $table.brewMethodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brewMethodCustom => $composableBuilder(
    column: $table.brewMethodCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get doseMilligrams => $composableBuilder(
    column: $table.doseMilligrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterMilligrams => $composableBuilder(
    column: $table.waterMilligrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterTemperatureDeciCelsius => $composableBuilder(
    column: $table.waterTemperatureDeciCelsius,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grindSize => $composableBuilder(
    column: $table.grindSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brewTimeSeconds => $composableBuilder(
    column: $table.brewTimeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> journalTastingNotesRefs(
    Expression<bool> Function($$JournalTastingNotesTableFilterComposer f) f,
  ) {
    final $$JournalTastingNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalTastingNotes,
      getReferencedColumn: (t) => t.journalEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalTastingNotesTableFilterComposer(
            $db: $db,
            $table: $db.journalTastingNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brewedAt => $composableBuilder(
    column: $table.brewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brewedAtOffsetMinutes => $composableBuilder(
    column: $table.brewedAtOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brewMethodKey => $composableBuilder(
    column: $table.brewMethodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brewMethodCustom => $composableBuilder(
    column: $table.brewMethodCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get doseMilligrams => $composableBuilder(
    column: $table.doseMilligrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterMilligrams => $composableBuilder(
    column: $table.waterMilligrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterTemperatureDeciCelsius => $composableBuilder(
    column: $table.waterTemperatureDeciCelsius,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grindSize => $composableBuilder(
    column: $table.grindSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brewTimeSeconds => $composableBuilder(
    column: $table.brewTimeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get brewedAt =>
      $composableBuilder(column: $table.brewedAt, builder: (column) => column);

  GeneratedColumn<int> get brewedAtOffsetMinutes => $composableBuilder(
    column: $table.brewedAtOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brewMethodKey => $composableBuilder(
    column: $table.brewMethodKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brewMethodCustom => $composableBuilder(
    column: $table.brewMethodCustom,
    builder: (column) => column,
  );

  GeneratedColumn<int> get doseMilligrams => $composableBuilder(
    column: $table.doseMilligrams,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterMilligrams => $composableBuilder(
    column: $table.waterMilligrams,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterTemperatureDeciCelsius => $composableBuilder(
    column: $table.waterTemperatureDeciCelsius,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grindSize =>
      $composableBuilder(column: $table.grindSize, builder: (column) => column);

  GeneratedColumn<int> get brewTimeSeconds => $composableBuilder(
    column: $table.brewTimeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> journalTastingNotesRefs<T extends Object>(
    Expression<T> Function($$JournalTastingNotesTableAnnotationComposer a) f,
  ) {
    final $$JournalTastingNotesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.journalTastingNotes,
          getReferencedColumn: (t) => t.journalEntryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$JournalTastingNotesTableAnnotationComposer(
                $db: $db,
                $table: $db.journalTastingNotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalRecord,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalRecord, $$JournalEntriesTableReferences),
          JournalRecord,
          PrefetchHooks Function({bool coffeeId, bool journalTastingNotesRefs})
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeId = const Value.absent(),
                Value<int> brewedAt = const Value.absent(),
                Value<int> brewedAtOffsetMinutes = const Value.absent(),
                Value<String> brewMethodKey = const Value.absent(),
                Value<String?> brewMethodCustom = const Value.absent(),
                Value<int?> doseMilligrams = const Value.absent(),
                Value<int?> waterMilligrams = const Value.absent(),
                Value<int?> waterTemperatureDeciCelsius = const Value.absent(),
                Value<String?> grindSize = const Value.absent(),
                Value<int?> brewTimeSeconds = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                coffeeId: coffeeId,
                brewedAt: brewedAt,
                brewedAtOffsetMinutes: brewedAtOffsetMinutes,
                brewMethodKey: brewMethodKey,
                brewMethodCustom: brewMethodCustom,
                doseMilligrams: doseMilligrams,
                waterMilligrams: waterMilligrams,
                waterTemperatureDeciCelsius: waterTemperatureDeciCelsius,
                grindSize: grindSize,
                brewTimeSeconds: brewTimeSeconds,
                rating: rating,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeId,
                required int brewedAt,
                required int brewedAtOffsetMinutes,
                required String brewMethodKey,
                Value<String?> brewMethodCustom = const Value.absent(),
                Value<int?> doseMilligrams = const Value.absent(),
                Value<int?> waterMilligrams = const Value.absent(),
                Value<int?> waterTemperatureDeciCelsius = const Value.absent(),
                Value<String?> grindSize = const Value.absent(),
                Value<int?> brewTimeSeconds = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                coffeeId: coffeeId,
                brewedAt: brewedAt,
                brewedAtOffsetMinutes: brewedAtOffsetMinutes,
                brewMethodKey: brewMethodKey,
                brewMethodCustom: brewMethodCustom,
                doseMilligrams: doseMilligrams,
                waterMilligrams: waterMilligrams,
                waterTemperatureDeciCelsius: waterTemperatureDeciCelsius,
                grindSize: grindSize,
                brewTimeSeconds: brewTimeSeconds,
                rating: rating,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JournalEntriesTable, JournalRecord>(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({coffeeId = false, journalTastingNotesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (journalTastingNotesRefs) db.journalTastingNotes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (coffeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.coffeeId,
                            referencedTable: $$JournalEntriesTableReferences
                                ._coffeeIdTable(db),
                            referencedColumn: $$JournalEntriesTableReferences
                                ._coffeeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (journalTastingNotesRefs)
                        await $_getPrefetchedData<
                          JournalRecord,
                          $JournalEntriesTable,
                          JournalTastingNoteRecord
                        >(
                          currentTable: table,
                          referencedTable: $$JournalEntriesTableReferences
                              ._journalTastingNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$JournalEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).journalTastingNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.journalEntryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalRecord,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalRecord, $$JournalEntriesTableReferences),
      JournalRecord,
      PrefetchHooks Function({bool coffeeId, bool journalTastingNotesRefs})
    >;
typedef $$CoffeeDraftsTableCreateCompanionBuilder =
    CoffeeDraftsCompanion Function({
      Value<String?> reviewJson,
      Value<int> reviewRevision,
      Value<String?> ocrRawText,
      Value<String?> ocrLinesJson,
      Value<int> scanRevision,
      required String id,
      required String draftType,
      required String status,
      Value<String?> targetCoffeeId,
      Value<String?> temporaryImagePath,
      Value<String?> imageMimeType,
      Value<String?> name,
      Value<String?> roastery,
      Value<String?> originCountry,
      Value<String?> region,
      Value<String?> producer,
      Value<String?> process,
      Value<String?> originCountryCode,
      Value<String?> roastLevelKey,
      Value<String?> roastLevelCustom,
      Value<int?> altitudeMinMeters,
      Value<int?> altitudeMaxMeters,
      Value<String?> altitudeSourceText,
      Value<String?> roastDate,
      Value<String?> purchaseDate,
      Value<int?> packageWeightGrams,
      Value<String?> personalNote,
      Value<String?> failureCategory,
      required int createdAt,
      required int updatedAt,
      Value<int?> expiresAt,
      Value<int> rowid,
    });
typedef $$CoffeeDraftsTableUpdateCompanionBuilder =
    CoffeeDraftsCompanion Function({
      Value<String?> reviewJson,
      Value<int> reviewRevision,
      Value<String?> ocrRawText,
      Value<String?> ocrLinesJson,
      Value<int> scanRevision,
      Value<String> id,
      Value<String> draftType,
      Value<String> status,
      Value<String?> targetCoffeeId,
      Value<String?> temporaryImagePath,
      Value<String?> imageMimeType,
      Value<String?> name,
      Value<String?> roastery,
      Value<String?> originCountry,
      Value<String?> region,
      Value<String?> producer,
      Value<String?> process,
      Value<String?> originCountryCode,
      Value<String?> roastLevelKey,
      Value<String?> roastLevelCustom,
      Value<int?> altitudeMinMeters,
      Value<int?> altitudeMaxMeters,
      Value<String?> altitudeSourceText,
      Value<String?> roastDate,
      Value<String?> purchaseDate,
      Value<int?> packageWeightGrams,
      Value<String?> personalNote,
      Value<String?> failureCategory,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> expiresAt,
      Value<int> rowid,
    });

final class $$CoffeeDraftsTableReferences
    extends BaseReferences<_$AppDatabase, $CoffeeDraftsTable, DraftRecord> {
  $$CoffeeDraftsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoffeesTable _targetCoffeeIdTable(_$AppDatabase db) =>
      db.coffees.createAlias('coffee_drafts__target_coffee_id__coffees__id');

  $$CoffeesTableProcessedTableManager? get targetCoffeeId {
    final $_column = $_itemColumn<String>('target_coffee_id');
    if ($_column == null) return null;
    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetCoffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ScanExtractedFieldsTable,
    List<ScanExtractedFieldRecord>
  >
  _scanExtractedFieldsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scanExtractedFields,
        aliasName: 'coffee_drafts__id__scan_extracted_fields__coffee_draft_id',
      );

  $$ScanExtractedFieldsTableProcessedTableManager get scanExtractedFieldsRefs {
    final manager = $$ScanExtractedFieldsTableTableManager(
      $_db,
      $_db.scanExtractedFields,
    ).filter((f) => f.coffeeDraftId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scanExtractedFieldsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DraftVarietiesTable, List<DraftVarietyRecord>>
  _draftVarietiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.draftVarieties,
    aliasName: 'coffee_drafts__id__draft_varieties__coffee_draft_id',
  );

  $$DraftVarietiesTableProcessedTableManager get draftVarietiesRefs {
    final manager = $$DraftVarietiesTableTableManager(
      $_db,
      $_db.draftVarieties,
    ).filter((f) => f.coffeeDraftId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_draftVarietiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DraftTastingNotesTable,
    List<DraftTastingNoteRecord>
  >
  _draftTastingNotesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.draftTastingNotes,
        aliasName: 'coffee_drafts__id__draft_tasting_notes__coffee_draft_id',
      );

  $$DraftTastingNotesTableProcessedTableManager get draftTastingNotesRefs {
    final manager = $$DraftTastingNotesTableTableManager(
      $_db,
      $_db.draftTastingNotes,
    ).filter((f) => f.coffeeDraftId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _draftTastingNotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoffeeDraftsTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeeDraftsTable> {
  $$CoffeeDraftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get reviewJson => $composableBuilder(
    column: $table.reviewJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewRevision => $composableBuilder(
    column: $table.reviewRevision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrRawText => $composableBuilder(
    column: $table.ocrRawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrLinesJson => $composableBuilder(
    column: $table.ocrLinesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scanRevision => $composableBuilder(
    column: $table.scanRevision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get draftType => $composableBuilder(
    column: $table.draftType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get temporaryImagePath => $composableBuilder(
    column: $table.temporaryImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageMimeType => $composableBuilder(
    column: $table.imageMimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastery => $composableBuilder(
    column: $table.roastery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get targetCoffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCoffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scanExtractedFieldsRefs(
    Expression<bool> Function($$ScanExtractedFieldsTableFilterComposer f) f,
  ) {
    final $$ScanExtractedFieldsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanExtractedFields,
      getReferencedColumn: (t) => t.coffeeDraftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanExtractedFieldsTableFilterComposer(
            $db: $db,
            $table: $db.scanExtractedFields,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> draftVarietiesRefs(
    Expression<bool> Function($$DraftVarietiesTableFilterComposer f) f,
  ) {
    final $$DraftVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftVarieties,
      getReferencedColumn: (t) => t.coffeeDraftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.draftVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> draftTastingNotesRefs(
    Expression<bool> Function($$DraftTastingNotesTableFilterComposer f) f,
  ) {
    final $$DraftTastingNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftTastingNotes,
      getReferencedColumn: (t) => t.coffeeDraftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftTastingNotesTableFilterComposer(
            $db: $db,
            $table: $db.draftTastingNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoffeeDraftsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeeDraftsTable> {
  $$CoffeeDraftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get reviewJson => $composableBuilder(
    column: $table.reviewJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewRevision => $composableBuilder(
    column: $table.reviewRevision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrRawText => $composableBuilder(
    column: $table.ocrRawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrLinesJson => $composableBuilder(
    column: $table.ocrLinesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scanRevision => $composableBuilder(
    column: $table.scanRevision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get draftType => $composableBuilder(
    column: $table.draftType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temporaryImagePath => $composableBuilder(
    column: $table.temporaryImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageMimeType => $composableBuilder(
    column: $table.imageMimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastery => $composableBuilder(
    column: $table.roastery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get targetCoffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCoffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeDraftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeeDraftsTable> {
  $$CoffeeDraftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get reviewJson => $composableBuilder(
    column: $table.reviewJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewRevision => $composableBuilder(
    column: $table.reviewRevision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrRawText => $composableBuilder(
    column: $table.ocrRawText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrLinesJson => $composableBuilder(
    column: $table.ocrLinesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scanRevision => $composableBuilder(
    column: $table.scanRevision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get draftType =>
      $composableBuilder(column: $table.draftType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get temporaryImagePath => $composableBuilder(
    column: $table.temporaryImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageMimeType => $composableBuilder(
    column: $table.imageMimeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get roastery =>
      $composableBuilder(column: $table.roastery, builder: (column) => column);

  GeneratedColumn<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<String> get process =>
      $composableBuilder(column: $table.process, builder: (column) => column);

  GeneratedColumn<String> get originCountryCode => $composableBuilder(
    column: $table.originCountryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevelKey => $composableBuilder(
    column: $table.roastLevelKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevelCustom => $composableBuilder(
    column: $table.roastLevelCustom,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMinMeters => $composableBuilder(
    column: $table.altitudeMinMeters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMaxMeters => $composableBuilder(
    column: $table.altitudeMaxMeters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get altitudeSourceText => $composableBuilder(
    column: $table.altitudeSourceText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get packageWeightGrams => $composableBuilder(
    column: $table.packageWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureCategory => $composableBuilder(
    column: $table.failureCategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get targetCoffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCoffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> scanExtractedFieldsRefs<T extends Object>(
    Expression<T> Function($$ScanExtractedFieldsTableAnnotationComposer a) f,
  ) {
    final $$ScanExtractedFieldsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scanExtractedFields,
          getReferencedColumn: (t) => t.coffeeDraftId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScanExtractedFieldsTableAnnotationComposer(
                $db: $db,
                $table: $db.scanExtractedFields,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> draftVarietiesRefs<T extends Object>(
    Expression<T> Function($$DraftVarietiesTableAnnotationComposer a) f,
  ) {
    final $$DraftVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.draftVarieties,
      getReferencedColumn: (t) => t.coffeeDraftId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DraftVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.draftVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> draftTastingNotesRefs<T extends Object>(
    Expression<T> Function($$DraftTastingNotesTableAnnotationComposer a) f,
  ) {
    final $$DraftTastingNotesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.draftTastingNotes,
          getReferencedColumn: (t) => t.coffeeDraftId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DraftTastingNotesTableAnnotationComposer(
                $db: $db,
                $table: $db.draftTastingNotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CoffeeDraftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeeDraftsTable,
          DraftRecord,
          $$CoffeeDraftsTableFilterComposer,
          $$CoffeeDraftsTableOrderingComposer,
          $$CoffeeDraftsTableAnnotationComposer,
          $$CoffeeDraftsTableCreateCompanionBuilder,
          $$CoffeeDraftsTableUpdateCompanionBuilder,
          (DraftRecord, $$CoffeeDraftsTableReferences),
          DraftRecord,
          PrefetchHooks Function({
            bool targetCoffeeId,
            bool scanExtractedFieldsRefs,
            bool draftVarietiesRefs,
            bool draftTastingNotesRefs,
          })
        > {
  $$CoffeeDraftsTableTableManager(_$AppDatabase db, $CoffeeDraftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeDraftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeDraftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeDraftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> reviewJson = const Value.absent(),
                Value<int> reviewRevision = const Value.absent(),
                Value<String?> ocrRawText = const Value.absent(),
                Value<String?> ocrLinesJson = const Value.absent(),
                Value<int> scanRevision = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> draftType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> targetCoffeeId = const Value.absent(),
                Value<String?> temporaryImagePath = const Value.absent(),
                Value<String?> imageMimeType = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> roastery = const Value.absent(),
                Value<String?> originCountry = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> originCountryCode = const Value.absent(),
                Value<String?> roastLevelKey = const Value.absent(),
                Value<String?> roastLevelCustom = const Value.absent(),
                Value<int?> altitudeMinMeters = const Value.absent(),
                Value<int?> altitudeMaxMeters = const Value.absent(),
                Value<String?> altitudeSourceText = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String?> purchaseDate = const Value.absent(),
                Value<int?> packageWeightGrams = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<String?> failureCategory = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeDraftsCompanion(
                reviewJson: reviewJson,
                reviewRevision: reviewRevision,
                ocrRawText: ocrRawText,
                ocrLinesJson: ocrLinesJson,
                scanRevision: scanRevision,
                id: id,
                draftType: draftType,
                status: status,
                targetCoffeeId: targetCoffeeId,
                temporaryImagePath: temporaryImagePath,
                imageMimeType: imageMimeType,
                name: name,
                roastery: roastery,
                originCountry: originCountry,
                region: region,
                producer: producer,
                process: process,
                originCountryCode: originCountryCode,
                roastLevelKey: roastLevelKey,
                roastLevelCustom: roastLevelCustom,
                altitudeMinMeters: altitudeMinMeters,
                altitudeMaxMeters: altitudeMaxMeters,
                altitudeSourceText: altitudeSourceText,
                roastDate: roastDate,
                purchaseDate: purchaseDate,
                packageWeightGrams: packageWeightGrams,
                personalNote: personalNote,
                failureCategory: failureCategory,
                createdAt: createdAt,
                updatedAt: updatedAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> reviewJson = const Value.absent(),
                Value<int> reviewRevision = const Value.absent(),
                Value<String?> ocrRawText = const Value.absent(),
                Value<String?> ocrLinesJson = const Value.absent(),
                Value<int> scanRevision = const Value.absent(),
                required String id,
                required String draftType,
                required String status,
                Value<String?> targetCoffeeId = const Value.absent(),
                Value<String?> temporaryImagePath = const Value.absent(),
                Value<String?> imageMimeType = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> roastery = const Value.absent(),
                Value<String?> originCountry = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> originCountryCode = const Value.absent(),
                Value<String?> roastLevelKey = const Value.absent(),
                Value<String?> roastLevelCustom = const Value.absent(),
                Value<int?> altitudeMinMeters = const Value.absent(),
                Value<int?> altitudeMaxMeters = const Value.absent(),
                Value<String?> altitudeSourceText = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String?> purchaseDate = const Value.absent(),
                Value<int?> packageWeightGrams = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<String?> failureCategory = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeDraftsCompanion.insert(
                reviewJson: reviewJson,
                reviewRevision: reviewRevision,
                ocrRawText: ocrRawText,
                ocrLinesJson: ocrLinesJson,
                scanRevision: scanRevision,
                id: id,
                draftType: draftType,
                status: status,
                targetCoffeeId: targetCoffeeId,
                temporaryImagePath: temporaryImagePath,
                imageMimeType: imageMimeType,
                name: name,
                roastery: roastery,
                originCountry: originCountry,
                region: region,
                producer: producer,
                process: process,
                originCountryCode: originCountryCode,
                roastLevelKey: roastLevelKey,
                roastLevelCustom: roastLevelCustom,
                altitudeMinMeters: altitudeMinMeters,
                altitudeMaxMeters: altitudeMaxMeters,
                altitudeSourceText: altitudeSourceText,
                roastDate: roastDate,
                purchaseDate: purchaseDate,
                packageWeightGrams: packageWeightGrams,
                personalNote: personalNote,
                failureCategory: failureCategory,
                createdAt: createdAt,
                updatedAt: updatedAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoffeeDraftsTable, DraftRecord>(table),
                  $$CoffeeDraftsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                targetCoffeeId = false,
                scanExtractedFieldsRefs = false,
                draftVarietiesRefs = false,
                draftTastingNotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scanExtractedFieldsRefs) db.scanExtractedFields,
                    if (draftVarietiesRefs) db.draftVarieties,
                    if (draftTastingNotesRefs) db.draftTastingNotes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (targetCoffeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.targetCoffeeId,
                            referencedTable: $$CoffeeDraftsTableReferences
                                ._targetCoffeeIdTable(db),
                            referencedColumn: $$CoffeeDraftsTableReferences
                                ._targetCoffeeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scanExtractedFieldsRefs)
                        await $_getPrefetchedData<
                          DraftRecord,
                          $CoffeeDraftsTable,
                          ScanExtractedFieldRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeeDraftsTableReferences
                              ._scanExtractedFieldsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeeDraftsTableReferences(
                                db,
                                table,
                                p0,
                              ).scanExtractedFieldsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeDraftId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (draftVarietiesRefs)
                        await $_getPrefetchedData<
                          DraftRecord,
                          $CoffeeDraftsTable,
                          DraftVarietyRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeeDraftsTableReferences
                              ._draftVarietiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeeDraftsTableReferences(
                                db,
                                table,
                                p0,
                              ).draftVarietiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeDraftId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (draftTastingNotesRefs)
                        await $_getPrefetchedData<
                          DraftRecord,
                          $CoffeeDraftsTable,
                          DraftTastingNoteRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeeDraftsTableReferences
                              ._draftTastingNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeeDraftsTableReferences(
                                db,
                                table,
                                p0,
                              ).draftTastingNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeDraftId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CoffeeDraftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeeDraftsTable,
      DraftRecord,
      $$CoffeeDraftsTableFilterComposer,
      $$CoffeeDraftsTableOrderingComposer,
      $$CoffeeDraftsTableAnnotationComposer,
      $$CoffeeDraftsTableCreateCompanionBuilder,
      $$CoffeeDraftsTableUpdateCompanionBuilder,
      (DraftRecord, $$CoffeeDraftsTableReferences),
      DraftRecord,
      PrefetchHooks Function({
        bool targetCoffeeId,
        bool scanExtractedFieldsRefs,
        bool draftVarietiesRefs,
        bool draftTastingNotesRefs,
      })
    >;
typedef $$ScanExtractedFieldsTableCreateCompanionBuilder =
    ScanExtractedFieldsCompanion Function({
      required String id,
      required String coffeeDraftId,
      required String fieldKey,
      Value<String?> rawValue,
      Value<String?> normalizedValue,
      Value<int?> confidenceBasisPoints,
      required String reviewStatus,
      Value<String?> sourceRegion,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$ScanExtractedFieldsTableUpdateCompanionBuilder =
    ScanExtractedFieldsCompanion Function({
      Value<String> id,
      Value<String> coffeeDraftId,
      Value<String> fieldKey,
      Value<String?> rawValue,
      Value<String?> normalizedValue,
      Value<int?> confidenceBasisPoints,
      Value<String> reviewStatus,
      Value<String?> sourceRegion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$ScanExtractedFieldsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ScanExtractedFieldsTable,
          ScanExtractedFieldRecord
        > {
  $$ScanExtractedFieldsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeeDraftsTable _coffeeDraftIdTable(_$AppDatabase db) => db
      .coffeeDrafts
      .createAlias('scan_extracted_fields__coffee_draft_id__coffee_drafts__id');

  $$CoffeeDraftsTableProcessedTableManager get coffeeDraftId {
    final $_column = $_itemColumn<String>('coffee_draft_id')!;

    final manager = $$CoffeeDraftsTableTableManager(
      $_db,
      $_db.coffeeDrafts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeDraftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanExtractedFieldsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanExtractedFieldsTable> {
  $$ScanExtractedFieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidenceBasisPoints => $composableBuilder(
    column: $table.confidenceBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRegion => $composableBuilder(
    column: $table.sourceRegion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeeDraftsTableFilterComposer get coffeeDraftId {
    final $$CoffeeDraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanExtractedFieldsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanExtractedFieldsTable> {
  $$ScanExtractedFieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidenceBasisPoints => $composableBuilder(
    column: $table.confidenceBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRegion => $composableBuilder(
    column: $table.sourceRegion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeeDraftsTableOrderingComposer get coffeeDraftId {
    final $$CoffeeDraftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableOrderingComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanExtractedFieldsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanExtractedFieldsTable> {
  $$ScanExtractedFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldKey =>
      $composableBuilder(column: $table.fieldKey, builder: (column) => column);

  GeneratedColumn<String> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get confidenceBasisPoints => $composableBuilder(
    column: $table.confidenceBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRegion => $composableBuilder(
    column: $table.sourceRegion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CoffeeDraftsTableAnnotationComposer get coffeeDraftId {
    final $$CoffeeDraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanExtractedFieldsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanExtractedFieldsTable,
          ScanExtractedFieldRecord,
          $$ScanExtractedFieldsTableFilterComposer,
          $$ScanExtractedFieldsTableOrderingComposer,
          $$ScanExtractedFieldsTableAnnotationComposer,
          $$ScanExtractedFieldsTableCreateCompanionBuilder,
          $$ScanExtractedFieldsTableUpdateCompanionBuilder,
          (ScanExtractedFieldRecord, $$ScanExtractedFieldsTableReferences),
          ScanExtractedFieldRecord,
          PrefetchHooks Function({bool coffeeDraftId})
        > {
  $$ScanExtractedFieldsTableTableManager(
    _$AppDatabase db,
    $ScanExtractedFieldsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanExtractedFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanExtractedFieldsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScanExtractedFieldsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeDraftId = const Value.absent(),
                Value<String> fieldKey = const Value.absent(),
                Value<String?> rawValue = const Value.absent(),
                Value<String?> normalizedValue = const Value.absent(),
                Value<int?> confidenceBasisPoints = const Value.absent(),
                Value<String> reviewStatus = const Value.absent(),
                Value<String?> sourceRegion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanExtractedFieldsCompanion(
                id: id,
                coffeeDraftId: coffeeDraftId,
                fieldKey: fieldKey,
                rawValue: rawValue,
                normalizedValue: normalizedValue,
                confidenceBasisPoints: confidenceBasisPoints,
                reviewStatus: reviewStatus,
                sourceRegion: sourceRegion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeDraftId,
                required String fieldKey,
                Value<String?> rawValue = const Value.absent(),
                Value<String?> normalizedValue = const Value.absent(),
                Value<int?> confidenceBasisPoints = const Value.absent(),
                required String reviewStatus,
                Value<String?> sourceRegion = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScanExtractedFieldsCompanion.insert(
                id: id,
                coffeeDraftId: coffeeDraftId,
                fieldKey: fieldKey,
                rawValue: rawValue,
                normalizedValue: normalizedValue,
                confidenceBasisPoints: confidenceBasisPoints,
                reviewStatus: reviewStatus,
                sourceRegion: sourceRegion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ScanExtractedFieldsTable,
                    ScanExtractedFieldRecord
                  >(table),
                  $$ScanExtractedFieldsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeDraftId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeDraftId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeDraftId,
                        referencedTable: $$ScanExtractedFieldsTableReferences
                            ._coffeeDraftIdTable(db),
                        referencedColumn: $$ScanExtractedFieldsTableReferences
                            ._coffeeDraftIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanExtractedFieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanExtractedFieldsTable,
      ScanExtractedFieldRecord,
      $$ScanExtractedFieldsTableFilterComposer,
      $$ScanExtractedFieldsTableOrderingComposer,
      $$ScanExtractedFieldsTableAnnotationComposer,
      $$ScanExtractedFieldsTableCreateCompanionBuilder,
      $$ScanExtractedFieldsTableUpdateCompanionBuilder,
      (ScanExtractedFieldRecord, $$ScanExtractedFieldsTableReferences),
      ScanExtractedFieldRecord,
      PrefetchHooks Function({bool coffeeDraftId})
    >;
typedef $$CoffeeVarietiesTableCreateCompanionBuilder =
    CoffeeVarietiesCompanion Function({
      required String id,
      required String coffeeId,
      required String displayValue,
      required String normalizedValue,
      required int position,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CoffeeVarietiesTableUpdateCompanionBuilder =
    CoffeeVarietiesCompanion Function({
      Value<String> id,
      Value<String> coffeeId,
      Value<String> displayValue,
      Value<String> normalizedValue,
      Value<int> position,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CoffeeVarietiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CoffeeVarietiesTable,
          CoffeeVarietyRecord
        > {
  $$CoffeeVarietiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) =>
      db.coffees.createAlias('coffee_varieties__coffee_id__coffees__id');

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoffeeVarietiesTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeeVarietiesTable> {
  $$CoffeeVarietiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeVarietiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeeVarietiesTable> {
  $$CoffeeVarietiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeVarietiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeeVarietiesTable> {
  $$CoffeeVarietiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeVarietiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeeVarietiesTable,
          CoffeeVarietyRecord,
          $$CoffeeVarietiesTableFilterComposer,
          $$CoffeeVarietiesTableOrderingComposer,
          $$CoffeeVarietiesTableAnnotationComposer,
          $$CoffeeVarietiesTableCreateCompanionBuilder,
          $$CoffeeVarietiesTableUpdateCompanionBuilder,
          (CoffeeVarietyRecord, $$CoffeeVarietiesTableReferences),
          CoffeeVarietyRecord,
          PrefetchHooks Function({bool coffeeId})
        > {
  $$CoffeeVarietiesTableTableManager(
    _$AppDatabase db,
    $CoffeeVarietiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeVarietiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeVarietiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeVarietiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeId = const Value.absent(),
                Value<String> displayValue = const Value.absent(),
                Value<String> normalizedValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeVarietiesCompanion(
                id: id,
                coffeeId: coffeeId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeId,
                required String displayValue,
                required String normalizedValue,
                required int position,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeeVarietiesCompanion.insert(
                id: id,
                coffeeId: coffeeId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoffeeVarietiesTable, CoffeeVarietyRecord>(
                    table,
                  ),
                  $$CoffeeVarietiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeId,
                        referencedTable: $$CoffeeVarietiesTableReferences
                            ._coffeeIdTable(db),
                        referencedColumn: $$CoffeeVarietiesTableReferences
                            ._coffeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoffeeVarietiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeeVarietiesTable,
      CoffeeVarietyRecord,
      $$CoffeeVarietiesTableFilterComposer,
      $$CoffeeVarietiesTableOrderingComposer,
      $$CoffeeVarietiesTableAnnotationComposer,
      $$CoffeeVarietiesTableCreateCompanionBuilder,
      $$CoffeeVarietiesTableUpdateCompanionBuilder,
      (CoffeeVarietyRecord, $$CoffeeVarietiesTableReferences),
      CoffeeVarietyRecord,
      PrefetchHooks Function({bool coffeeId})
    >;
typedef $$CoffeeTastingNotesTableCreateCompanionBuilder =
    CoffeeTastingNotesCompanion Function({
      required String id,
      required String coffeeId,
      required String displayValue,
      required String normalizedValue,
      required int position,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CoffeeTastingNotesTableUpdateCompanionBuilder =
    CoffeeTastingNotesCompanion Function({
      Value<String> id,
      Value<String> coffeeId,
      Value<String> displayValue,
      Value<String> normalizedValue,
      Value<int> position,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CoffeeTastingNotesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CoffeeTastingNotesTable,
          CoffeeTastingNoteRecord
        > {
  $$CoffeeTastingNotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) =>
      db.coffees.createAlias('coffee_tasting_notes__coffee_id__coffees__id');

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoffeeTastingNotesTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeeTastingNotesTable> {
  $$CoffeeTastingNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTastingNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeeTastingNotesTable> {
  $$CoffeeTastingNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTastingNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeeTastingNotesTable> {
  $$CoffeeTastingNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTastingNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeeTastingNotesTable,
          CoffeeTastingNoteRecord,
          $$CoffeeTastingNotesTableFilterComposer,
          $$CoffeeTastingNotesTableOrderingComposer,
          $$CoffeeTastingNotesTableAnnotationComposer,
          $$CoffeeTastingNotesTableCreateCompanionBuilder,
          $$CoffeeTastingNotesTableUpdateCompanionBuilder,
          (CoffeeTastingNoteRecord, $$CoffeeTastingNotesTableReferences),
          CoffeeTastingNoteRecord,
          PrefetchHooks Function({bool coffeeId})
        > {
  $$CoffeeTastingNotesTableTableManager(
    _$AppDatabase db,
    $CoffeeTastingNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeTastingNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeTastingNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeTastingNotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeId = const Value.absent(),
                Value<String> displayValue = const Value.absent(),
                Value<String> normalizedValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeTastingNotesCompanion(
                id: id,
                coffeeId: coffeeId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeId,
                required String displayValue,
                required String normalizedValue,
                required int position,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeeTastingNotesCompanion.insert(
                id: id,
                coffeeId: coffeeId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CoffeeTastingNotesTable,
                    CoffeeTastingNoteRecord
                  >(table),
                  $$CoffeeTastingNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeId,
                        referencedTable: $$CoffeeTastingNotesTableReferences
                            ._coffeeIdTable(db),
                        referencedColumn: $$CoffeeTastingNotesTableReferences
                            ._coffeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoffeeTastingNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeeTastingNotesTable,
      CoffeeTastingNoteRecord,
      $$CoffeeTastingNotesTableFilterComposer,
      $$CoffeeTastingNotesTableOrderingComposer,
      $$CoffeeTastingNotesTableAnnotationComposer,
      $$CoffeeTastingNotesTableCreateCompanionBuilder,
      $$CoffeeTastingNotesTableUpdateCompanionBuilder,
      (CoffeeTastingNoteRecord, $$CoffeeTastingNotesTableReferences),
      CoffeeTastingNoteRecord,
      PrefetchHooks Function({bool coffeeId})
    >;
typedef $$CoffeePhotosTableCreateCompanionBuilder =
    CoffeePhotosCompanion Function({
      required String id,
      required String coffeeId,
      required String localPath,
      required String role,
      required String mimeType,
      required int widthPixels,
      required int heightPixels,
      required int byteSize,
      Value<String?> contentHash,
      required String source,
      required int position,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CoffeePhotosTableUpdateCompanionBuilder =
    CoffeePhotosCompanion Function({
      Value<String> id,
      Value<String> coffeeId,
      Value<String> localPath,
      Value<String> role,
      Value<String> mimeType,
      Value<int> widthPixels,
      Value<int> heightPixels,
      Value<int> byteSize,
      Value<String?> contentHash,
      Value<String> source,
      Value<int> position,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$CoffeePhotosTableReferences
    extends
        BaseReferences<_$AppDatabase, $CoffeePhotosTable, CoffeePhotoRecord> {
  $$CoffeePhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) =>
      db.coffees.createAlias('coffee_photos__coffee_id__coffees__id');

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoffeePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeePhotosTable> {
  $$CoffeePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get widthPixels => $composableBuilder(
    column: $table.widthPixels,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightPixels => $composableBuilder(
    column: $table.heightPixels,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteSize => $composableBuilder(
    column: $table.byteSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeePhotosTable> {
  $$CoffeePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get widthPixels => $composableBuilder(
    column: $table.widthPixels,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightPixels => $composableBuilder(
    column: $table.heightPixels,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteSize => $composableBuilder(
    column: $table.byteSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeePhotosTable> {
  $$CoffeePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get widthPixels => $composableBuilder(
    column: $table.widthPixels,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heightPixels => $composableBuilder(
    column: $table.heightPixels,
    builder: (column) => column,
  );

  GeneratedColumn<int> get byteSize =>
      $composableBuilder(column: $table.byteSize, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeePhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeePhotosTable,
          CoffeePhotoRecord,
          $$CoffeePhotosTableFilterComposer,
          $$CoffeePhotosTableOrderingComposer,
          $$CoffeePhotosTableAnnotationComposer,
          $$CoffeePhotosTableCreateCompanionBuilder,
          $$CoffeePhotosTableUpdateCompanionBuilder,
          (CoffeePhotoRecord, $$CoffeePhotosTableReferences),
          CoffeePhotoRecord,
          PrefetchHooks Function({bool coffeeId})
        > {
  $$CoffeePhotosTableTableManager(_$AppDatabase db, $CoffeePhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> widthPixels = const Value.absent(),
                Value<int> heightPixels = const Value.absent(),
                Value<int> byteSize = const Value.absent(),
                Value<String?> contentHash = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeePhotosCompanion(
                id: id,
                coffeeId: coffeeId,
                localPath: localPath,
                role: role,
                mimeType: mimeType,
                widthPixels: widthPixels,
                heightPixels: heightPixels,
                byteSize: byteSize,
                contentHash: contentHash,
                source: source,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeId,
                required String localPath,
                required String role,
                required String mimeType,
                required int widthPixels,
                required int heightPixels,
                required int byteSize,
                Value<String?> contentHash = const Value.absent(),
                required String source,
                required int position,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeePhotosCompanion.insert(
                id: id,
                coffeeId: coffeeId,
                localPath: localPath,
                role: role,
                mimeType: mimeType,
                widthPixels: widthPixels,
                heightPixels: heightPixels,
                byteSize: byteSize,
                contentHash: contentHash,
                source: source,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoffeePhotosTable, CoffeePhotoRecord>(table),
                  $$CoffeePhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeId,
                        referencedTable: $$CoffeePhotosTableReferences
                            ._coffeeIdTable(db),
                        referencedColumn: $$CoffeePhotosTableReferences
                            ._coffeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoffeePhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeePhotosTable,
      CoffeePhotoRecord,
      $$CoffeePhotosTableFilterComposer,
      $$CoffeePhotosTableOrderingComposer,
      $$CoffeePhotosTableAnnotationComposer,
      $$CoffeePhotosTableCreateCompanionBuilder,
      $$CoffeePhotosTableUpdateCompanionBuilder,
      (CoffeePhotoRecord, $$CoffeePhotosTableReferences),
      CoffeePhotoRecord,
      PrefetchHooks Function({bool coffeeId})
    >;
typedef $$JournalTastingNotesTableCreateCompanionBuilder =
    JournalTastingNotesCompanion Function({
      required String id,
      required String journalEntryId,
      required String displayValue,
      required String normalizedValue,
      required int position,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$JournalTastingNotesTableUpdateCompanionBuilder =
    JournalTastingNotesCompanion Function({
      Value<String> id,
      Value<String> journalEntryId,
      Value<String> displayValue,
      Value<String> normalizedValue,
      Value<int> position,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$JournalTastingNotesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $JournalTastingNotesTable,
          JournalTastingNoteRecord
        > {
  $$JournalTastingNotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JournalEntriesTable _journalEntryIdTable(_$AppDatabase db) =>
      db.journalEntries.createAlias(
        'journal_tasting_notes__journal_entry_id__journal_entries__id',
      );

  $$JournalEntriesTableProcessedTableManager get journalEntryId {
    final $_column = $_itemColumn<String>('journal_entry_id')!;

    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journalEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalTastingNotesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalTastingNotesTable> {
  $$JournalTastingNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$JournalEntriesTableFilterComposer get journalEntryId {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalTastingNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalTastingNotesTable> {
  $$JournalTastingNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$JournalEntriesTableOrderingComposer get journalEntryId {
    final $$JournalEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalTastingNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalTastingNotesTable> {
  $$JournalTastingNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$JournalEntriesTableAnnotationComposer get journalEntryId {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.journalEntryId,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalTastingNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalTastingNotesTable,
          JournalTastingNoteRecord,
          $$JournalTastingNotesTableFilterComposer,
          $$JournalTastingNotesTableOrderingComposer,
          $$JournalTastingNotesTableAnnotationComposer,
          $$JournalTastingNotesTableCreateCompanionBuilder,
          $$JournalTastingNotesTableUpdateCompanionBuilder,
          (JournalTastingNoteRecord, $$JournalTastingNotesTableReferences),
          JournalTastingNoteRecord,
          PrefetchHooks Function({bool journalEntryId})
        > {
  $$JournalTastingNotesTableTableManager(
    _$AppDatabase db,
    $JournalTastingNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalTastingNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalTastingNotesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$JournalTastingNotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> journalEntryId = const Value.absent(),
                Value<String> displayValue = const Value.absent(),
                Value<String> normalizedValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalTastingNotesCompanion(
                id: id,
                journalEntryId: journalEntryId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String journalEntryId,
                required String displayValue,
                required String normalizedValue,
                required int position,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => JournalTastingNotesCompanion.insert(
                id: id,
                journalEntryId: journalEntryId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $JournalTastingNotesTable,
                    JournalTastingNoteRecord
                  >(table),
                  $$JournalTastingNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({journalEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (journalEntryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.journalEntryId,
                        referencedTable: $$JournalTastingNotesTableReferences
                            ._journalEntryIdTable(db),
                        referencedColumn: $$JournalTastingNotesTableReferences
                            ._journalEntryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalTastingNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalTastingNotesTable,
      JournalTastingNoteRecord,
      $$JournalTastingNotesTableFilterComposer,
      $$JournalTastingNotesTableOrderingComposer,
      $$JournalTastingNotesTableAnnotationComposer,
      $$JournalTastingNotesTableCreateCompanionBuilder,
      $$JournalTastingNotesTableUpdateCompanionBuilder,
      (JournalTastingNoteRecord, $$JournalTastingNotesTableReferences),
      JournalTastingNoteRecord,
      PrefetchHooks Function({bool journalEntryId})
    >;
typedef $$DraftVarietiesTableCreateCompanionBuilder =
    DraftVarietiesCompanion Function({
      required String id,
      required String coffeeDraftId,
      required String displayValue,
      required String normalizedValue,
      required int position,
      required String source,
      Value<int> rowid,
    });
typedef $$DraftVarietiesTableUpdateCompanionBuilder =
    DraftVarietiesCompanion Function({
      Value<String> id,
      Value<String> coffeeDraftId,
      Value<String> displayValue,
      Value<String> normalizedValue,
      Value<int> position,
      Value<String> source,
      Value<int> rowid,
    });

final class $$DraftVarietiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DraftVarietiesTable,
          DraftVarietyRecord
        > {
  $$DraftVarietiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeeDraftsTable _coffeeDraftIdTable(_$AppDatabase db) => db
      .coffeeDrafts
      .createAlias('draft_varieties__coffee_draft_id__coffee_drafts__id');

  $$CoffeeDraftsTableProcessedTableManager get coffeeDraftId {
    final $_column = $_itemColumn<String>('coffee_draft_id')!;

    final manager = $$CoffeeDraftsTableTableManager(
      $_db,
      $_db.coffeeDrafts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeDraftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DraftVarietiesTableFilterComposer
    extends Composer<_$AppDatabase, $DraftVarietiesTable> {
  $$DraftVarietiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeeDraftsTableFilterComposer get coffeeDraftId {
    final $$CoffeeDraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftVarietiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftVarietiesTable> {
  $$DraftVarietiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeeDraftsTableOrderingComposer get coffeeDraftId {
    final $$CoffeeDraftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableOrderingComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftVarietiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftVarietiesTable> {
  $$DraftVarietiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$CoffeeDraftsTableAnnotationComposer get coffeeDraftId {
    final $$CoffeeDraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftVarietiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftVarietiesTable,
          DraftVarietyRecord,
          $$DraftVarietiesTableFilterComposer,
          $$DraftVarietiesTableOrderingComposer,
          $$DraftVarietiesTableAnnotationComposer,
          $$DraftVarietiesTableCreateCompanionBuilder,
          $$DraftVarietiesTableUpdateCompanionBuilder,
          (DraftVarietyRecord, $$DraftVarietiesTableReferences),
          DraftVarietyRecord,
          PrefetchHooks Function({bool coffeeDraftId})
        > {
  $$DraftVarietiesTableTableManager(
    _$AppDatabase db,
    $DraftVarietiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftVarietiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftVarietiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftVarietiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeDraftId = const Value.absent(),
                Value<String> displayValue = const Value.absent(),
                Value<String> normalizedValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftVarietiesCompanion(
                id: id,
                coffeeDraftId: coffeeDraftId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeDraftId,
                required String displayValue,
                required String normalizedValue,
                required int position,
                required String source,
                Value<int> rowid = const Value.absent(),
              }) => DraftVarietiesCompanion.insert(
                id: id,
                coffeeDraftId: coffeeDraftId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftVarietiesTable, DraftVarietyRecord>(table),
                  $$DraftVarietiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeDraftId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeDraftId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeDraftId,
                        referencedTable: $$DraftVarietiesTableReferences
                            ._coffeeDraftIdTable(db),
                        referencedColumn: $$DraftVarietiesTableReferences
                            ._coffeeDraftIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DraftVarietiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftVarietiesTable,
      DraftVarietyRecord,
      $$DraftVarietiesTableFilterComposer,
      $$DraftVarietiesTableOrderingComposer,
      $$DraftVarietiesTableAnnotationComposer,
      $$DraftVarietiesTableCreateCompanionBuilder,
      $$DraftVarietiesTableUpdateCompanionBuilder,
      (DraftVarietyRecord, $$DraftVarietiesTableReferences),
      DraftVarietyRecord,
      PrefetchHooks Function({bool coffeeDraftId})
    >;
typedef $$DraftTastingNotesTableCreateCompanionBuilder =
    DraftTastingNotesCompanion Function({
      required String id,
      required String coffeeDraftId,
      required String displayValue,
      required String normalizedValue,
      required int position,
      required String source,
      Value<int> rowid,
    });
typedef $$DraftTastingNotesTableUpdateCompanionBuilder =
    DraftTastingNotesCompanion Function({
      Value<String> id,
      Value<String> coffeeDraftId,
      Value<String> displayValue,
      Value<String> normalizedValue,
      Value<int> position,
      Value<String> source,
      Value<int> rowid,
    });

final class $$DraftTastingNotesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DraftTastingNotesTable,
          DraftTastingNoteRecord
        > {
  $$DraftTastingNotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoffeeDraftsTable _coffeeDraftIdTable(_$AppDatabase db) => db
      .coffeeDrafts
      .createAlias('draft_tasting_notes__coffee_draft_id__coffee_drafts__id');

  $$CoffeeDraftsTableProcessedTableManager get coffeeDraftId {
    final $_column = $_itemColumn<String>('coffee_draft_id')!;

    final manager = $$CoffeeDraftsTableTableManager(
      $_db,
      $_db.coffeeDrafts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeDraftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DraftTastingNotesTableFilterComposer
    extends Composer<_$AppDatabase, $DraftTastingNotesTable> {
  $$DraftTastingNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeeDraftsTableFilterComposer get coffeeDraftId {
    final $$CoffeeDraftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftTastingNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftTastingNotesTable> {
  $$DraftTastingNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeeDraftsTableOrderingComposer get coffeeDraftId {
    final $$CoffeeDraftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableOrderingComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftTastingNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftTastingNotesTable> {
  $$DraftTastingNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayValue => $composableBuilder(
    column: $table.displayValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedValue => $composableBuilder(
    column: $table.normalizedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$CoffeeDraftsTableAnnotationComposer get coffeeDraftId {
    final $$CoffeeDraftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeDraftId,
      referencedTable: $db.coffeeDrafts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeDraftsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeDrafts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DraftTastingNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftTastingNotesTable,
          DraftTastingNoteRecord,
          $$DraftTastingNotesTableFilterComposer,
          $$DraftTastingNotesTableOrderingComposer,
          $$DraftTastingNotesTableAnnotationComposer,
          $$DraftTastingNotesTableCreateCompanionBuilder,
          $$DraftTastingNotesTableUpdateCompanionBuilder,
          (DraftTastingNoteRecord, $$DraftTastingNotesTableReferences),
          DraftTastingNoteRecord,
          PrefetchHooks Function({bool coffeeDraftId})
        > {
  $$DraftTastingNotesTableTableManager(
    _$AppDatabase db,
    $DraftTastingNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftTastingNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftTastingNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftTastingNotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeDraftId = const Value.absent(),
                Value<String> displayValue = const Value.absent(),
                Value<String> normalizedValue = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DraftTastingNotesCompanion(
                id: id,
                coffeeDraftId: coffeeDraftId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeDraftId,
                required String displayValue,
                required String normalizedValue,
                required int position,
                required String source,
                Value<int> rowid = const Value.absent(),
              }) => DraftTastingNotesCompanion.insert(
                id: id,
                coffeeDraftId: coffeeDraftId,
                displayValue: displayValue,
                normalizedValue: normalizedValue,
                position: position,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DraftTastingNotesTable, DraftTastingNoteRecord>(
                    table,
                  ),
                  $$DraftTastingNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeDraftId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (coffeeDraftId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.coffeeDraftId,
                        referencedTable: $$DraftTastingNotesTableReferences
                            ._coffeeDraftIdTable(db),
                        referencedColumn: $$DraftTastingNotesTableReferences
                            ._coffeeDraftIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DraftTastingNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftTastingNotesTable,
      DraftTastingNoteRecord,
      $$DraftTastingNotesTableFilterComposer,
      $$DraftTastingNotesTableOrderingComposer,
      $$DraftTastingNotesTableAnnotationComposer,
      $$DraftTastingNotesTableCreateCompanionBuilder,
      $$DraftTastingNotesTableUpdateCompanionBuilder,
      (DraftTastingNoteRecord, $$DraftTastingNotesTableReferences),
      DraftTastingNoteRecord,
      PrefetchHooks Function({bool coffeeDraftId})
    >;
typedef $$FileCleanupTasksTableCreateCompanionBuilder =
    FileCleanupTasksCompanion Function({
      required String id,
      required String localPath,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$FileCleanupTasksTableUpdateCompanionBuilder =
    FileCleanupTasksCompanion Function({
      Value<String> id,
      Value<String> localPath,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$FileCleanupTasksTableFilterComposer
    extends Composer<_$AppDatabase, $FileCleanupTasksTable> {
  $$FileCleanupTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FileCleanupTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $FileCleanupTasksTable> {
  $$FileCleanupTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FileCleanupTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FileCleanupTasksTable> {
  $$FileCleanupTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FileCleanupTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FileCleanupTasksTable,
          FileCleanupRecord,
          $$FileCleanupTasksTableFilterComposer,
          $$FileCleanupTasksTableOrderingComposer,
          $$FileCleanupTasksTableAnnotationComposer,
          $$FileCleanupTasksTableCreateCompanionBuilder,
          $$FileCleanupTasksTableUpdateCompanionBuilder,
          (
            FileCleanupRecord,
            BaseReferences<
              _$AppDatabase,
              $FileCleanupTasksTable,
              FileCleanupRecord
            >,
          ),
          FileCleanupRecord,
          PrefetchHooks Function()
        > {
  $$FileCleanupTasksTableTableManager(
    _$AppDatabase db,
    $FileCleanupTasksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FileCleanupTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FileCleanupTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FileCleanupTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FileCleanupTasksCompanion(
                id: id,
                localPath: localPath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localPath,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FileCleanupTasksCompanion.insert(
                id: id,
                localPath: localPath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FileCleanupTasksTable, FileCleanupRecord>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FileCleanupTasksTable,
                    FileCleanupRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FileCleanupTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FileCleanupTasksTable,
      FileCleanupRecord,
      $$FileCleanupTasksTableFilterComposer,
      $$FileCleanupTasksTableOrderingComposer,
      $$FileCleanupTasksTableAnnotationComposer,
      $$FileCleanupTasksTableCreateCompanionBuilder,
      $$FileCleanupTasksTableUpdateCompanionBuilder,
      (
        FileCleanupRecord,
        BaseReferences<
          _$AppDatabase,
          $FileCleanupTasksTable,
          FileCleanupRecord
        >,
      ),
      FileCleanupRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoffeesTableTableManager get coffees =>
      $$CoffeesTableTableManager(_db, _db.coffees);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$CoffeeDraftsTableTableManager get coffeeDrafts =>
      $$CoffeeDraftsTableTableManager(_db, _db.coffeeDrafts);
  $$ScanExtractedFieldsTableTableManager get scanExtractedFields =>
      $$ScanExtractedFieldsTableTableManager(_db, _db.scanExtractedFields);
  $$CoffeeVarietiesTableTableManager get coffeeVarieties =>
      $$CoffeeVarietiesTableTableManager(_db, _db.coffeeVarieties);
  $$CoffeeTastingNotesTableTableManager get coffeeTastingNotes =>
      $$CoffeeTastingNotesTableTableManager(_db, _db.coffeeTastingNotes);
  $$CoffeePhotosTableTableManager get coffeePhotos =>
      $$CoffeePhotosTableTableManager(_db, _db.coffeePhotos);
  $$JournalTastingNotesTableTableManager get journalTastingNotes =>
      $$JournalTastingNotesTableTableManager(_db, _db.journalTastingNotes);
  $$DraftVarietiesTableTableManager get draftVarieties =>
      $$DraftVarietiesTableTableManager(_db, _db.draftVarieties);
  $$DraftTastingNotesTableTableManager get draftTastingNotes =>
      $$DraftTastingNotesTableTableManager(_db, _db.draftTastingNotes);
  $$FileCleanupTasksTableTableManager get fileCleanupTasks =>
      $$FileCleanupTasksTableTableManager(_db, _db.fileCleanupTasks);
}
