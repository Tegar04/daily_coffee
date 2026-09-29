# Local Persistence — Phase 5

## Cakupan

Coffee manual memakai `DriftCoffeeRepository` sebagai source of truth. UI dan
controller tetap memakai kontrak `CoffeeRepository`; adapter in-memory hanya
dipakai test/preview. Tidak ada migrasi data dari Phase 4 karena penyimpanan
Phase 4 hanya hidup di memori proses.

Schema juga menyediakan journal, draft, provenance scan, dan metadata foto.
Workflow journal, review/promotion draft, pengambilan foto, serta eksekusi cleanup
file tetap mengikuti Phase 6–9. Preferences onboarding/last-tab tetap memakai
`AppPreferences` typed dengan SharedPreferences sesuai opsi `DATA_MODEL.md`.

## Alur dan lokasi kode

```text
DailyCoffeeBootstrap
  → databaseInitializationProvider
  → appDatabaseProvider → AppDatabase → SQLite file/background isolate

UI → controller → CoffeeRepository → CoffeeDao → SQLite
SQLite notifications → aggregate snapshot → CoffeeMapper → Riverpod → UI
```

- `lib/core/database/app_database.dart`: schema version, initialization, migration.
- `lib/core/database/database_connection.dart`: app-support directory,
  `database/daily_coffee.sqlite`, satu logical instance per ProviderScope aplikasi.
- `lib/core/database/tables/app_tables.dart`: tabel dan constraint.
- `lib/core/database/schema.drift`: index dan trigger revision.
- `lib/core/database/daos/`: Coffee, Journal, Draft, dan Photo DAO.
- `lib/features/coffee/data/`: mapper, aggregate builder, repository.
- `lib/app/composition/database_providers.dart`: lifecycle database dan readiness.

Provider menutup database ketika scope dibuang. Bootstrap menunggu database dan
preferences siap. Kegagalan menampilkan pesan aman dan tombol retry eksplisit;
retry membangun ulang koneksi, tanpa menghapus file. Automatic retry Riverpod
dinonaktifkan untuk initialization agar kegagalan tidak tersembunyi di loading.

## Mapping schema v1

| Logical entity | Physical table |
|---|---|
| Coffee | `coffees` |
| CoffeeVariety | `coffee_varieties` |
| CoffeeTastingNote | `coffee_tasting_notes` |
| CoffeePhoto | `coffee_photos` |
| JournalEntry | `journal_entries` |
| JournalTastingNote | `journal_tasting_notes` |
| CoffeeDraft | `coffee_drafts` |
| DraftVariety | `draft_varieties` |
| DraftTastingNote | `draft_tasting_notes` |
| ScanExtractedField | `scan_extracted_fields` |
| Pending managed-file cleanup | `file_cleanup_tasks` |

Physical columns memakai snake_case. Semua ID adalah UUID lowercase. Timestamp
disimpan sebagai integer **microseconds since Unix epoch UTC** agar presisi domain
tidak hilang. Date-only disimpan `YYYY-MM-DD` tanpa konversi timezone. Journal
menyimpan `brewed_at` UTC dan `brewed_at_offset_minutes` untuk mempertahankan offset
aslinya. Dose/water memakai milligram; temperatur memakai deci-Celsius. Brew ratio
tidak disimpan. Normalized text mengikuti fungsi NFC/whitespace/lowercase domain.

`coffees.revision` adalah metadata teknis untuk konfirmasi delete, bukan field
form/domain. Trigger menaikkannya saat coffee, tag, photo, journal, atau journal
tasting note berubah. Timestamp tidak dipakai sebagai revision karena dua write
dapat mempunyai waktu yang sama.

`PRAGMA user_version` milik Drift menyimpan versi schema; tidak ada duplikasi
version table. Versi database terpisah dari format export yang belum diterapkan.

## Integrity dan transaksi

- Foreign keys aktif pada setiap koneksi. Child tag/photo/journal tidak boleh orphan.
- Coffee permanen memerlukan name/roastery nonblank, nilai numerik positif,
  rentang altitude valid, pasangan roast key/custom konsisten, dan tanggal valid.
- Tag unik menurut `(parent, normalized_value)` dan `(parent, position)`.
- Satu cover per coffee; path foto harus relatif dan tidak mengandung traversal.
- Journal mengharuskan parent, method/custom konsisten, rating 1–5 atau null,
  kuantitas positif, dan offset timezone yang valid.
- Draft boleh menyimpan nilai parsial/invalid untuk recovery. Status/type/source,
  FK, path, dan rentang confidence tetap divalidasi; draft tidak masuk library.
- Read aggregate dan create/update Coffee dilakukan dalam transaction. Write
  gagal pada child membatalkan parent maupun perubahan child sebelumnya.
- Edit memeriksa `expected` form snapshot sebelum write. Identity/createdAt tag
  yang masih sama dipertahankan; favorite, foto, dan provenance relevan tetap ada.
