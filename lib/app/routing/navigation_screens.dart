import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationShell extends StatelessWidget {
  const AppNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) async {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
          await AppPreferencesScope.of(context).setLastRootIndex(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_cafe_outlined),
            selectedIcon: Icon(Icons.local_cafe),
            label: 'Koleksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Jurnal',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class AppPreferencesScope extends InheritedWidget {
  const AppPreferencesScope({
    required this.preferences,
    required super.child,
    super.key,
  });

  final AppPreferences preferences;

  static AppPreferences of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppPreferencesScope>();
    assert(scope != null, 'AppPreferencesScope is missing.');
    return scope!.preferences;
  }

  @override
  bool updateShouldNotify(AppPreferencesScope oldWidget) =>
      preferences != oldWidget.preferences;
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(BuildContext context) async {
    await AppPreferencesScope.of(context).completeOnboarding();
    if (context.mounted) const LibraryRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DailyTextButton(onPressed: () => _finish(context), label: 'Lewati'),
        ],
      ),
      body: DailyPageBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: DailySpacing.xl),
            const Icon(Icons.local_cafe_rounded, size: DailySpacing.hero),
            const SizedBox(height: DailySpacing.lg),
            Text(
              'Kenali setiap kopi yang Anda nikmati',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: DailySpacing.compact),
            const Text(
              'Simpan koleksi, catat resep seduh, dan periksa hasil pembacaan label sebelum disimpan.',
            ),
            const SizedBox(height: DailySpacing.xl),
            SizedBox(
              width: double.infinity,
              child: DailyPrimaryButton(
                onPressed: () => _finish(context),
                label: 'Mulai mencatat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DailyAppBar(title: 'Cari dan filter'),
    body: const DailyPageBody(child: DailySearchField(autofocus: true)),
  );
}

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DailyAppBar(title: 'Jurnal'),
    body: _RootPlaceholder(
      icon: Icons.menu_book_outlined,
      title: 'Belum ada catatan seduh',
      actionLabel: 'Buka contoh detail',
      onAction: () =>
          const JournalDetailRoute(entryId: 'contoh-catatan')
              .push<void>(context),
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => const NewJournalRoute().push<void>(context),
      icon: const Icon(Icons.add),
      label: const Text('Tambah catatan'),
    ),
  );
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DailyAppBar(title: 'Pengaturan'),
    body: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.cloud_outlined),
          title: const Text('Koneksi AI'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => const AiConnectionRoute().push<void>(context),
        ),
        ListTile(
          leading: const Icon(Icons.storage_outlined),
          title: const Text('Data & penyimpanan'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => const DataStorageRoute().push<void>(context),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => const AboutRoute().push<void>(context),
        ),
      ],
    ),
  );
}

class PlaceholderDetailScreen extends StatelessWidget {
  const PlaceholderDetailScreen({
    required this.title,
    this.subtitle,
    this.fallbackLocation = '/library',
    this.editLabel,
    this.onEdit,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String fallbackLocation;
  final String? editLabel;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go(fallbackLocation);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Kembali',
            onPressed: () => canPop
                ? Navigator.of(context).pop()
                : context.go(fallbackLocation),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(title),
        ),
        body: DailyPageBody(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subtitle ??
                    'Halaman ini siap untuk implementasi feature berikutnya.',
                textAlign: TextAlign.center,
              ),
              if (onEdit != null) ...[
                const SizedBox(height: DailySpacing.md),
                DailyPrimaryButton(onPressed: onEdit, label: editLabel!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderFormScreen extends StatefulWidget {
  const PlaceholderFormScreen({required this.title, this.subtitle, super.key});
  final String title;
  final String? subtitle;

  @override
  State<PlaceholderFormScreen> createState() => _PlaceholderFormScreenState();
}

class _PlaceholderFormScreenState extends State<PlaceholderFormScreen> {
  var _dirty = false;

  Future<bool> _confirmDiscard() async {
    if (!_dirty) return true;
    return DailyDialog.confirm(
      context: context,
      title: 'Buang perubahan?',
      message: 'Perubahan yang belum disimpan akan hilang.',
      cancelLabel: 'Tetap mengedit',
      confirmLabel: 'Buang',
      destructive: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || !await _confirmDiscard() || !context.mounted) return;
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: DailyAppBar(title: widget.title),
        body: DailyPageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.subtitle case final subtitle?) ...[
                Text(subtitle),
                const SizedBox(height: DailySpacing.md),
              ],
              DailyTextField(
                label: 'Nama (placeholder)',
                onChanged: (_) => setState(() => _dirty = true),
              ),
              const SizedBox(height: DailySpacing.md),
              DailyPrimaryButton(
                onPressed: () => setState(() => _dirty = false),
                label: 'Simpan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({required this.location, super.key});
  final String location;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DailyAppBar(title: 'Halaman tidak ditemukan'),
    body: DailyPageBody(
      child: DailyEmptyState(
        title: 'Halaman tidak tersedia',
        message: 'Kembali ke koleksi untuk melanjutkan.',
        icon: Icons.search_off_rounded,
        actionLabel: 'Kembali ke Koleksi',
        onAction: () => const LibraryRoute().go(context),
      ),
    ),
  );
}

class _RootPlaceholder extends StatelessWidget {
  const _RootPlaceholder({
    required this.icon,
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });
  final IconData icon;
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => DailyPageBody(
    child: DailyEmptyState(
      title: title,
      message: 'Simpan cerita kopi dan pengalaman seduh Anda di sini.',
      icon: icon,
      actionLabel: actionLabel,
      onAction: onAction,
    ),
  );
}
