import 'package:daily_coffee/app/routing/navigation_screens.dart';
import 'package:daily_coffee/features/coffee/presentation/screens/coffee_detail_screen.dart';
import 'package:daily_coffee/features/coffee/presentation/screens/coffee_form_screen.dart';
import 'package:daily_coffee/features/coffee/presentation/screens/coffee_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final libraryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'library');
final journalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'journal');
final settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

String rootLocationForIndex(int index) => switch (index) {
  1 => const JournalRoute().location,
  2 => const SettingsRoute().location,
  _ => const LibraryRoute().location,
};

abstract class AppRoute {
  const AppRoute();
  String get location;

  void go(BuildContext context) => context.go(location);
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

class OnboardingRoute extends AppRoute {
  const OnboardingRoute();
  @override
  String get location => '/onboarding';
}

class LibraryRoute extends AppRoute {
  const LibraryRoute();
  @override
  String get location => '/library';
}

class SearchRoute extends AppRoute {
  const SearchRoute();
  @override
  String get location => '/library/search';
}

class JournalRoute extends AppRoute {
  const JournalRoute();
  @override
  String get location => '/journal';
}

class SettingsRoute extends AppRoute {
  const SettingsRoute();
  @override
  String get location => '/settings';
}

class DataStorageRoute extends AppRoute {
  const DataStorageRoute();
  @override
  String get location => '/settings/data';
}

class AboutRoute extends AppRoute {
  const AboutRoute();
  @override
  String get location => '/settings/about';
}

class CaptureRoute extends AppRoute {
  const CaptureRoute();
  @override
  String get location => '/coffee/capture';
}

class ScanRoute extends AppRoute {
  const ScanRoute();
  @override
  String get location => '/coffee/scan';
}

class ReviewRoute extends AppRoute {
  const ReviewRoute();
  @override
  String get location => '/coffee/review';
}

class NewCoffeeRoute extends AppRoute {
  const NewCoffeeRoute();
  @override
  String get location => '/coffee/new';
}

class CoffeeDetailRoute extends AppRoute {
  const CoffeeDetailRoute({required this.coffeeId});
  final String coffeeId;
  @override
  String get location => '/coffee/${Uri.encodeComponent(coffeeId)}';
}

class EditCoffeeRoute extends AppRoute {
  const EditCoffeeRoute({required this.coffeeId});
  final String coffeeId;
  @override
  String get location => '/coffee/${Uri.encodeComponent(coffeeId)}/edit';
}

class NewJournalRoute extends AppRoute {
  const NewJournalRoute({this.coffeeId});
  final String? coffeeId;
  @override
  String get location => coffeeId == null
      ? '/journal/new'
      : '/journal/new?coffeeId=${Uri.encodeQueryComponent(coffeeId!)}';
}

class JournalDetailRoute extends AppRoute {
  const JournalDetailRoute({required this.entryId});
  final String entryId;
  @override
  String get location => '/journal/${Uri.encodeComponent(entryId)}';
}

class EditJournalRoute extends AppRoute {
  const EditJournalRoute({required this.entryId});
  final String entryId;
  @override
  String get location => '/journal/${Uri.encodeComponent(entryId)}/edit';
}

final appRoutes = <RouteBase>[
  GoRoute(
    path: '/onboarding',
    builder: (context, state) => const OnboardingScreen(),
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, shell) =>
        AppNavigationShell(navigationShell: shell),
    branches: [
      StatefulShellBranch(
        navigatorKey: libraryNavigatorKey,
        routes: [
          GoRoute(
            path: '/library',
            builder: (context, state) => const CoffeeLibraryScreen(),
            routes: [
              GoRoute(
                path: 'search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: journalNavigatorKey,
        routes: [
          GoRoute(
            path: '/journal',
            builder: (context, state) => const JournalScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: settingsNavigatorKey,
        routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'data',
                builder: (context, state) => const PlaceholderDetailScreen(
                  title: 'Data & penyimpanan',
                  fallbackLocation: '/settings',
                ),
              ),
              GoRoute(
                path: 'about',
                builder: (context, state) => const PlaceholderDetailScreen(
                  title: 'Tentang',
                  fallbackLocation: '/settings',
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/coffee/capture',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => PlaceholderDetailScreen(
      title: 'Ambil foto',
      fallbackLocation: '/library',
      subtitle: 'Pengambilan foto akan tersedia pada tahap berikutnya. Anda tetap dapat mengisi kopi secara manual.',
      editLabel: 'Isi manual',
      onEdit: () => const NewCoffeeRoute().push<void>(context),
    ),
  ),
  GoRoute(
    path: '/coffee/scan',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => PlaceholderDetailScreen(
      title: 'Membaca label',
      fallbackLocation: '/library',
      subtitle: 'Pembacaan label akan tersedia pada tahap berikutnya.',
      editLabel: 'Isi manual',
      onEdit: () => const NewCoffeeRoute().push<void>(context),
    ),
  ),
  GoRoute(
    path: '/coffee/review',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) =>
        const PlaceholderFormScreen(title: 'Periksa informasi'),
  ),
  GoRoute(
    path: '/coffee/new',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const CoffeeFormScreen(),
  ),
  GoRoute(
    path: '/coffee/:coffeeId',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) =>
        CoffeeDetailScreen(coffeeId: state.pathParameters['coffeeId']!),
    routes: [
      GoRoute(
        path: 'edit',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            CoffeeFormScreen(coffeeId: state.pathParameters['coffeeId']!),
      ),
    ],
  ),
  GoRoute(
    path: '/journal/new',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => PlaceholderFormScreen(
      title: 'Tambah catatan',
      subtitle: state.uri.queryParameters['coffeeId'] == null
          ? null
          : 'Coffee ID: ${state.uri.queryParameters['coffeeId']}',
    ),
  ),
  GoRoute(
    path: '/journal/:entryId',
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      final id = state.pathParameters['entryId']!;
      return PlaceholderDetailScreen(
        title: 'Detail catatan',
        subtitle: 'ID: $id',
        fallbackLocation: '/journal',
        editLabel: 'Edit catatan',
        onEdit: () => EditJournalRoute(entryId: id).push<void>(context),
      );
    },
    routes: [
      GoRoute(
        path: 'edit',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            const PlaceholderFormScreen(title: 'Edit catatan'),
      ),
    ],
  ),
];
