import 'package:daily_coffee/app/localization/app_localizations.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/design_system/theme/daily_font_licenses.dart';
import 'package:daily_coffee/features/coffee/presentation/widgets/coffee_cards.dart';
import 'package:daily_coffee/features/journal/presentation/widgets/journal_entry_card.dart';
import 'package:flutter/material.dart';

/// Separate development entry point; sample data never enters the real library.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerDailyFontLicenses();
  runApp(const DesignSystemPreview());
}

class DesignSystemPreview extends StatefulWidget {
  const DesignSystemPreview({super.key});
  @override
  State<DesignSystemPreview> createState() => _DesignSystemPreviewState();
}

class _DesignSystemPreviewState extends State<DesignSystemPreview> {
  var _dark = false;
  var _largeText = false;
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: DailyLocalizations.delegates,
    supportedLocales: DailyLocalizations.supportedLocales,
    theme: DailyTheme.light,
    darkTheme: DailyTheme.dark,
    themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(_largeText ? 2 : 1)),
      child: child!,
    ),
    home: Scaffold(
      appBar: const DailyAppBar(title: 'Komponen Daily Coffee'),
      body: DailyPageBody(
        feed: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text('Tema gelap'),
              value: _dark,
              onChanged: (value) => setState(() => _dark = value),
            ),
            SwitchListTile(
              title: const Text('Teks 200%'),
              value: _largeText,
              onChanged: (value) => setState(() => _largeText = value),
            ),
            const DesignSystemSamples(),
          ],
        ),
      ),
    ),
  );
}

class DesignSystemSamples extends StatefulWidget {
  const DesignSystemSamples({super.key});
  @override
  State<DesignSystemSamples> createState() => _DesignSystemSamplesState();
}

class _DesignSystemSamplesState extends State<DesignSystemSamples> {
  int? _rating;
  DailySelectedValue? _method;
  var _selected = false;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Cerita dalam setiap seduhan',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      const SizedBox(height: DailySpacing.lg),
      Wrap(
        spacing: DailySpacing.sm,
        runSpacing: DailySpacing.sm,
        children: [
          DailyPrimaryButton(label: 'Simpan kopi', onPressed: () {}),
          DailySecondaryButton(label: 'Pilih foto', onPressed: () {}),
          const DailyPrimaryButton(label: 'Tidak tersedia', onPressed: null),
          DailyPrimaryButton(
            label: 'Menyimpan kopi',
            loading: true,
            onPressed: () {},
          ),
        ],
      ),
      const SizedBox(height: DailySpacing.lg),
      const DailyTextField(
        label: 'Nama kopi',
        requiredField: true,
        helperText: 'Gunakan nama pada kemasan.',
      ),
      const SizedBox(height: DailySpacing.md),
      const DailyTextField(
        label: 'Roastery',
        errorText: 'Isi nama roastery pada kemasan.',
      ),
      const SizedBox(height: DailySpacing.md),
      const DailyMultilineField(label: 'Catatan'),
      const SizedBox(height: DailySpacing.md),
      const DailySearchField(),
      const SizedBox(height: DailySpacing.md),
      ControlledValuePicker(
        label: 'Metode seduh',
        value: _method,
        options: const [
          DailyValueOption(key: 'v60', label: 'V60'),
          DailyValueOption(key: 'aeropress', label: 'AeroPress'),
        ],
        onChanged: (value) => setState(() => _method = value),
      ),
      const SizedBox(height: DailySpacing.lg),
      Wrap(
        spacing: DailySpacing.sm,
        runSpacing: DailySpacing.sm,
        children: [
          DailyFilterChip(
            label: 'Favorit',
            selected: _selected,
            onSelected: (value) => setState(() => _selected = value),
          ),
          const DailyTagChip(label: 'Natural'),
          const DailyStatusBadge(
            label: 'Perlu dilengkapi',
            status: DailyStatus.warning,
          ),
        ],
      ),
      const SizedBox(height: DailySpacing.lg),
      DailyRatingInput(
        value: _rating,
        onChanged: (value) => setState(() => _rating = value),
      ),
      const SizedBox(height: DailySpacing.lg),
      DailyAdaptiveGrid(
        children: [
          CoffeeLibraryCard(
            name: 'Ethiopia Guji',
            roastery: 'Contoh roastery',
            metadata: const ['Ethiopia', 'Natural'],
            onTap: () {},
          ),
          CoffeeLibraryCard(
            name: 'Kopi dengan nama panjang dari pegunungan',
            roastery: 'Contoh roastery dengan nama panjang',
            metadata: const ['Indonesia', 'Washed'],
            onTap: () {},
          ),
        ],
      ),
      const SizedBox(height: DailySpacing.md),
      CoffeeListCard(
        name: 'Ethiopia Guji',
        roastery: 'Contoh roastery',
        onTap: () {},
      ),
      const SizedBox(height: DailySpacing.md),
      JournalEntryCard(
        coffeeName: 'Ethiopia Guji',
        brewMethod: 'V60',
        brewedAt: DateTime(2026, 9, 28),
        rating: 4,
        notes: 'Manis, aroma floral, dan aftertaste yang lembut.',
        onTap: () {},
      ),
      const SizedBox(height: DailySpacing.lg),
      const InfoSectionCard(
        title: 'Tentang contoh ini',
        child: Text('Data contoh hanya untuk memeriksa komponen.'),
      ),
      DailyEmptyState(
        title: 'Koleksi masih kosong',
        message: 'Mulai simpan cerita kopi Anda.',
        actionLabel: 'Tambahkan kopi pertama',
        onAction: () {},
      ),
      DailyErrorState(
        message: 'Koleksi belum dapat dimuat. Coba kembali.',
        onRetry: () {},
      ),
      const DailyLoadingState(label: 'Membaca label kopi'),
      const SizedBox(height: DailySpacing.lg),
      const DailyAdaptiveGrid(
        children: [DailyLoadingSkeleton(), DailyLoadingSkeleton()],
      ),
      const SizedBox(height: DailySpacing.lg),
      DailySecondaryButton(
        label: 'Contoh dialog',
        onPressed: () async {
          await DailyDialog.confirm(
            context: context,
            title: 'Buang perubahan?',
            message: 'Perubahan yang belum disimpan akan hilang.',
            confirmLabel: 'Buang',
            destructive: true,
          );
        },
      ),
    ],
  );
}
