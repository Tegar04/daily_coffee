import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

String coffeeFieldLabel(CoffeeField field) => switch (field) {
  CoffeeField.name => 'Nama kopi',
  CoffeeField.roastery => 'Roastery',
  CoffeeField.originCountry => 'Negara asal',
  CoffeeField.region => 'Region / farm',
  CoffeeField.producer => 'Produsen',
  CoffeeField.process => 'Proses',
  CoffeeField.roastLevelKey => 'Roast level',
  CoffeeField.roastLevelCustom => 'Roast level lainnya',
  CoffeeField.altitudeMinMeters => 'Ketinggian minimum (m)',
  CoffeeField.altitudeMaxMeters => 'Ketinggian maksimum (m)',
  CoffeeField.roastDate => 'Tanggal roasting',
  CoffeeField.purchaseDate => 'Tanggal pembelian',
  CoffeeField.packageWeightGrams => 'Berat kemasan (g)',
  CoffeeField.personalNote => 'Catatan pribadi',
};

String roastLevelLabel(RoastLevel level) => switch (level) {
  RoastLevel.light => 'Light',
  RoastLevel.mediumLight => 'Medium-light',
  RoastLevel.medium => 'Medium',
  RoastLevel.mediumDark => 'Medium-dark',
  RoastLevel.dark => 'Dark',
  RoastLevel.other => 'Lainnya',
};

String? coffeeIssueMessage(CoffeeValidationIssue? issue) => switch (issue) {
  null => null,
  CoffeeValidationIssue.required => 'Bagian ini wajib diisi.',
  CoffeeValidationIssue.tooLong =>
    'Teks terlalu panjang. Ringkas sebelum menyimpan.',
  CoffeeValidationIssue.positiveInteger =>
    'Gunakan bilangan bulat lebih dari 0 (maksimal ${CoffeeValidation.integerLimit}).',
  CoffeeValidationIssue.invalidDate => 'Pilih tanggal kalender yang valid.',
  CoffeeValidationIssue.invalidChoice =>
    'Pilih salah satu roast level atau isi nilai lain.',
  CoffeeValidationIssue.customRequired => 'Isi nama roast level lainnya.',
  CoffeeValidationIssue.inconsistentCustom =>
    'Pilih Lainnya untuk menggunakan roast level kustom.',
  CoffeeValidationIssue.altitudeRange =>
    'Maksimum harus sama dengan atau lebih tinggi dari minimum.',
  CoffeeValidationIssue.tooManyTags =>
    'Gunakan maksimal ${CoffeeValidation.tagCountLimit} nilai.',
  CoffeeValidationIssue.invalidTag =>
    'Setiap nilai harus berisi 1–${CoffeeValidation.tagLimit} karakter.',
};

String coffeeFailureMessage(AppFailure failure) => switch (failure) {
  ValidationFailure() => 'Periksa bagian yang ditandai sebelum menyimpan.',
  NotFoundFailure() => 'Kopi tidak ditemukan. Data mungkin sudah dihapus.',
  ConflictFailure() => 'Data berubah sejak dibuka. Buka ulang atau periksa kembali sebelum melanjutkan.',
  _ =>
    'Perubahan belum berhasil disimpan. Isian Anda tetap tersedia; coba lagi.',
};
