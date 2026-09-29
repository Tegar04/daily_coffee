# Daily Coffee — Project Progress

Roadmap ini adalah tracker utama untuk menyelesaikan Daily Coffee sebagai project solo. Kerjakan fase secara berurutan; fitur cloud tetap ditunda sampai MVP lokal stabil.

## Status awal

- [x] Membuat project Flutter Android.
- [x] Menjalankan `flutter doctor` tanpa issue.
- [x] Menyiapkan Android emulator dan memastikan aplikasi dasar dapat dijalankan.
- [x] Membuat struktur dokumentasi di `docs/`.
- [x] Menyelesaikan dokumen desain inti, termasuk `DESIGN_SYSTEM.md` dan `UI_SCREENS.md`.
- [x] Memasang `flutter_riverpod` dan `go_router`.
- [x] Memastikan repository Git aktif, `.gitignore` benar, dan baseline awal sudah di-commit.

## Urutan prioritas

1. Foundation dan App Shell.
2. Implementasi Design System.
3. Coffee MVP dengan input manual.
4. Persistence lokal Drift/SQLite.
5. Image handling.
6. OCR, structured extraction, dan konfirmasi editable.
7. Brewing journal.
8. Search, filter, favorite, dan statistik.
9. Quality, accessibility, testing, dan hardening.
10. Release, dokumentasi, dan portfolio.
11. Account/cloud sync sebagai fase lanjutan setelah MVP.

---

## Phase 1 — Foundation

**Tujuan:** membentuk kerangka proyek, dependency boundary, dan quality gate yang akan dipakai semua phase berikutnya. Phase ini belum mengimplementasikan database schema, navigation flow, design system, atau business feature.

**Referensi arsitektur:** `docs/ARCHITECTURE.md` bagian 5–8, 17–18, 21, dan 26–29.

### 1.1 Baseline proyek dan repository

- [x] Aktifkan repository Git dan pastikan `.gitignore` mengecualikan secret, build output, IDE-local files, serta file environment lokal.
- [x] Commit `pubspec.lock` karena Daily Coffee adalah aplikasi, bukan package.
- [x] Catat versi Flutter/Dart yang digunakan dan pastikan constraint pada `pubspec.yaml` sesuai.
- [x] Pastikan project dapat menjalankan aplikasi template pada emulator Android sebelum struktur diubah.

**Output:** baseline yang dapat dikembalikan dan direproduksi sebelum refactor foundation.

### 1.2 Struktur feature-first

- [x] Buat struktur root berikut di `lib/`: `app/`, `core/`, dan `features/`.
- [x] Buat `app/bootstrap/`, `app/routing/`, dan `app/localization/`; letakkan wiring aplikasi di `app`, bukan di feature.
- [x] Buat fondasi `core/errors/`, `core/config/`, `core/logging/`, `core/platform/`, `core/time/`, `core/identifiers/`, `core/validation/`, dan `core/utils/`.
- [x] Siapkan feature root `coffee/`, `journal/`, `capture/`, `scan/`, `onboarding/`, `settings/`, dan `data_transfer/` di bawah `lib/features/`.
- [x] Untuk feature yang mulai diimplementasikan, gunakan layer `domain/`, `application/`, `data/`, dan `presentation/`; jangan membuat file placeholder yang tidak dipakai hanya untuk memenuhi struktur.
- [x] Dokumentasikan dependency rule: presentation → application/domain, data → domain, bootstrap → concrete implementation, dan `core` tidak bergantung pada feature.
- [x] Larang folder global campuran seperti `models/`, `services/`, `controllers/`, atau `screens/`.

**Output:** struktur proyek mengikuti bagian 5–6 `ARCHITECTURE.md` dan siap berkembang per feature.

### 1.3 Dependency dan code generation

- [x] Audit dependency yang sudah terpasang: `flutter_riverpod`, `go_router`, `drift`, SQLite runtime, `path_provider`, dan `path`.
- [x] Tambahkan `riverpod_annotation` sebagai dependency.
- [x] Tambahkan `riverpod_generator`, `riverpod_lint`, `drift_dev`, dan `build_runner` sebagai dev dependency. Riverpod lint versi saat ini memakai analysis-server plugin dan tidak memerlukan `custom_lint`.
- [x] Pastikan hanya ada satu workflow `build_runner` untuk Drift, Riverpod, dan generator berikutnya.
- [x] Terapkan kebijakan generated files: hasil generator di-commit, tetapi tidak pernah diedit manual.
- [x] Catat alasan dan boundary setiap dependency foundational; jangan menambahkan package yang belum dibutuhkan Phase 1.

