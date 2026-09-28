import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Material dates, input actions, and dialogs follow the supported device locale.
/// Product copy remains Bahasa Indonesia for the local MVP.
abstract final class DailyLocalizations {
  static const delegates = GlobalMaterialLocalizations.delegates;
  static const supportedLocales = [Locale('id'), Locale('en')];
}
