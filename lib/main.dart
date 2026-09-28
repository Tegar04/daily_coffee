import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/core/design_system/theme/daily_font_licenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerDailyFontLicenses();
  runApp(const ProviderScope(child: DailyCoffeeBootstrap()));
}