**Output:** dependency dasar terkunci pada `pubspec.yaml` dan `pubspec.lock`, serta code generation dapat dijalankan konsisten.

### 1.4 Bootstrap dan composition root Riverpod

- [x] Ubah `main.dart` menjadi entry point minimal: panggil `WidgetsFlutterBinding.ensureInitialized()` lalu jalankan `ProviderScope`.
- [x] Buat root widget aplikasi di `lib/app/app.dart` dan bootstrap boundary di `lib/app/bootstrap/`.
- [x] Buat composition root Riverpod untuk merakit konfigurasi dan dependency concrete; jangan memakai GetIt, service locator, atau mutable global singleton.
- [x] Siapkan provider injectable untuk clock dan ID generator agar test dapat deterministik.
- [x] Pastikan initialization failure nantinya dapat dipetakan ke state `initializing`, `ready`, `recoverableFailure`, atau `fatalFailure` tanpa menghapus data otomatis.

**Output:** aplikasi dimulai melalui `ProviderScope`, sedangkan `main.dart` tidak berisi business logic atau concrete dependency graph.

### 1.5 Result dan error contract

- [x] Implementasikan sealed `Result<T>` dengan varian sukses `Ok<T>` dan gagal `Err<T>`.
- [x] Implementasikan sealed `AppFailure` dengan stable internal code dan safe diagnostic context.
- [x] Definisikan kategori awal: validation, not found, conflict, storage, migration, permission, camera, image validation, OCR, network, external service, import/export, dan unexpected.
- [x] Siapkan boundary exception mapper untuk mengubah exception SDK/SQL/file menjadi `AppFailure`; jangan menampilkan raw exception di UI.
- [x] Tambahkan unit test untuk konstruksi, pattern matching, dan failure mapping dasar.

**Output:** semua public boundary asynchronous berikutnya mempunyai kontrak error yang typed dan konsisten.

### 1.6 Environment dan logging dasar

- [x] Buat konfigurasi build-time typed untuk nilai non-secret saja, seperti development flag, optional endpoint identifier, dan default logging level.
- [x] Gunakan `--dart-define` atau `--dart-define-from-file` hanya untuk konfigurasi non-secret.
- [x] Tambahkan contoh konfigurasi yang aman bila file lokal diperlukan, lalu ignore file konfigurasi developer yang sebenarnya.
- [x] Tegaskan bahwa API key, signing key, dan server secret tidak boleh masuk source Dart, asset, Dart define, maupun repository.
- [x] Buat interface logger minimal yang dapat diganti saat test dan tidak mencatat foto, OCR text, atau data sensitif.

**Output:** konfigurasi development dapat diubah tanpa hardcode dan tanpa membuka secret.

### 1.7 Lint, format, dan konvensi kode

- [x] Aktifkan `flutter_lints` dan analysis-server plugin `riverpod_lint` pada `analysis_options.yaml`.
- [x] Tambahkan lint yang menjaga dependency direction dan kebersihan kode tanpa menghasilkan suppressions massal.
- [x] Gunakan `snake_case.dart` untuk file, `UpperCamelCase` untuk type, `lowerCamelCase` untuk member/provider, dan suffix yang menjelaskan peran seperti `_repository`, `_controller`, `_screen`, atau `_provider`.
- [x] Gunakan import `package:daily_coffee/...` lintas folder dan relative import hanya untuk file yang sangat berdekatan dalam satu module.
- [x] Jalankan formatter pada source dan test; generated file tidak diedit manual.

**Output:** style dan naming konsisten serta analyzer dapat menjadi quality gate, bukan formalitas.

### 1.8 Test skeleton dan developer commands

- [x] Buat struktur `test/unit/`, `test/database/`, `test/repositories/`, `test/providers/`, `test/widgets/`, `test/golden/`, `test/migrations/`, `test/fixtures/`, dan `test/helpers/`.
- [x] Siapkan helper untuk `ProviderContainer`/provider override dan deterministic clock/ID.
- [x] Ganti counter test bawaan dengan smoke test root aplikasi dan unit test foundation.
- [x] Siapkan `integration_test/flows/` untuk phase berikutnya tanpa membuat integration test palsu.
- [x] Dokumentasikan atau buat script untuk perintah rutin berikut:

```powershell
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
```

- [x] Pastikan urutan quality gate adalah dependency resolution → code generation → format → analyze → test → debug build.

