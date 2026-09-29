import 'dart:io';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' show sqlite3;

import '../helpers/database_fixtures.dart';
import 'generated/schema.dart';

void main() {
  test(
    'fresh install matches the checked-in v1 schema including constraints',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.initialize();
      await db.validateDatabaseSchema();
      await db.close();
      final snapshot = await SchemaVerifier(GeneratedHelper()).schemaAt(1);
      final fromSnapshot = AppDatabase(snapshot.newConnection());
      addTearDown(fromSnapshot.close);
      await fromSnapshot.validateDatabaseSchema();
    },
  );

  test(
    'v1 snapshot opens with production code and preserves existing rows',
    () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(1);
      schema.rawDatabase.execute(
        'INSERT INTO coffees (id, name, name_normalized, roastery, roastery_normalized, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [
          dbId(1),
          'Existing coffee',
          'existing coffee',
          'Roaster',
          'roaster',
          123,
          123,
        ],
      );
      final db = AppDatabase(schema.newConnection());
      addTearDown(db.close);
      await verifier.migrateAndValidate(db, 1);
      expect((await db.select(db.coffees).getSingle()).name, 'Existing coffee');
      expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
    },
  );

  test(
    'unsupported newer schema fails without reset and can be reopened safely',
    () async {
      final dir = await Directory.systemTemp.createTemp(
        'daily_coffee_migration_',
      );
      final file = File('${dir.path}/coffee.sqlite');
      AppDatabase? db;
      try {
        db = AppDatabase(NativeDatabase(file));
        await db.into(db.coffees).insert(coffeeRow(1));
        await db.close();
        final raw = sqlite3.open(file.path);
        raw.execute('PRAGMA user_version = 2');
        raw.close();
        db = AppDatabase(NativeDatabase(file));
        await expectLater(db.initialize(), throwsA(isA<MigrationFailure>()));
        await db.close();
        final check = sqlite3.open(file.path);
        try {
          expect(check.select('PRAGMA user_version').single['user_version'], 2);
          expect(
            check.select('SELECT name FROM coffees').single['name'],
            'Guji',
          );
          // Restore only the test-created version marker to test retry, never app behavior.
          check.execute('PRAGMA user_version = 1');
        } finally {
          check.close();
        }
        db = AppDatabase(NativeDatabase(file));
        await db.initialize();
        expect((await db.select(db.coffees).getSingle()).id, dbId(1));
      } finally {
        await db?.close();
        await dir.delete(recursive: true);
      }
    },
  );
}
