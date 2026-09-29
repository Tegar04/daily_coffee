import 'dart:async';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/database/database_connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(openAppDatabase());
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

final databaseInitializationProvider = FutureProvider<void>(
  retry: (_, _) => null,
  (ref) async {
    await ref.watch(appDatabaseProvider).initialize();
  },
);
