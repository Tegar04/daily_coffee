import 'package:drift/drift.dart';

@DataClassName('CoffeeRecord')
class Coffees extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameNormalized => text()();
  TextColumn get roastery => text()();
  TextColumn get roasteryNormalized => text()();
  TextColumn get originCountry => text().nullable()();
  TextColumn get originCountryNormalized => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get regionNormalized => text().nullable()();
  TextColumn get producer => text().nullable()();
  TextColumn get producerNormalized => text().nullable()();
  TextColumn get process => text().nullable()();
  TextColumn get processNormalized => text().nullable()();
  TextColumn get originCountryCode => text().nullable()();
  TextColumn get roastLevelKey => text().nullable()();
  TextColumn get roastLevelCustom => text().nullable()();
  IntColumn get altitudeMinMeters => integer().nullable()();
  IntColumn get altitudeMaxMeters => integer().nullable()();
  TextColumn get altitudeSourceText => text().nullable()();
  TextColumn get roastDate => text().nullable()();
  TextColumn get purchaseDate => text().nullable()();
  IntColumn get packageWeightGrams => integer().nullable()();
  TextColumn get personalNote => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get revision => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(name)) > 0)',
    'CHECK (length(trim(roastery)) > 0)',
    'CHECK (length(trim(name_normalized)) > 0)',
    'CHECK (length(trim(roastery_normalized)) > 0)',
    "CHECK (roast_level_key IS NULL OR roast_level_key IN ('light','medium_light','medium','medium_dark','dark','other'))",
    "CHECK ((roast_level_key = 'other' AND roast_level_custom IS NOT NULL AND length(trim(roast_level_custom)) > 0) OR ((roast_level_key IS NULL OR roast_level_key != 'other') AND roast_level_custom IS NULL))",
    'CHECK (altitude_min_meters IS NULL OR altitude_min_meters > 0)',
    'CHECK (altitude_max_meters IS NULL OR altitude_max_meters > 0)',
    'CHECK (altitude_min_meters IS NULL OR altitude_max_meters IS NULL OR altitude_max_meters >= altitude_min_meters)',
    'CHECK (package_weight_grams IS NULL OR package_weight_grams > 0)',
    'CHECK (updated_at >= created_at)',
    'CHECK (revision >= 0)',
    "CHECK (roast_date IS NULL OR (length(roast_date) = 10 AND roast_date >= '0001-01-01' AND COALESCE(date(roast_date, '+0 days') = roast_date, 0)))",
    "CHECK (purchase_date IS NULL OR (length(purchase_date) = 10 AND purchase_date >= '0001-01-01' AND COALESCE(date(purchase_date, '+0 days') = purchase_date, 0)))",
    "CHECK (origin_country_code IS NULL OR origin_country_code GLOB '[A-Z][A-Z]')",
  ];
}

@DataClassName('CoffeeVarietyRecord')
class CoffeeVarieties extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayValue => text()();
  TextColumn get normalizedValue => text()();
  IntColumn get position => integer()();
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(display_value)) > 0)',
    'CHECK (length(trim(normalized_value)) > 0)',
    'CHECK (position >= 0)',
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {coffeeId, normalizedValue},
    {coffeeId, position},
  ];
}

@DataClassName('CoffeeTastingNoteRecord')
class CoffeeTastingNotes extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayValue => text()();
  TextColumn get normalizedValue => text()();
  IntColumn get position => integer()();
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(display_value)) > 0)',
    'CHECK (length(trim(normalized_value)) > 0)',
    'CHECK (position >= 0)',
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {coffeeId, normalizedValue},
    {coffeeId, position},
  ];
}

