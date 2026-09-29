# Database tests

`app_database_test.dart` memverifikasi schema, foreign key, constraint Coffee,
tag/foto/journal, serta persistence dan rollback draft dengan SQLite in-memory.
Repository transaction/reopen tests berada di `test/repositories/` dan snapshot
schema tests berada di `test/migrations/`.
