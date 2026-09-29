# Migration tests

Setiap supported schema version harus memiliki migration fixture dan test.

Versi pertama adalah v1. `app_database_migration_test.dart` memverifikasi fresh
install, snapshot v1 beserta existing data, dan kegagalan membuka versi lebih baru
tanpa reset. `generated/` dihasilkan dari snapshot Drift dan tidak diedit manual.
Lihat `docs/LOCAL_PERSISTENCE_IMPLEMENTATION.md` untuk workflow upgrade.