**Output:** developer mempunyai satu alur verifikasi lokal yang sama dengan quality gate proyek.

### Definition of Done

- [x] Clone bersih dapat menjalankan `flutter pub get`, code generation, test, dan debug build dengan instruksi yang terdokumentasi.
- [x] `flutter analyze` lulus tanpa error atau warning.
- [x] Seluruh test foundation lulus dan counter demo bawaan sudah dihapus.
- [x] `main.dart` hanya menjadi entry point dan aplikasi berjalan di dalam `ProviderScope`.
- [x] Struktur proyek dan dependency direction sesuai `docs/ARCHITECTURE.md`.
- [x] `Result<T>`/`AppFailure`, environment config, clock, ID generator, dan logger dapat di-override dalam test.
- [x] Tidak ada widget/controller yang mengakses DAO, database, filesystem, OCR SDK, atau raw exception secara langsung.
- [x] Tidak ada secret, generated output basi, atau file build yang masuk repository.
- [x] Status item hanya diubah menjadi `[x]` setelah command/verifikasi terkait benar-benar berhasil.

## Phase 2 — App Shell dan Navigation

- [x] Implementasikan bootstrap/splash serta penanganan initialization error.
- [x] Konfigurasikan typed routes dengan `go_router`.
- [x] Buat shell navigasi utama untuk Collection, Journal, dan Settings.
- [x] Implementasikan route detail, add, edit, search, scan, dan review.
- [x] Tambahkan halaman placeholder untuk seluruh route utama agar alur dapat diuji.
- [x] Tangani back navigation, deep link internal, dan unsaved-changes dialog.
- [x] Simpan status onboarding dan tampilkan hanya pada first launch.

**Definition of Done**

- [x] Semua layar pada MVP dapat dicapai melalui navigation flow yang benar.
- [x] Refresh/rebuild dan tombol Back tidak menghasilkan route rusak atau kehilangan state penting.

## Phase 3 — Design System Implementation

- [x] Ubah token warna, typography, spacing 8pt, radius, elevation, dan motion dari `DESIGN_SYSTEM.md` menjadi theme/token code.
- [x] Implementasikan light theme dan fondasi dark theme.
- [x] Buat komponen reusable: button, text field, chip, card, app bar, sheet, dialog, empty state, loading, dan error state.
- [x] Buat komponen coffee card, journal card, rating input, dan controlled-vocabulary picker.
- [x] Pastikan layout responsif untuk compact dan layar Android yang lebih lebar.
- [x] Tambahkan preview/widget test untuk komponen utama.

**Definition of Done**

- [x] Komponen utama konsisten dengan `DESIGN_SYSTEM.md` dan dapat dipakai lintas feature.
- [x] Tidak ada warna, spacing, dan text style penting yang di-hardcode berulang di feature.

**Verifikasi 28 September 2026:** `tool/quality_check.ps1` lulus: dependency
resolution, code generation, format, `flutter analyze` tanpa issue, seluruh **37
test** (termasuk 2 golden light/dark), dan `flutter build apk --debug`.
`git diff --check` juga lulus. APK: `build/app/outputs/flutter-apk/app-debug.apk`.

**Cakupan:** token dan komponen umum di `core/design_system`; kartu kopi/jurnal
milik presentation feature; font Inter/Lora beserta lisensi dibundel offline.
Layar Phase 2 menggunakan tema baru. Preview terpisah dapat dijalankan dengan
`flutter run -t lib/app/preview/design_system_preview.dart`. Panduan lengkap:
[`docs/DESIGN_SYSTEM_IMPLEMENTATION.md`](docs/DESIGN_SYSTEM_IMPLEMENTATION.md).

**Penyesuaian:** grid mengikuti minimum width dan text scale; skeleton statis
serta reduce motion didukung; teks badge memakai textPrimary agar kontras terjaga.
Quality gate PowerShell kini berhenti saat command gagal. Pilihan tema tersimpan
masih Phase 11; CRUD/persistence tidak termasuk Phase 3. Tidak ada Android yang
terhubung saat verifikasi, sehingga TalkBack dan QA perangkat fisik belum dilakukan.

## Phase 4 — Coffee MVP: Manual Flow

