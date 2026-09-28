import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Call once at the entry point. License text ships with the offline fonts.
void registerDailyFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final font in ['Inter', 'Lora']) {
      yield LicenseEntryWithLineBreaks([
        font,
      ], await rootBundle.loadString('assets/fonts/$font-OFL.txt'));
    }
  });
}