- Delete memeriksa ulang revision dan jumlah relasi dalam transaction yang sama,
  mengantrekan file cleanup, lalu cascade graph. File tidak dihapus oleh Phase 5.
  Kegagalan delete membatalkan cleanup task juga.

Keputusan physical tambahan: edit draft dimiliki `targetCoffeeId` dan ikut cascade
ketika coffee dihapus; path temporernya dimasukkan ke antrean cleanup terlebih
dahulu. Draft create independen tidak terpengaruh. Durasi retensi draft dan
eksekusi cleanup masih perlu dikerjakan bersama workflow draft/image.

Collection diurutkan `createdAt DESC, id ASC`. Query reaktif memantau parent dan
seluruh child Coffee, kemudian membaca snapshot konsisten; tidak mengirim row
Drift keluar data layer. Index untuk sort/filter/journal sudah tersedia, sedangkan
UI search/filter lengkap mengikuti Phase 10.

## Migration workflow

Schema **v1 adalah versi persisten pertama**, sehingga belum ada upgrade dari
versi aplikasi lama. Snapshot v1 dan fixture generated disimpan dalam repository.
Pengujian mencakup fresh install, membuka snapshot v1 dengan data, validasi schema,
penolakan database versi lebih baru, dan preservasi data saat gagal/retry.

Untuk perubahan schema berikutnya:

1. Pertahankan snapshot versi yang sudah dirilis.
2. Ubah tabel dan naikkan `schemaVersion`.
3. Jalankan `dart run drift_dev make-migrations`.
4. Implementasikan langkah upgrade yang dihasilkan; ganti guard unsupported
   version hanya untuk jalur upgrade yang benar-benar didukung.
5. Tambahkan fixture berisi data dan uji setiap versi lama yang didukung, termasuk
   backfill/normalization jika diperlukan. Jangan mengubah migration yang dirilis.

Fixture v1 awal dihasilkan dengan:

```powershell
dart run drift_dev schema generate lib/core/database/migrations/schemas/app_database test/migrations/generated
```

Workflow mengikuti [dokumentasi migration Drift](https://drift.simonbinder.eu/migrations/).
Tidak ada fallback drop/recreate atau reset database ketika migration gagal.

## Verifikasi

**Quality gate 28 September 2026:** `tool/quality_check.ps1` lulus dependency
resolution, code generation, format, analyzer tanpa issue, seluruh **75 test**
(termasuk 5 golden), dan build APK debug normal. `git diff --check` juga lulus.
APK: `build/app/outputs/flutter-apk/app-debug.apk`.

**QA Android 28 September 2026:** ketiga tahap `seed`, `verify`, dan `deleted`
lulus pada Pixel 7 (`emulator-5554`). Proses aplikasi di-force-stop di antara
tahap; instalasi dipertahankan dengan `--no-uninstall`. Create/edit/favorite
terbukti bertahan saat proses baru dibuka, dan delete tetap berlaku pada
peluncuran berikutnya. Perangkat fisik/TalkBack belum diuji pada Phase 5.

```powershell
.\tool\quality_check.ps1
```

Tests baru berada di `test/database/`, `test/repositories/`, `test/migrations/`,
dan `test/providers/`. Test berbasis file menutup/membuka database beberapa kali
untuk memastikan create, edit, favorite, serta delete tetap bertahan.

QA Android memakai tiga proses test terpisah dengan koneksi produksi dan UI:

```powershell
flutter test integration_test/flows/local_persistence_test.dart -d emulator-5554 --no-uninstall --dart-define=PERSISTENCE_STAGE=seed
flutter test integration_test/flows/local_persistence_test.dart -d emulator-5554 --no-uninstall --dart-define=PERSISTENCE_STAGE=verify
flutter test integration_test/flows/local_persistence_test.dart -d emulator-5554 --no-uninstall --dart-define=PERSISTENCE_STAGE=deleted
```

`seed` membuat, memfavoritkan, dan mengedit coffee melalui UI. `verify` memastikan
data bertahan pada proses baru lalu menghapusnya melalui konfirmasi UI. `deleted`
memastikan penghapusan bertahan pada proses berikutnya. Jalankan berurutan pada
emulator yang sama tanpa clear-data/uninstall. Opsi `--no-uninstall` wajib karena
runner integration test Flutter secara default melakukan uninstall setelah test.
Setelah test, jalankan
`flutter run` atau build APK normal lagi karena APK test memakai entrypoint test.

Jika percobaan seed sebelumnya gagal, opsi tambahan
`--dart-define=PERSISTENCE_RESET_FIXTURE=true` pada seed hanya membersihkan coffee
dengan nama fixture QA dan roastery `Persistence Roaster`.

QA perangkat fisik: tambah kopi beserta tags, edit/favorite, force-stop aplikasi
(bukan clear-data), buka ulang, periksa detail, hapus, lalu force-stop/buka ulang.
Data lokal memang akan hilang bila pengguna menghapus app data atau uninstall;
backup/export belum menjadi bagian fase ini.