- [x] Definisikan domain model `Coffee` dengan UUID dan tipe/value object yang diperlukan.
- [x] Definisikan model variety, tasting note, dan photo tanpa mencampur data journal.
- [x] Buat contract `CoffeeRepository` dan fake/in-memory implementation untuk development awal.
- [x] Buat Riverpod query provider untuk collection dan detail.
- [x] Buat controller/command untuk add, edit, favorite, dan delete coffee.
- [x] Implementasikan Coffee Collection beserta loading, empty, error, dan populated state.
- [x] Implementasikan form Add Coffee Manual dengan validasi dan progressive disclosure.
- [x] Implementasikan Coffee Detail dan Edit Coffee.
- [x] Tambahkan konfirmasi delete serta penanganan coffee yang memiliki journal entry.
- [x] Pastikan input manual selalu tersedia tanpa kamera, OCR, maupun network.

**Definition of Done**

- [x] Pengguna dapat membuat, melihat, mengubah, memfavoritkan, dan menghapus coffee melalui UI.
- [x] Validasi dan error tampil sebagai pesan yang dapat dipahami, bukan raw exception.
- [x] Flow manual lulus unit test controller dan widget test utama menggunakan fake repository.

**Verifikasi 28 September 2026:** `tool/quality_check.ps1` lulus seluruhnya:
dependency resolution, code generation, format, `flutter analyze` tanpa issue,
**56 test** (termasuk 5 golden), dan debug APK. `git diff --check` lulus.
Snapshot koleksi, detail, dan form juga diperiksa secara visual.
APK: `build/app/outputs/flutter-apk/app-debug.apk`.

**Cakupan:** manual create → detail → favorite → edit → delete, validasi field,
custom values dan tag, loading/empty/error/retry, retensi snapshot koleksi ketika
refresh gagal, unsaved-changes guard, serta layout compact 200% dengan keyboard.
`isFavorite` ditambahkan ke model sesuai tracker dan terdokumentasi. Delete
memeriksa ulang impact/revision; jumlah journal terkait diuji dengan fake relational
links. Implementasi JournalRepository dan cascade database sesungguhnya tetap
phase berikutnya.

**Batas fase:** repository masih **in-memory**; data hilang ketika proses aplikasi
ditutup atau hot restart. Drift persistence masuk Phase 5. Foto/OCR, draft recovery,
search/filter lengkap, dan jurnal masih mengikuti urutan roadmap. Tidak ada Android
terhubung saat verifikasi; TalkBack dan QA perangkat fisik belum dilakukan.
Panduan implementasi dan QA:
[`docs/COFFEE_MANUAL_IMPLEMENTATION.md`](docs/COFFEE_MANUAL_IMPLEMENTATION.md).

## Phase 5 — Local Persistence: Drift/SQLite

- [x] Pasang dan konfigurasi Drift/SQLite beserta code generation.
- [x] Implementasikan schema sesuai `DATA_MODEL.md`, termasuk Coffee, Variety, Tasting Note, Photo, Draft, dan Journal.
- [x] Aktifkan foreign key dan definisikan aturan referential integrity/cascade secara eksplisit.
- [x] Buat DAO berdasarkan batas feature, bukan satu DAO besar.
- [x] Implementasikan mapper table ↔ domain dan Drift-backed repositories.
- [x] Gunakan transaction untuk operasi multi-table.
- [x] Tambahkan migration strategy, schema version, dan migration test.
- [x] Ganti fake repository dengan local repository melalui provider injection.
- [x] Uji data tetap ada setelah aplikasi ditutup dan dibuka kembali.

**Definition of Done**

- [x] Drift menjadi source of truth untuk data persisten.
- [x] CRUD coffee tetap bekerja setelah restart aplikasi.
- [x] Database, repository, constraint, dan migration utama memiliki automated test.

**Verifikasi 28 September 2026:** `tool/quality_check.ps1` lulus seluruhnya:
dependency resolution, code generation, format, `flutter analyze` tanpa issue,
**75 test** (termasuk 5 golden), dan debug APK. `git diff --check` lulus.

**QA Android:** tiga tahap integration test (`seed`, `verify`, `deleted`) lulus
pada Pixel 7 / `emulator-5554`, memakai UI dan background SQLite connection
produksi. Proses di-force-stop antartahap; data create/edit/favorite tetap ada,
lalu hasil delete tetap bertahan setelah restart berikutnya. Runner memakai
`--no-uninstall` agar data tidak dihapus oleh teardown Flutter.

**Cakupan:** schema v1, FK/constraint/index, DAO per feature, mapper Coffee,
`DriftCoffeeRepository`, transaksi/rollback, konfirmasi delete berbasis revision,
antrean cleanup file, bootstrap dengan retry aman, dan snapshot/migration tests.
Schema v1 adalah versi persisten pertama; belum ada versi lama untuk di-upgrade.
Versi database tak didukung ditolak tanpa reset atau kehilangan data.

