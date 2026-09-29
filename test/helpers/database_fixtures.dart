import 'dart:math';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:drift/drift.dart';

import 'test_doubles.dart';

String dbId(int i) =>
    '00000000-0000-4000-8000-${i.toString().padLeft(12, '0')}';
final dbTime = DateTime.utc(2026, 9, 28, 7, 15, 30, 123, 456);

DriftCoffeeRepository localRepository(AppDatabase db, {AppIdGenerator? ids}) =>
    DriftCoffeeRepository(
      database: db,
      clock: FixedAppClock(dbTime),
      ids: ids ?? RandomAppIdGenerator(random: Random(42)),
    );

CoffeesCompanion coffeeRow(int id) => CoffeesCompanion.insert(
  id: dbId(id),
  name: 'Guji',
  nameNormalized: 'guji',
  roastery: 'Roaster',
  roasteryNormalized: 'roaster',
  createdAt: dbTime.microsecondsSinceEpoch,
  updatedAt: dbTime.microsecondsSinceEpoch,
);

JournalEntriesCompanion journalRow(int id, String coffeeId) =>
    JournalEntriesCompanion.insert(
      id: dbId(id),
      coffeeId: coffeeId,
      brewedAt: dbTime.microsecondsSinceEpoch,
      brewedAtOffsetMinutes: 420,
      brewMethodKey: 'v60',
      doseMilligrams: const Value(15000),
      waterMilligrams: const Value(240000),
      rating: const Value(4),
      createdAt: dbTime.microsecondsSinceEpoch,
      updatedAt: dbTime.microsecondsSinceEpoch,
    );

CoffeePhotosCompanion photoRow(int id, String coffeeId) =>
    CoffeePhotosCompanion.insert(
      id: dbId(id),
      coffeeId: coffeeId,
      localPath: 'coffee/$id.jpg',
      role: 'cover',
      mimeType: 'image/jpeg',
      widthPixels: 200,
      heightPixels: 300,
      byteSize: 1024,
      source: 'gallery',
      position: 0,
      createdAt: dbTime.microsecondsSinceEpoch,
    );

CoffeeDraftsCompanion draftRow(int id) => CoffeeDraftsCompanion.insert(
  id: dbId(id),
  draftType: 'scan_create',
  status: 'review_required',
  createdAt: dbTime.microsecondsSinceEpoch,
  updatedAt: dbTime.microsecondsSinceEpoch,
);