@DataClassName('CoffeePhotoRecord')
class CoffeePhotos extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get localPath => text()();
  TextColumn get role => text()();
  TextColumn get mimeType => text()();
  IntColumn get widthPixels => integer()();
  IntColumn get heightPixels => integer()();
  IntColumn get byteSize => integer()();
  TextColumn get contentHash => text().nullable()();
  TextColumn get source => text()();
  IntColumn get position => integer()();
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    "CHECK (length(local_path) > 0 AND local_path NOT LIKE '/%' AND instr(local_path, ':') = 0 AND instr(local_path, char(92)) = 0 AND instr('/' || local_path || '/', '/../') = 0 AND instr('/' || local_path || '/', '/./') = 0 AND instr(local_path, '//') = 0 AND local_path NOT LIKE '%/')",
    "CHECK (role = 'cover')",
    "CHECK (mime_type IN ('image/jpeg','image/png','image/webp'))",
    'CHECK (width_pixels > 0)',
    'CHECK (height_pixels > 0)',
    'CHECK (byte_size >= 0)',
    'CHECK (position >= 0)',
    "CHECK (source IN ('camera','gallery','scan','import'))",
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {coffeeId, role},
  ];
}

@DataClassName('JournalRecord')
class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeId =>
      text().references(Coffees, #id, onDelete: KeyAction.cascade)();
  IntColumn get brewedAt => integer()();
  IntColumn get brewedAtOffsetMinutes => integer()();
  TextColumn get brewMethodKey => text()();
  TextColumn get brewMethodCustom => text().nullable()();
  IntColumn get doseMilligrams => integer().nullable()();
  IntColumn get waterMilligrams => integer().nullable()();
  IntColumn get waterTemperatureDeciCelsius => integer().nullable()();
  TextColumn get grindSize => text().nullable()();
  IntColumn get brewTimeSeconds => integer().nullable()();
  IntColumn get rating => integer().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    "CHECK (brew_method_key IN ('v60','kalita_wave','origami','aeropress','french_press','chemex','clever_dripper','espresso','moka_pot','cold_brew','cupping','other'))",
    "CHECK ((brew_method_key = 'other' AND brew_method_custom IS NOT NULL AND length(trim(brew_method_custom)) > 0) OR (brew_method_key != 'other' AND brew_method_custom IS NULL))",
    'CHECK (dose_milligrams IS NULL OR dose_milligrams > 0)',
    'CHECK (water_milligrams IS NULL OR water_milligrams > 0)',
    'CHECK (water_temperature_deci_celsius IS NULL OR water_temperature_deci_celsius > 0)',
    'CHECK (brew_time_seconds IS NULL OR brew_time_seconds > 0)',
    'CHECK (rating IS NULL OR rating BETWEEN 1 AND 5)',
    'CHECK (updated_at >= created_at)',
    'CHECK (brewed_at_offset_minutes BETWEEN -840 AND 840)',
  ];
}

@DataClassName('JournalTastingNoteRecord')
class JournalTastingNotes extends Table {
  TextColumn get id => text()();
  TextColumn get journalEntryId =>
      text().references(JournalEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayValue => text()();
  TextColumn get normalizedValue => text()();
  IntColumn get position => integer()();
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(display_value)) > 0)',
    'CHECK (length(trim(normalized_value)) > 0)',
    'CHECK (position >= 0)',
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {journalEntryId, normalizedValue},
    {journalEntryId, position},
  ];
}