**Batas fase:** foto baru berupa metadata/path dan antrean cleanup; eksekusi
pipeline file tetap Phase 6. Schema/DAO draft dan journal siap, tetapi workflow
review/promotion dan UI journal tetap Phase 7-9. Preferences tetap memakai
`AppPreferences`. Perangkat fisik/TalkBack belum diuji pada fase ini.
Panduan: [`docs/LOCAL_PERSISTENCE_IMPLEMENTATION.md`](docs/LOCAL_PERSISTENCE_IMPLEMENTATION.md).
APK normal: `build/app/outputs/flutter-apk/app-debug.apk`.

## Phase 6 — Image Handling

- [x] Pasang dependency camera/gallery, path provider, dan image processing yang dipilih.
- [x] Implementasikan pengambilan foto dari kamera dan Android Photo Picker.
- [x] Minta permission hanya saat fitur digunakan dan sediakan fallback manual.
- [x] Tambahkan preview, retake/reselect, crop/rotate bila diperlukan, serta kompresi terukur.
- [x] Simpan original/processed image ke app-managed storage dengan nama/path terkelola.
- [x] Simpan hanya metadata/path yang diperlukan di database.
- [x] Buat thumbnail untuk collection tanpa memuat image resolusi penuh.
- [x] Tangani pembatalan picker, app interruption, file hilang, dan permission denied.
- [x] Implementasikan cleanup untuk temporary/orphan files dan penghapusan coffee.

**Definition of Done**

- [x] Coffee dapat memiliki foto yang tetap tersedia setelah restart.
- [x] Kegagalan kamera/file tidak merusak record database dan tidak memblokir input manual.

**Verifikasi 29 September 2026:** `tool/quality_check.ps1` lulus seluruhnya:
dependency resolution, code generation, format, `flutter analyze` tanpa issue,
**90 test** (termasuk 5 golden), dan debug APK. `git diff --check` lulus.

**QA Android:** tiga tahap integration test (`seed`, `verify`, `deleted`) lulus
pada Android emulator dengan UI dan production Drift/filesystem. Force-stop
antartahap membuktikan persistensi foto dan hasil delete; acquisition pada test
ini memakai fixture adapter deterministik.

**QA native Pixel 7:** kamera sistem berhasil capture ke preview dan dibatalkan;
Android Photo Picker berhasil memilih label fixture. Force-stop saat preview
belum disimpan diikuti pemulihan foto serta nama/roastery melalui konfirmasi
pengguna. Coffee hasil recovery berhasil disimpan; cover/thumbnail tampil setelah
restart. Delete via UI menghapus kedua file dan temporary sidecars. Fixture QA
dibersihkan. Preview kamera, galeri, form golden, dan collection diperiksa visual.

**Cakupan:** satu cover opsional; preview/retake/reselect/replace/remove; validasi
JPEG/PNG/WebP, batas input dan header JPEG sebelum alokasi besar; normalisasi EXIF;
processing di isolate; thumbnail; managed relative paths; transaksi metadata
beserta compensation; checkpoint dan lost-result association; cleanup dengan
reference check dan retry. Schema tetap v1.

**Keputusan/batas:** kamera sistem memakai `image_picker`; custom camera,
crop/rotate manual opsional, dan duplikasi original permanen tidak ditambahkan.
Cover JPEG 2400 px / quality 90; thumbnail 480 px / quality 80. Checkpoint dibuat
sebelum picker, bukan autosave setiap field. OCR tetap Phase 7-8. Hardware kamera
fisik, TalkBack, low-storage nyata, dan seluruh variasi OEM belum diverifikasi.
Panduan: [`docs/IMAGE_HANDLING_IMPLEMENTATION.md`](docs/IMAGE_HANDLING_IMPLEMENTATION.md).
APK normal: `build/app/outputs/flutter-apk/app-debug.apk`.

## Phase 7 — OCR Scanning

- [x] Pilih adapter OCR on-device terlebih dahulu dan bungkus SDK di infrastructure layer.
- [x] Implementasikan scan state: idle, acquiring, processing, success, failure, dan cancelled.
- [x] Normalisasi orientation, ukuran, dan kualitas image sebelum OCR.
- [x] Ekstrak raw text beserta informasi confidence yang tersedia.
- [x] Simpan hasil OCR hanya sebagai `CoffeeDraft`, bukan langsung sebagai `Coffee` permanen.
- [x] Implementasikan retry, cancel, timeout, dan fallback ke input manual.
- [x] Tambahkan fixture label kopi untuk menguji variasi layout dan kualitas foto.

