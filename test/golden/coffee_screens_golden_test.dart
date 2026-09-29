import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/app/composition/database_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/features/coffee/presentation/screens/coffee_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';
import '../helpers/test_doubles.dart';

void main() {
  setUpAll(() async {
    for (final font in ['Inter', 'Lora', 'MaterialIcons']) {
      final path = font == 'MaterialIcons'
          ? 'fonts/MaterialIcons-Regular.otf'
          : 'assets/fonts/$font.ttf';
      await (FontLoader(font)..addFont(rootBundle.load(path))).load();
    }
  });
  for (final screen in ['library', 'detail', 'form']) {
    testWidgets('coffee $screen screen', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(400, 900);
      tester.platformDispatcher.platformBrightnessTestValue = screen == 'form'
          ? Brightness.dark
          : Brightness.light;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      final coffee = sampleCoffee();
      final repository = TestCoffeeRepository(seed: [coffee]);
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await repository.dispose();
      });
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseInitializationProvider.overrideWith((ref) async {}),
            appPreferencesProvider.overrideWithValue(FakeAppPreferences()),
            coffeeRepositoryProvider.overrideWithValue(repository),
          ],
          child: const DailyCoffeeBootstrap(),
        ),
      );
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(CoffeeLibraryScreen));
      if (screen == 'detail') {
        CoffeeDetailRoute(coffeeId: coffee.id.value).go(context);
      }
      if (screen == 'form') const NewCoffeeRoute().go(context);
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('baselines/coffee_$screen.png'),
      );
    });
  }
}