@DataClassName('DraftRecord')
class CoffeeDrafts extends Table {
  TextColumn get reviewJson => text().nullable()();
  IntColumn get reviewRevision => integer().withDefault(const Constant(0))();
  TextColumn get ocrRawText => text().nullable()();
  TextColumn get ocrLinesJson => text().nullable()();
  IntColumn get scanRevision => integer().withDefault(const Constant(0))();
  TextColumn get id => text()();
  TextColumn get draftType => text()();
  TextColumn get status => text()();
  TextColumn get targetCoffeeId =>
      text().nullable().references(Coffees, #id, onDelete: KeyAction.cascade)();
  TextColumn get temporaryImagePath => text().nullable()();
  TextColumn get imageMimeType => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get roastery => text().nullable()();
  TextColumn get originCountry => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get producer => text().nullable()();
  TextColumn get process => text().nullable()();
  TextColumn get originCountryCode => text().nullable()();
  TextColumn get roastLevelKey => text().nullable()();
  TextColumn get roastLevelCustom => text().nullable()();
  IntColumn get altitudeMinMeters => integer().nullable()();
  IntColumn get altitudeMaxMeters => integer().nullable()();
  TextColumn get altitudeSourceText => text().nullable()();
  TextColumn get roastDate => text().nullable()();
  TextColumn get purchaseDate => text().nullable()();
  IntColumn get packageWeightGrams => integer().nullable()();
  TextColumn get personalNote => text().nullable()();
  TextColumn get failureCategory => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get expiresAt => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    "CHECK (draft_type IN ('manual_create','scan_create','edit_existing'))",
    "CHECK (status IN ('editing','image_ready','processing','review_required','ready_to_save','failed_recoverable','completed','discarded','expired'))",
    "CHECK ((draft_type = 'edit_existing' AND target_coffee_id IS NOT NULL) OR (draft_type != 'edit_existing' AND target_coffee_id IS NULL))",
    "CHECK (temporary_image_path IS NULL OR (image_mime_type IS NOT NULL AND image_mime_type IN ('image/jpeg','image/png','image/webp')))",
    "CHECK (temporary_image_path IS NULL OR (length(temporary_image_path) > 0 AND temporary_image_path NOT LIKE '/%' AND instr(temporary_image_path, ':') = 0 AND instr(temporary_image_path, char(92)) = 0 AND instr('/' || temporary_image_path || '/', '/../') = 0 AND instr('/' || temporary_image_path || '/', '/./') = 0 AND instr(temporary_image_path, '//') = 0 AND temporary_image_path NOT LIKE '%/'))",
    'CHECK (updated_at >= created_at)',
  ];
}

@DataClassName('DraftVarietyRecord')
class DraftVarieties extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeDraftId =>
      text().references(CoffeeDrafts, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayValue => text()();
  TextColumn get normalizedValue => text()();
  IntColumn get position => integer()();
  TextColumn get source => text()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(display_value)) > 0)',
    'CHECK (length(trim(normalized_value)) > 0)',
    'CHECK (position >= 0)',
    "CHECK (source IN ('user','ocr','suggestion_selected'))",
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {coffeeDraftId, normalizedValue},
    {coffeeDraftId, position},
  ];
}

@DataClassName('DraftTastingNoteRecord')
class DraftTastingNotes extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeDraftId =>
      text().references(CoffeeDrafts, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayValue => text()();
  TextColumn get normalizedValue => text()();
  IntColumn get position => integer()();
  TextColumn get source => text()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    'CHECK (length(trim(display_value)) > 0)',
    'CHECK (length(trim(normalized_value)) > 0)',
    'CHECK (position >= 0)',
    "CHECK (source IN ('user','ocr','suggestion_selected'))",
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {coffeeDraftId, normalizedValue},
    {coffeeDraftId, position},
  ];
}

@DataClassName('ScanExtractedFieldRecord')
class ScanExtractedFields extends Table {
  TextColumn get id => text()();
  TextColumn get coffeeDraftId =>
      text().references(CoffeeDrafts, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldKey => text()();
  TextColumn get rawValue => text().nullable()();
  TextColumn get normalizedValue => text().nullable()();
  IntColumn get confidenceBasisPoints => integer().nullable()();
  TextColumn get reviewStatus => text()();
  TextColumn get sourceRegion => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    "CHECK (field_key IN ('name','roastery','origin_country','region','producer','process','varieties','roast_level','tasting_notes','altitude','roast_date','package_weight'))",
    'CHECK (confidence_basis_points IS NULL OR confidence_basis_points BETWEEN 0 AND 10000)',
    "CHECK (review_status IN ('unreviewed','needs_review','accepted','edited','rejected','not_applicable'))",
    'CHECK (updated_at >= created_at)',
  ];
}

@DataClassName('FileCleanupRecord')
class FileCleanupTasks extends Table {
  TextColumn get id => text()();
  TextColumn get localPath => text()();
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
    "CHECK (id GLOB '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f]-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]')",
    "CHECK (length(local_path) > 0 AND local_path NOT LIKE '/%' AND instr(local_path, ':') = 0 AND instr(local_path, char(92)) = 0 AND instr('/' || local_path || '/', '/../') = 0 AND instr('/' || local_path || '/', '/./') = 0 AND instr(local_path, '//') = 0 AND local_path NOT LIKE '%/')",
  ];
  @override
  List<Set<Column>> get uniqueKeys => [
    {localPath},
  ];
}
