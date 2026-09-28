# Daily Coffee

Daily Coffee adalah aplikasi Flutter Android local-first untuk menyimpan koleksi
specialty coffee dan jurnal seduh pribadi. MVP tetap dapat digunakan tanpa
network; OCR hanya membantu membuat draft dan tidak pernah menyimpan coffee
permanen tanpa review pengguna.

## Baseline

- Flutter 3.47.5 stable
- Dart 3.13.4
- Android API 24 minimum (provisional; diverifikasi ulang saat dependency final)
- Riverpod untuk state management dan dependency composition
- Drift/SQLite untuk persistence lokal
- `go_router` untuk typed navigation pada Phase 2

Dokumen sumber kebenaran berada di `docs/`, terutama
[`ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## Menjalankan proyek

```powershell
flutter pub get
dart run build_runner build
flutter run
```

Untuk memilih emulator tertentu:

```powershell
flutter devices
flutter run -d emulator-5554
```

## Konfigurasi non-secret

Salin `config/app_config.example.json` menjadi
`config/app_config.local.json`, lalu ubah hanya nilai non-secret. File lokal
tersebut diabaikan Git.

```powershell
flutter run --dart-define-from-file=config/app_config.local.json
```

Key yang didukung:

- `APP_ENV`: `development`, `staging`, atau `production`.
- `LOG_LEVEL`: `debug`, `info`, `warning`, `error`, atau `off`.
- `ENABLE_DEVELOPER_TOOLS`: boolean.
- `REMOTE_ENDPOINT_IDENTIFIER`: identifier opsional, bukan secret.

API key, signing key, access token, dan server secret tidak boleh disimpan dalam
source, asset, atau Dart define karena seluruhnya dapat diekstrak dari aplikasi.

## Struktur source

```text
lib/
├── app/          # bootstrap, composition root, routing, localization
├── core/         # shared infrastructure dan cross-feature contracts
├── features/     # feature-first business modules
└── main.dart     # entry point minimal
```

Feature membuat layer `domain`, `application`, `data`, dan `presentation` hanya
saat implementasinya dimulai. Domain tetap pure Dart; widget tidak mengakses
database, filesystem, OCR SDK, atau raw exception secara langsung.

## Code generation

Drift dan Riverpod memakai satu workflow:

```powershell
.\tool\generate.ps1
```

Generated files di-commit agar clone bersih dapat diverifikasi, tetapi tidak
pernah diedit manual.

## Quality gate

Jalankan seluruh pemeriksaan lokal:

```powershell
.\tool\quality_check.ps1
```

Urutannya adalah dependency resolution, code generation, format check, static
analysis, automated tests, lalu debug APK build.

## Design system (Phase 3)

Tema, komponen, dan aturan pemakaian tersedia di
[`DESIGN_SYSTEM_IMPLEMENTATION.md`](docs/DESIGN_SYSTEM_IMPLEMENTATION.md).
Untuk membuka preview interaktif light/dark dan text scaling:

```powershell
flutter run -t lib/app/preview/design_system_preview.dart
```

Preview menggunakan data contoh terpisah. Aplikasi utama dijalankan dengan
`flutter run`.

## Coffee manual (Phase 4)

Tambah, lihat, edit, favorite, dan hapus kopi tersedia melalui koleksi. Form manual
dapat digunakan offline, dengan validasi dan konfirmasi perubahan/penghapusan.
Saat ini repository masih **in-memory: data hilang setelah proses aplikasi ditutup
atau hot restart**. Penyimpanan Drift/SQLite masuk Phase 5.

Panduan struktur, batas validasi, kontrak delete, dan manual QA tersedia di
[`COFFEE_MANUAL_IMPLEMENTATION.md`](docs/COFFEE_MANUAL_IMPLEMENTATION.md).

## Konvensi

- File: `snake_case.dart`.
- Type: `UpperCamelCase`.
- Member/provider: `lowerCamelCase`.
- Gunakan suffix peran seperti `_repository`, `_controller`, `_screen`, dan
  `_provider`.
- Gunakan package import lintas module.
- Riverpod adalah satu-satunya dependency-injection mechanism.
