import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

QueryExecutor openAppDatabase() => LazyDatabase(() async {
  final directory = await getApplicationSupportDirectory();
  final folder = Directory(path.join(directory.path, 'database'));
  await folder.create(recursive: true);
  return NativeDatabase.createInBackground(
    File(path.join(folder.path, 'daily_coffee.sqlite')),
  );
});