**Definition of Done**

- [x] Foto label dapat menghasilkan raw OCR text tanpa network jika adapter mendukungnya.
- [x] Scan gagal/dibatalkan secara aman dan pengguna tetap dapat melanjutkan manual.

**Verifikasi — 29 September 2026**

- `tool/quality_check.ps1` lulus: dependency resolution, code generation,
  format check, analyzer tanpa issue, **98 tests** (termasuk 5 golden), dan APK debug.
- OCR ML Kit native lulus pada emulator Pixel 7 dengan mode pesawat aktif dan
  Wi-Fi mati: label satu kolom, dua kolom, kompresi/blur ringan, serta no-text
  failure pada gambar kosong. Tiga draft berhasil dimuat setelah force-stop
  melalui integration test `seed` → `verify`, tanpa Coffee permanen.
- QA APK normal lulus: galeri native → foto → teks OCR → force-stop → buka draft
  → hapus draft; fallback **Isi manual** membuka formulir. Data fixture QA
  dibersihkan dan pengaturan jaringan emulator dipulihkan.
- Database v2 menyimpan raw OCR, line bounds/confidence nullable, dan scan
  revision. Migrasi v1 → v2 menjaga Coffee dan draft foto lama.
- Cancel/timeout menggunakan logical cancellation dan menolak late result.
  Akurasi label fisik, TalkBack, OEM lain, serta build iOS belum diverifikasi.
- **Batas Phase 7:** teks mentah tersimpan sebagai draft; parsing nama kopi,
  roastery, origin, dll. dan editable confirmation/promotion tetap **Phase 8**.

Panduan: [OCR_SCANNING_IMPLEMENTATION.md](docs/OCR_SCANNING_IMPLEMENTATION.md).
APK: `build/app/outputs/flutter-apk/app-debug.apk`.

## Phase 8 — Structured Extraction dan Editable Confirmation

- [x] Definisikan `CoffeeDraft` dan `ScanExtractedField` lengkap dengan source/confidence.
- [x] Buat parser untuk nama coffee, roaster, origin, process, variety, roast date, tasting notes, dan berat.
- [x] Gunakan aturan deterministik terlebih dahulu; tandai field ambigu atau low-confidence.
- [x] Implementasikan Review Scan Result dengan image, raw text, dan field editable.
- [x] Validasi semua field sebelum promotion.
- [x] Simpan perubahan draft saat berpindah field/terjadi interruption.
- [x] Promotion draft → Coffee harus atomik pada database.
- [x] Hapus atau pertahankan draft secara eksplisit setelah save/cancel.
- [x] Jika kelak memakai remote extraction, kirim melalui backend aman dan jangan tanam API key di aplikasi. Saat ini parser sepenuhnya lokal; remote extraction/API key tidak digunakan.

**Definition of Done**

- [x] OCR tidak pernah membuat Coffee permanen tanpa review dan konfirmasi pengguna.
- [x] Semua hasil ekstraksi dapat diperbaiki sebelum disimpan.
- [x] Parser, draft persistence, dan promotion flow memiliki automated test.

**Verifikasi — 29 September 2026**

- `tool/quality_check.ps1` lulus: code generation, format, analyzer tanpa issue,
  **113 tests** termasuk golden, dan build APK debug normal.
- Parser diuji untuk alias Indonesia/Inggris, kandidat ambigu, tanggal/berat/
  altitude, confidence nullable, dan raw provenance. Informasi yang tidak jelas
  dibiarkan kosong dan ditampilkan untuk review; tidak ditebak dari heading.
- Repository tests memverifikasi edit parsial setelah reopen, source user,
  stale revision, photo opt-out, rollback aggregate saat insert foto gagal,
  retry, serta penolakan promotion berulang. Autosave berurutan dan duplicate
  confirmation diuji; widget review diuji dengan text scale 200%.
- Integration Android `scan_review_test.dart` lulus pada tahap `seed` dan
  `verify` dengan force-stop di antaranya: native OCR → form review → edit nama
  dan tanggal parsial → restart → edit tetap ada → perbaiki tanggal → konfirmasi
  → satu Coffee/foto permanen, draft/raw/candidate terhapus. Data QA terisolasi
  dibersihkan setelah verifikasi.
- Schema v3 menyimpan editable snapshot/revision; migrasi v1 dan v2 ke v3 diuji
  tanpa menghapus data lama. Keluar dari review mempertahankan draft; hapus
  draft meminta konfirmasi. Write yang masih berlangsung saat OS kill belum
  dijamin durable; UI menunjukkan status penyimpanan draft.
