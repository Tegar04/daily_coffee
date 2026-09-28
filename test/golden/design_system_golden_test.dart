import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/features/coffee/presentation/widgets/coffee_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    for (final font in ['Inter', 'Lora']) {
      final loader = FontLoader(font)
        ..addFont(rootBundle.load('assets/fonts/$font.ttf'));
      await loader.load();
    }
  });

  for (final dark in [false, true]) {
    testWidgets('design system ${dark ? 'dark' : 'light'}', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(400, 1000);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: dark ? DailyTheme.dark : DailyTheme.light,
          home: Scaffold(
            body: DailyPageBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Builder(
                    builder: (context) => Text(
                      'Daily Coffee',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: DailySpacing.md),
                  CoffeeListCard(
                    name: 'Ethiopia Guji',
                    roastery: 'Contoh roastery',
                    metadata: const ['Natural'],
                    onTap: () {},
                  ),
                  const SizedBox(height: DailySpacing.lg),
                  const DailyTextField(
                    label: 'Nama kopi',
                    initialValue: 'Ethiopia Guji',
                    requiredField: true,
                  ),
                  const SizedBox(height: DailySpacing.md),
                  const DailyTextField(
                    label: 'Roastery',
                    errorText: 'Isi nama roastery pada kemasan.',
                  ),
                  const SizedBox(height: DailySpacing.md),
                  Wrap(
                    spacing: DailySpacing.sm,
                    children: [
                      DailyFilterChip(
                        label: 'Favorit',
                        selected: true,
                        onSelected: (_) {},
                      ),
                      const DailyTagChip(label: 'Natural'),
                    ],
                  ),
                  const SizedBox(height: DailySpacing.md),
                  DailyRatingInput(value: 4, onChanged: (_) {}),
                  const SizedBox(height: DailySpacing.md),
                  DailyPrimaryButton(label: 'Simpan kopi', onPressed: () {}),
                  const SizedBox(height: DailySpacing.sm),
                  const DailyPrimaryButton(
                    label: 'Tidak tersedia',
                    onPressed: null,
                  ),
                  const SizedBox(height: DailySpacing.md),
                  const DailyStatusBadge(
                    label: 'Periksa hasil pembacaan label',
                    status: DailyStatus.warning,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile(
          'baselines/design_system_${dark ? 'dark' : 'light'}.png',
        ),
      );
    });
  }
}
