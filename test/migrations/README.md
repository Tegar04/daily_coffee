# Migration tests

Setiap supported schema version harus memiliki migration fixture dan test.

Versi pertama adalah v1. `app_database_migration_test.dart` memverifikasi fresh
install, snapshot v1 beserta existing data, dan kegagalan membuka versi lebih baru
tanpa reset. `generated/` dihasilkan dari snapshot Drift dan tidak diedit manual.
Lihat `docs/LOCAL_PERSISTENCE_IMPLEMENTATION.md` untuk workflow upgrade.

v2 menambahkan raw OCR, lines JSON dan scan revision pada draft. Test upgrade
v1 → v2 memverifikasi Coffee dan foto draft lama tetap ada serta default revisi
0. Snapshot v1 dipertahankan; v2 dan helper dibuat dengan `drift_dev schema`.

v3 menambahkan review JSON dan review revision. Upgrade v1 → v3 menjaga data
Coffee/draft foto; v2 → v3 menjaga raw OCR dan scan revision. Snapshot v1/v2
tetap ada; fresh schema dan unsupported future version juga diuji.
