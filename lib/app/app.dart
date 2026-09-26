import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/routing/app_router.dart';
import 'package:daily_coffee/app/routing/navigation_screens.dart';
import 'package:flutter/material.dart';

class DailyCoffeeApp extends StatelessWidget {
  DailyCoffeeApp({required this.preferences, super.key})
    : _router = createAppRouter(preferences);

  final AppPreferences preferences;
  final RouterConfig<Object> _router;

  @override
  Widget build(BuildContext context) {
    return AppPreferencesScope(
      preferences: preferences,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Daily Coffee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}
