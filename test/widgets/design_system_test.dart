import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:daily_coffee/app/preview/design_system_preview.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/features/coffee/presentation/widgets/coffee_cards.dart';
import 'package:daily_coffee/features/journal/presentation/widgets/journal_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget host(
  Widget child, {
  bool dark = false,
  double scale = 1,
  bool reduceMotion = true,
}) => MaterialApp(
  theme: dark ? DailyTheme.dark : DailyTheme.light,
  home: MediaQuery(
    data: MediaQueryData(
      textScaler: TextScaler.linear(scale),
      disableAnimations: reduceMotion,
    ),
    child: Scaffold(body: DailyPageBody(child: child)),
  ),
);

void main() {
  testWidgets(
    'picker custom action remains reachable with keyboard and large text',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 720);
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      DailySelectedValue? selected;
      await tester.pumpWidget(
        MaterialApp(
          theme: DailyTheme.dark,
          home: Scaffold(
            body: DailyPageBody(
              child: ControlledValuePicker(
                label: 'Metode seduh',
                options: const [],
                value: null,
                onChanged: (value) => selected = value,
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(DailySelectField));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Tambahkan nilai lain'));
      await tester.tap(find.text('Tambahkan nilai lain'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nilai lain (wajib)'),
        'Origami',
      );
      await tester.ensureVisible(find.text('Gunakan nilai'));
      await tester.tap(find.text('Gunakan nilai'));
      await tester.pumpAndSettle();
      expect(selected?.customValue, 'Origami');
      expect(tester.takeException(), isNull);
    },
  );

  for (final dark in [false, true]) {
    testWidgets(
      'button prevents duplicate submits and preserves size; dark=$dark',
      (tester) async {
        var taps = 0;
        var loading = false;
        var enabled = true;
        late StateSetter update;
        await tester.pumpWidget(
          host(
            StatefulBuilder(
              builder: (context, setState) {
                update = setState;
                return Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DailyPrimaryButton(
                    label: 'Simpan kopi',
                    onPressed: enabled ? () => taps++ : null,
                    loading: loading,
                  ),
                );
              },
            ),
            dark: dark,
          ),
        );
        final original = tester.getSize(find.byType(FilledButton));
        await tester.tap(find.text('Simpan kopi'));
        expect(taps, 1);
        update(() => loading = true);
        await tester.pump();
        expect(tester.getSize(find.byType(FilledButton)), original);
        await tester.tap(find.byType(FilledButton));
        expect(taps, 1);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        update(() {
          loading = false;
          enabled = false;
        });
        await tester.pump();
        await tester.tap(find.byType(FilledButton));
        expect(taps, 1);
      },
    );

    for (final width in [320.0, 600.0, 1000.0]) {
      for (final scale in [1.0, 2.0]) {
        testWidgets('all samples fit width=$width scale=$scale dark=$dark', (
          tester,
        ) async {
          tester.view.reset();
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = Size(width, 900);
          addTearDown(tester.view.reset);
          await tester.pumpWidget(
            host(const DesignSystemSamples(), dark: dark, scale: scale),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
          await tester.drag(
            find.byType(SingleChildScrollView).first,
            const Offset(0, -1800),
          );
          await tester.pump();
          expect(tester.takeException(), isNull);
        });
      }
    }
  }

  testWidgets('rating starts empty, selects integer and clears', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    int? rating;
    await tester.pumpWidget(
      host(
        StatefulBuilder(
          builder: (context, update) => DailyRatingInput(
            value: rating,
            onChanged: (value) => update(() => rating = value),
          ),
        ),
      ),
    );
    expect(find.text('Belum dinilai'), findsOneWidget);
    await tester.tap(find.byTooltip('4 dari 5'));
    await tester.pump();
    expect(rating, 4);
    expect(find.text('Nilai pribadi 4 dari 5'), findsOneWidget);
    expect(
      tester.getSize(find.byTooltip('4 dari 5')).width,
      greaterThanOrEqualTo(48),
    );
    await tester.tap(find.text('Hapus penilaian'));
    await tester.pump();
    expect(rating, isNull);
    semantics.dispose();
  });

  testWidgets(
    'picker filters, validates, preserves custom edit and distinguishes cancel from clear',
    (tester) async {
      DailySelectedValue? selection;
      var changes = 0;
      await tester.pumpWidget(
        host(
          StatefulBuilder(
            builder: (context, update) => ControlledValuePicker(
              label: 'Metode seduh',
              value: selection,
              options: const [
                DailyValueOption(key: 'v60', label: 'V60'),
                DailyValueOption(key: 'aeropress', label: 'AeroPress'),
              ],
              onChanged: (value) => update(() {
                selection = value;
                changes++;
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(DailySelectField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Aero');
      await tester.pump();
      expect(find.text('V60'), findsNothing);
      await tester.tap(find.text('AeroPress'));
      await tester.pumpAndSettle();
      expect(selection?.key, 'aeropress');
      expect(selection?.customValue, isNull);
      await tester.tap(find.byType(DailySelectField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tambahkan nilai lain'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Gunakan nilai'));
      await tester.tap(find.text('Gunakan nilai'));
      await tester.pumpAndSettle();
      expect(find.text('Isi nilai yang ingin digunakan.'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nilai lain (wajib)'),
        '  Origami  ',
      );
      await tester.ensureVisible(find.text('Gunakan nilai'));
      await tester.tap(find.text('Gunakan nilai'));
      await tester.pumpAndSettle();
      expect(selection?.key, 'other');
      expect(selection?.customValue, 'Origami');
      await tester.tap(find.byType(DailySelectField));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(TextFormField, 'Origami'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nilai lain (wajib)'),
        'Changed',
      );
      Navigator.of(tester.element(find.text('Gunakan nilai'))).pop();
      await tester.pumpAndSettle();
      expect(selection?.customValue, 'Origami');
      expect(changes, 2);
      await tester.tap(find.byType(DailySelectField));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Kosongkan pilihan'));
      await tester.tap(find.text('Kosongkan pilihan'));
      await tester.pumpAndSettle();
      expect(selection, isNull);
      expect(changes, 3);
    },
  );

  testWidgets('form validates on submit and search clear informs owner', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    var query = '';
    await tester.pumpWidget(
      host(
        Column(
          children: [
            Form(
              key: formKey,
              child: DailyTextField(
                label: 'Nama kopi',
                requiredField: true,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Isi nama kopi.' : null,
              ),
            ),
            DailySearchField(onChanged: (value) => query = value),
          ],
        ),
      ),
    );
    expect(find.text('Isi nama kopi.'), findsNothing);
    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Isi nama kopi.'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'Guji');
    await tester.pump();
    expect(query, 'Guji');
    await tester.tap(find.byTooltip('Hapus pencarian'));
    await tester.pump();
    expect(query, isEmpty);
  });

  testWidgets('cards announce context and retain image fallback', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpWidget(
      host(
        Column(
          children: [
            CoffeeListCard(
              name: 'Guji',
              roastery: 'Roaster',
              image: MemoryImage(Uint8List.fromList([0, 1, 2])),
              onTap: () => taps++,
            ),
            JournalEntryCard(
              coffeeName: 'Guji',
              brewMethod: 'V60',
              brewedAt: DateTime(2026, 9, 28),
              rating: 4,
              onTap: () => taps++,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.coffee_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(
      find.bySemanticsLabel(RegExp('Guji, V60, .*Nilai pribadi 4 dari 5')),
      findsOneWidget,
    );
    expect(
      tester
          .getSemantics(find.bySemanticsLabel('Guji, Roaster'))
          .getSemanticsData()
          .hasAction(ui.SemanticsAction.tap),
      isTrue,
    );
    await tester.tap(find.text('Roaster'));
    await tester.tap(find.text('V60'));
    expect(taps, 2);
    semantics.dispose();
  });

  testWidgets('adaptive cards collapse for large text; forms cap width', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(400, 900);
    addTearDown(tester.view.reset);
    const a = SizedBox(key: ValueKey('a'), height: 100);
    const b = SizedBox(key: ValueKey('b'), height: 100);
    await tester.pumpWidget(host(const DailyAdaptiveGrid(children: [a, b])));
    expect(
      tester.getTopLeft(find.byKey(a.key!)).dy,
      tester.getTopLeft(find.byKey(b.key!)).dy,
    );
    await tester.pumpWidget(
      host(const DailyAdaptiveGrid(children: [a, b]), scale: 2),
    );
    expect(
      tester.getTopLeft(find.byKey(b.key!)).dy,
      greaterThan(tester.getTopLeft(find.byKey(a.key!)).dy),
    );
    tester.view.physicalSize = const Size(1200, 900);
    await tester.pumpWidget(host(const DailyTextField(label: 'Nama')));
    expect(
      tester.getSize(find.byType(DailyTextField)).width,
      lessThanOrEqualTo(DailyLayout.formMaxWidth),
    );
  });

  test('primary and text roles meet contrast in both themes', () {
    double contrast(Color a, Color b) {
      final x = a.computeLuminance();
      final y = b.computeLuminance();
      return x > y ? (x + 0.05) / (y + 0.05) : (y + 0.05) / (x + 0.05);
    }

    for (final theme in [DailyTheme.light, DailyTheme.dark]) {
      final c = theme.extension<DailyThemeExtension>()!;
      for (final background in [c.background, c.surface, c.surfaceSubtle]) {
        expect(contrast(c.textPrimary, background), greaterThanOrEqualTo(4.5));
        expect(
          contrast(c.textSecondary, background),
          greaterThanOrEqualTo(4.5),
        );
      }
      expect(contrast(c.onPrimary, c.primary), greaterThanOrEqualTo(4.5));
      expect(contrast(c.onStatus, c.error), greaterThanOrEqualTo(4.5));
    }
  });
}
