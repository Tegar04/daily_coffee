# Phase 7 — OCR scanning

## Alur penggunaan

Koleksi → Tambah kopi → **Scan label kopi** → kamera/galeri → normalisasi
foto → OCR lokal → teks mentah tersimpan sebagai draft. Daftar **Draft scan
tersimpan** pada layar yang sama membuka kembali hasil setelah restart.
Draft yang belum selesai dapat dibaca ulang, dihapus dengan konfirmasi, atau
ditinggalkan sambil menggunakan **Isi manual**. Draft tidak membuat Coffee.

Phase 8 melanjutkan semantic extraction, field editable, review, dan promotion.
Phase 7 belum mengisi otomatis nama kopi, roastery, origin, dan field lainnya.

## Adapter dan kontrak

- `google_mlkit_text_recognition` 0.17.1 di `features/scan/data/` membungkus
  native ML Kit. Plugin komunitas ini bukan plugin resmi Google.
- Android memakai dependency bundled `com.google.mlkit:text-recognition:16.0.1`;
  model Latin tersedia bersama APK. Tidak ada upload foto, API key, atau OCR
  remote. Latin mencakup label Indonesia/Inggris; script lain belum diaktifkan.
- Domain `LabelTextRecognizer`, `RecognizedLabelText`, dan `RecognizedLine`
  tidak memuat tipe SDK. Confidence per baris disimpan nullable sesuai hasil
  adapter, bersama bounds dalam pixel gambar yang sudah dinormalisasi. Confidence
  tidak dirata-rata menjadi confidence field, dan nilai yang tidak tersedia
  tidak diganti angka buatan.
- Setiap native request memiliki recognizer yang ditutup di `finally`.
  Adapter mencegah request native tumpang tindih. Cancel/timeout bersifat logis:
  SDK yang sedang bekerja tetap menyelesaikan pekerjaannya lalu ditutup;
  hasil terlambat diabaikan. Retry saat native request lama belum selesai
  menghasilkan kegagalan yang bisa dicoba lagi, tanpa membuat recognizer baru.
- Android adalah target verifikasi. Minimum iOS diselaraskan ke 15.5 sesuai
  dependency; build iOS belum diverifikasi pada Windows.

Referensi: [ML Kit Android](https://developers.google.com/ml-kit/vision/text-recognition/v2/android)
dan [adapter Flutter](https://pub.dev/packages/google_mlkit_text_recognition).

## Gambar, state, dan persistence

Normalisasi memakai pipeline Phase 6: JPEG/PNG/WebP static, validasi batas
25 MiB/40 MP, EXIF orientation, resize maksimal 2400 px, JPEG quality 90,
processing isolate, serta thumbnail 480 px. Original resolusi penuh tidak
ditambahkan. Foto kecil, blur berat, glare, font dekoratif, dan tata letak rumit
tetap dapat menghasilkan OCR salah/kosong; hasil memerlukan review pengguna.

Controller Riverpod memiliki `idle`, `acquiring`, `processing`, `success`,
`failure`, `cancelled`. Timeout recognition 30 detik. Operation ID mencegah
hasil lama mengubah UI setelah cancel, navigasi keluar, atau retry.

Migrasi **v1 → v2** menambahkan tiga kolom pada `coffee_drafts`:

| Kolom | Isi |
|---|---|
| `ocr_raw_text` | Teks mentah nullable |
| `ocr_lines_json` | Baris, bounds, confidence dalam kontrak netral provider |
| `scan_revision` | Revisi operasi, default 0 |

Update hasil memakai kondisi id/revisi/status processing. Cancel menaikkan
revisi dan membersihkan hasil; completion lama tidak bisa mengubahnya.
Berhasil → `review_required`; gagal → `failed_recoverable`; cancel →
`image_ready`. Proses yang terhenti ditampilkan sebagai draft untuk retry
eksplisit; tidak otomatis menjalankan OCR saat startup.

Acquisition membuat `scan_create` sejak sebelum native picker dibuka. Native
lost result tetap terasosiasi dengan id draft yang tepat, tetapi draft scan
tidak masuk recovery formulir foto manual. Penghapusan draft menggunakan
cleanup queue Phase 6; teks ikut terhapus bersama row draft. Raw OCR tidak
dimasukkan ke log, preference, atau export. Retensi pascapromotion ditangani
Phase 8. Draft tersimpan sampai pengguna menghapusnya; belum ada auto-expiry UI.

## Verifikasi

Host tests meliputi persistence raw text/confidence setelah reopen, nullable
confidence, migrasi v1 beserta Coffee/draft lama, cancel/late completion,
timeout, retry, double submit, isolasi photo recovery, dan fallback manual.
Fixture `test/fixtures/coffee_label_images.dart` menghasilkan label sintetis
milik proyek: satu kolom, dua kolom, resize + blur ringan + JPEG quality 45,
serta gambar kosong. Tidak memakai foto pelanggan atau artwork pihak lain.

Native integration menggunakan adapter ML Kit asli, filesystem dan SQLite
di direktori QA terisolasi. `seed` menyimpan tiga hasil, `verify` membukanya
di proses aplikasi baru dan membersihkan data QA. Jalankan dengan jaringan
perangkat dimatikan dan pulihkan pengaturan jaringan setelah pengujian:

```powershell
flutter test integration_test/flows/ocr_scanning_test.dart -d emulator-5554 --no-uninstall --dart-define=OCR_STAGE=seed
# force-stop aplikasi sebelum proses verifikasi berikutnya
flutter test integration_test/flows/ocr_scanning_test.dart -d emulator-5554 --no-uninstall --dart-define=OCR_STAGE=verify
.\tool\quality_check.ps1
```

Status hasil aktual dicatat di `progress.md`. Akurasi pada label fisik,
TalkBack, low-storage nyata, dan variasi OEM tetap memerlukan QA perangkat.