- Perangkat fisik, TalkBack, iOS, dan akurasi kumpulan label nyata belum
  diverifikasi. Parser menggunakan aturan/vocabulary terbatas, bukan generative AI.

Panduan: [SCAN_REVIEW_IMPLEMENTATION.md](docs/SCAN_REVIEW_IMPLEMENTATION.md).
APK: `build/app/outputs/flutter-apk/app-debug.apk`.

## Phase 9 — Brewing Journal

- [ ] Definisikan `JournalEntry` serta tasting note journal terpisah dari tasting note coffee.
- [ ] Implementasikan `JournalRepository`, DAO, mapper, provider, dan controller.
- [ ] Implementasikan Journal List dan filter dasarnya.
- [ ] Implementasikan Add Journal Entry dengan coffee picker.
- [ ] Catat method, dose, water, temperature, grind, duration, rating, notes, dan brewed-at sesuai kebutuhan MVP.
- [ ] Hitung brew ratio dari dose/water; jangan simpan sebagai source of truth.
- [ ] Implementasikan Journal Detail, Edit, dan Delete.
- [ ] Tampilkan riwayat brew terkait pada Coffee Detail.

**Definition of Done**

- [ ] Pengguna dapat mencatat, membaca, mengubah, dan menghapus sesi seduh secara offline.
- [ ] Relasi coffee–journal konsisten dan perhitungan turunan memiliki unit test.

## Phase 10 — Discovery dan Insight

- [ ] Implementasikan search coffee dengan debounce.
- [ ] Tambahkan filter origin, process, roast level/status, favorite, dan tasting note yang disepakati.
- [ ] Tambahkan sort terbaru, nama, rating, dan roast date jika relevan.
- [ ] Persist pilihan filter hanya jika meningkatkan pengalaman pengguna.
- [ ] Selesaikan favorite flow dan favorite section/filter.
- [ ] Buat statistik lokal: jumlah coffee, jumlah brew, metode favorit, rating/ringkasan tren yang bermakna.
- [ ] Uji empty result, kombinasi filter, dan performa pada dataset besar yang realistis.

**Definition of Done**

- [ ] Search/filter/favorite menghasilkan data yang benar dan responsif.
- [ ] Statistik berasal dari query lokal teruji dan tidak mengubah source data.

## Phase 11 — Settings, Dark Mode, Accessibility, dan Quality

- [ ] Implementasikan Settings, Data & Storage, dan About.
- [ ] Selesaikan dark mode serta opsi system/light/dark yang tersimpan.
- [ ] Tambahkan semantic labels, focus order, dan dukungan screen reader.
- [ ] Pastikan touch target minimal, contrast memadai, dan UI tetap usable pada text scaling besar.
- [ ] Uji orientation, keyboard overlap, loading lambat, permission denial, dan low-storage scenario.
- [ ] Tambahkan unit test domain/parser/controller, database/repository test, widget test, dan integration test happy path.
- [ ] Tambahkan golden test hanya untuk layar/komponen visual yang stabil.
- [ ] Jalankan formatter, code generation check, `flutter analyze`, dan seluruh test di CI.
- [ ] Audit logging agar tidak merekam foto, OCR text, atau data pribadi tanpa kebutuhan.
- [ ] Audit performa list, image decoding, query, startup, serta ukuran aplikasi.

**Definition of Done**

- [ ] Light/dark mode dan accessibility flow utama lolos pemeriksaan manual.
- [ ] Analyze dan seluruh automated test lulus lokal serta di CI.
- [ ] Tidak ada crash/blocker pada end-to-end flow utama di perangkat Android nyata.

## Phase 12 — Data Control dan Backup Lokal

- [ ] Implementasikan informasi penggunaan storage.
- [ ] Implementasikan delete all data dengan konfirmasi berlapis.
- [ ] Pastikan penghapusan database dan file image memiliki recovery/cleanup yang aman.
- [ ] Tentukan format export yang versioned dan terdokumentasi.
- [ ] Implementasikan export/import lokal bila masuk scope rilis pertama.
- [ ] Uji import invalid, partial failure, duplicate ID, dan kompatibilitas versi.

**Definition of Done**

- [ ] Pengguna dapat memahami dan menghapus data lokalnya dengan aman.
- [ ] Jika export/import dirilis, round-trip data dan image tervalidasi.

## Phase 13 — Release Preparation

