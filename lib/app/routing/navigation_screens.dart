import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
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
          TextButton(
            onPressed: () => _finish(context),
            child: const Text('Lewati'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(Icons.local_cafe, size: 64),
              const SizedBox(height: 24),
              Text(
                'Kenali setiap kopi yang Anda nikmati',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Simpan koleksi, catat resep seduh, dan periksa hasil pembacaan label sebelum disimpan.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _finish(context),
                  child: const Text('Mulai mencatat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksi'),
        actions: [
          IconButton(
            tooltip: 'Cari kopi',
            onPressed: () => const SearchRoute().push<void>(context),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _RootPlaceholder(
        icon: Icons.local_cafe_outlined,
        title: 'Koleksi kopi masih kosong',
        actionLabel: 'Buka contoh detail',
        onAction: () =>
            const CoffeeDetailRoute(coffeeId: 'contoh-kopi')
                .push<void>(context),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCoffeeSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah kopi'),
      ),
    );
  }
}

Future<void> _showAddCoffeeSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(title: Text('Tambah kopi')),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Ambil foto'),
              onTap: () async {
                Navigator.pop(sheetContext);
                await const CaptureRoute().push<void>(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: const Text('Pilih dari galeri'),
              onTap: () async {
                Navigator.pop(sheetContext);
                await const CaptureRoute().push<void>(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Isi manual'),
              onTap: () async {
                Navigator.pop(sheetContext);
                await const NewCoffeeRoute().push<void>(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cari dan filter')),
    body: const Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Cari kopi',
        ),
      ),
    ),
  );
}

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Jurnal')),
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
    appBar: AppBar(title: const Text('Pengaturan')),
    body: ListView(
      children: [
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle ??
                      'Halaman ini siap untuk implementasi feature berikutnya.',
                  textAlign: TextAlign.center,
                ),
                if (onEdit != null) ...[
                  const SizedBox(height: 16),
                  FilledButton(onPressed: onEdit, child: Text(editLabel!)),
                ],
              ],
            ),
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
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Buang perubahan?'),
            content: const Text('Perubahan yang belum disimpan akan hilang.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tetap mengedit'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Buang'),
              ),
            ],
          ),
        ) ??
        false;
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
        appBar: AppBar(title: Text(widget.title)),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (widget.subtitle case final subtitle?) ...[
              Text(subtitle),
              const SizedBox(height: 16),
            ],
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nama (placeholder)',
              ),
              onChanged: (_) => setState(() => _dirty = true),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => setState(() => _dirty = false),
              child: const Text('Simpan'),
            ),
          ],
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
    appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Route tidak tersedia: $location'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => const LibraryRoute().go(context),
              child: const Text('Kembali ke Koleksi'),
            ),
          ],
        ),
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
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    ),
  );
}
