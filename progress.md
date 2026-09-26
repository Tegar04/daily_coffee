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

- [ ] Implementasikan bootstrap/splash serta penanganan initialization error.
- [ ] Konfigurasikan typed routes dengan `go_router`.
- [ ] Buat shell navigasi utama untuk Collection, Journal, dan Settings.
- [ ] Implementasikan route detail, add, edit, search, scan, dan review.
- [ ] Tambahkan halaman placeholder untuk seluruh route utama agar alur dapat diuji.
- [ ] Tangani back navigation, deep link internal, dan unsaved-changes dialog.
- [ ] Simpan status onboarding dan tampilkan hanya pada first launch.

**Definition of Done**

- [ ] Semua layar pada MVP dapat dicapai melalui navigation flow yang benar.
- [ ] Refresh/rebuild dan tombol Back tidak menghasilkan route rusak atau kehilangan state penting.

## Phase 3 — Design System Implementation

- [ ] Ubah token warna, typography, spacing 8pt, radius, elevation, dan motion dari `DESIGN_SYSTEM.md` menjadi theme/token code.
- [ ] Implementasikan light theme dan fondasi dark theme.
- [ ] Buat komponen reusable: button, text field, chip, card, app bar, sheet, dialog, empty state, loading, dan error state.
- [ ] Buat komponen coffee card, journal card, rating input, dan controlled-vocabulary picker.
- [ ] Pastikan layout responsif untuk compact dan layar Android yang lebih lebar.
- [ ] Tambahkan preview/widget test untuk komponen utama.

**Definition of Done**

- [ ] Komponen utama konsisten dengan `DESIGN_SYSTEM.md` dan dapat dipakai lintas feature.
- [ ] Tidak ada warna, spacing, dan text style penting yang di-hardcode berulang di feature.

## Phase 4 — Coffee MVP: Manual Flow

- [ ] Definisikan domain model `Coffee` dengan UUID dan tipe/value object yang diperlukan.
- [ ] Definisikan model variety, tasting note, dan photo tanpa mencampur data journal.
- [ ] Buat contract `CoffeeRepository` dan fake/in-memory implementation untuk development awal.
- [ ] Buat Riverpod query provider untuk collection dan detail.
- [ ] Buat controller/command untuk add, edit, favorite, dan delete coffee.
- [ ] Implementasikan Coffee Collection beserta loading, empty, error, dan populated state.
- [ ] Implementasikan form Add Coffee Manual dengan validasi dan progressive disclosure.
- [ ] Implementasikan Coffee Detail dan Edit Coffee.
- [ ] Tambahkan konfirmasi delete serta penanganan coffee yang memiliki journal entry.
- [ ] Pastikan input manual selalu tersedia tanpa kamera, OCR, maupun network.

**Definition of Done**

- [ ] Pengguna dapat membuat, melihat, mengubah, memfavoritkan, dan menghapus coffee melalui UI.
- [ ] Validasi dan error tampil sebagai pesan yang dapat dipahami, bukan raw exception.
- [ ] Flow manual lulus unit test controller dan widget test utama menggunakan fake repository.

## Phase 5 — Local Persistence: Drift/SQLite

- [ ] Pasang dan konfigurasi Drift/SQLite beserta code generation.
- [ ] Implementasikan schema sesuai `DATA_MODEL.md`, termasuk Coffee, Variety, Tasting Note, Photo, Draft, dan Journal.
- [ ] Aktifkan foreign key dan definisikan aturan referential integrity/cascade secara eksplisit.
- [ ] Buat DAO berdasarkan batas feature, bukan satu DAO besar.
- [ ] Implementasikan mapper table ↔ domain dan Drift-backed repositories.
- [ ] Gunakan transaction untuk operasi multi-table.
- [ ] Tambahkan migration strategy, schema version, dan migration test.
- [ ] Ganti fake repository dengan local repository melalui provider injection.
- [ ] Uji data tetap ada setelah aplikasi ditutup dan dibuka kembali.

**Definition of Done**

- [ ] Drift menjadi source of truth untuk data persisten.
- [ ] CRUD coffee tetap bekerja setelah restart aplikasi.
- [ ] Database, repository, constraint, dan migration utama memiliki automated test.

## Phase 6 — Image Handling

- [ ] Pasang dependency camera/gallery, path provider, dan image processing yang dipilih.
- [ ] Implementasikan pengambilan foto dari kamera dan Android Photo Picker.
- [ ] Minta permission hanya saat fitur digunakan dan sediakan fallback manual.
- [ ] Tambahkan preview, retake/reselect, crop/rotate bila diperlukan, serta kompresi terukur.
- [ ] Simpan original/processed image ke app-managed storage dengan nama/path terkelola.
- [ ] Simpan hanya metadata/path yang diperlukan di database.
- [ ] Buat thumbnail untuk collection tanpa memuat image resolusi penuh.
- [ ] Tangani pembatalan picker, app interruption, file hilang, dan permission denied.
- [ ] Implementasikan cleanup untuk temporary/orphan files dan penghapusan coffee.

**Definition of Done**

- [ ] Coffee dapat memiliki foto yang tetap tersedia setelah restart.
- [ ] Kegagalan kamera/file tidak merusak record database dan tidak memblokir input manual.

## Phase 7 — OCR Scanning

- [ ] Pilih adapter OCR on-device terlebih dahulu dan bungkus SDK di infrastructure layer.
- [ ] Implementasikan scan state: idle, acquiring, processing, success, failure, dan cancelled.
- [ ] Normalisasi orientation, ukuran, dan kualitas image sebelum OCR.
- [ ] Ekstrak raw text beserta informasi confidence yang tersedia.
- [ ] Simpan hasil OCR hanya sebagai `CoffeeDraft`, bukan langsung sebagai `Coffee` permanen.
- [ ] Implementasikan retry, cancel, timeout, dan fallback ke input manual.
- [ ] Tambahkan fixture label kopi untuk menguji variasi layout dan kualitas foto.

**Definition of Done**

- [ ] Foto label dapat menghasilkan raw OCR text tanpa network jika adapter mendukungnya.
- [ ] Scan gagal/dibatalkan secara aman dan pengguna tetap dapat melanjutkan manual.

## Phase 8 — Structured Extraction dan Editable Confirmation

- [ ] Definisikan `CoffeeDraft` dan `ScanExtractedField` lengkap dengan source/confidence.
- [ ] Buat parser untuk nama coffee, roaster, origin, process, variety, roast date, tasting notes, dan berat.
- [ ] Gunakan aturan deterministik terlebih dahulu; tandai field ambigu atau low-confidence.
- [ ] Implementasikan Review Scan Result dengan image, raw text, dan field editable.
- [ ] Validasi semua field sebelum promotion.
- [ ] Simpan perubahan draft saat berpindah field/terjadi interruption.
- [ ] Promotion draft → Coffee harus atomik pada database.
- [ ] Hapus atau pertahankan draft secara eksplisit setelah save/cancel.
- [ ] Jika kelak memakai remote extraction, kirim melalui backend aman dan jangan tanam API key di aplikasi.

**Definition of Done**

- [ ] OCR tidak pernah membuat Coffee permanen tanpa review dan konfirmasi pengguna.
- [ ] Semua hasil ekstraksi dapat diperbaiki sebelum disimpan.
- [ ] Parser, draft persistence, dan promotion flow memiliki automated test.

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