- [ ] Tetapkan application ID, display name, versioning, icon, dan splash final.
- [ ] Buat signing key dan simpan credential di lokasi aman di luar repository.
- [ ] Periksa permission Android dan hapus permission yang tidak dibutuhkan.
- [ ] Siapkan privacy policy yang menjelaskan foto, OCR, local storage, dan layanan eksternal.
- [ ] Uji build release pada minimal satu perangkat fisik dan beberapa ukuran layar.
- [ ] Jalankan regression checklist untuk add manual, scan, review, journal, search, theme, dan persistence.
- [ ] Perbaiki crash, ANR, overflow, broken navigation, serta kehilangan data.
- [ ] Buat Android App Bundle dan lakukan internal testing sebelum production.
- [ ] Siapkan store listing, screenshot, deskripsi, kategori, dan contact/support.

**Definition of Done**

- [ ] Signed release build dapat di-install dan seluruh critical flow berfungsi.
- [ ] Tidak ada issue severity blocker/high yang belum ditangani.
- [ ] Checklist privacy, backup, signing, dan store submission selesai.

## Phase 14 — Documentation dan Portfolio

- [ ] Perbarui README dengan tujuan produk, screenshot, fitur, stack, arsitektur, dan cara menjalankan project.
- [ ] Dokumentasikan setup Drift/code generation, testing, release, serta keputusan arsitektur penting.
- [ ] Sinkronkan implementasi dengan `DESIGN_SYSTEM.md`, `UI_SCREENS.md`, `DATA_MODEL.md`, dan `ARCHITECTURE.md`.
- [ ] Catat known limitations dan backlog secara jujur.
- [ ] Buat demo video singkat dari flow manual, OCR review, dan journal.
- [ ] Buat studi kasus portfolio: masalah, proses desain, trade-off, tantangan teknis, testing, dan hasil.
- [ ] Pastikan repository publik bebas secret, data pribadi, signing key, dan file build besar.

**Definition of Done**

- [ ] Developer lain dapat memahami dan menjalankan project dari dokumentasi.
- [ ] Portfolio menunjukkan produk yang bekerja, keputusan yang dapat dijelaskan, dan bukti quality checks.

## Phase 15 — Later: Account dan Cloud Sync dengan Supabase

> Kerjakan hanya setelah MVP local-first stabil dan model konflik sync sudah dirancang.

- [ ] Tetapkan kebutuhan nyata untuk account, multi-device, backup, dan restore.
- [ ] Rancang auth flow, schema Supabase, Row Level Security, dan privacy boundary.
- [ ] Tambahkan sync metadata tanpa mengganti local database sebagai source of truth UI.
- [ ] Rancang queue offline, retry, idempotency, tombstone/delete propagation, dan conflict resolution.
- [ ] Implementasikan upload/download image dengan aturan akses dan cleanup.
- [ ] Tambahkan migration/association dari data lokal anonim ke account.
- [ ] Uji offline-first, login/logout, dua perangkat, konflik edit, duplicate, dan partial sync.
- [ ] Sediakan delete account serta penghapusan data cloud.

**Definition of Done**

- [ ] Aplikasi tetap berfungsi penuh saat offline atau Supabase tidak tersedia.
- [ ] Sync bersifat idempotent, teruji untuk konflik, dan tidak menyebabkan kehilangan/duplikasi data.
- [ ] RLS, penghapusan account, dan kebijakan privasi telah diverifikasi sebelum rilis cloud.

---

## MVP Release Gate

- [ ] Flow Add Coffee Manual → Collection → Detail berjalan end-to-end.
- [ ] Data coffee dan journal tetap tersedia setelah restart.
- [ ] Flow Photo → OCR → Editable Review → Save berjalan tanpa membuat data otomatis.
- [ ] Search, filter, favorite, dan statistik utama benar.
- [ ] Camera/OCR failure selalu memiliki jalan kembali atau input manual.
- [ ] Dark mode, accessibility dasar, dan perangkat fisik telah diuji.
- [ ] `flutter analyze`, automated tests, dan release build lulus.
- [ ] Privacy, signing, README, dan store assets siap.

## Aturan pemeliharaan tracker

- Centang `[x]` hanya setelah item selesai dan diverifikasi.
- Jangan menandai satu fase selesai hanya karena UI sudah terlihat; data, error state, dan test juga harus lulus.
- Catat blocker atau keputusan yang berubah di bawah item terkait, bukan dengan menghapus requirement lama.
- Perbarui roadmap pada akhir setiap sesi implementasi atau setiap milestone.
