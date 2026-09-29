# Phase 6 — Image Handling

## Cakupan

Satu cover opsional per coffee: kamera/galeri → preview → konfirmasi → simpan
bersama coffee. Add/Edit mendukung ambil ulang, pilih ulang, dan hapus foto.
Collection memakai thumbnail; detail memakai cover. Semua bekerja lokal.
OCR, structured extraction, dan promotion hasil OCR tetap Phase 7–8.

## Keputusan implementasi

- `image_picker` 1.2.3 menyediakan **kamera sistem** dan galeri. Kamera sistem
  menggantikan rencana preview kamera custom dengan package `camera`; custom
  framing/live camera tidak diperlukan untuk still-photo MVP ini. Adapter tetap
  dapat diganti melalui `PhotoPickerGateway`.
- Android Photo Picker diaktifkan melalui `image_picker_android`, termasuk
  opsi backport bila tersedia. Fallback pemilihan sistem mengikuti plugin.
- Tidak menambahkan permission storage luas, mikrofon, atau kamera langsung di
  manifest Android. Kamera didelegasikan ke aplikasi kamera sistem; akses dimulai
  setelah pengguna menekan tombol. Error izin tetap dipetakan ke typed failure.
  iOS usage descriptions disediakan, tetapi QA target fase ini adalah Android.
- `image` 4.10.1 memproses di isolate. Input statis JPEG/PNG/WebP berdasarkan isi
  file, maksimum **25 MiB / 40 megapiksel**, diperiksa sebelum full decode.
- Orientasi EXIF dinormalisasi. EXIF dihapus dari derivative yang disimpan.
- Cover: JPEG quality **90**, sisi terpanjang maksimal **2400 px**, tanpa upscale.
  Thumbnail: JPEG quality **80**, sisi terpanjang maksimal **480 px**.
- Tidak menyimpan duplikat original permanen. Foto sumber pengguna tidak dihapus;
  aplikasi mempertahankan cover terolah dan thumbnail. Nilai kualitas ini adalah
  baseline Phase 6, bukan klaim akurasi OCR. Evaluasi label nyata pada Phase 7
  sebelum mengubah kualitas untuk kebutuhan OCR.
- Crop/rotate manual ditunda karena opsional. Preview menggunakan `contain` agar
  seluruh kemasan terlihat; orientasi otomatis tetap diimplementasikan.
- Schema tetap **v1**. Metadata yang ada mencukupi. Thumbnail memiliki path turunan
  `<localPath>.thumb.jpg`, dapat diregenerasi jika hilang; tidak menjadi source of
  truth tambahan pada database.

Referensi plugin: [image_picker](https://pub.dev/packages/image_picker),
[image_picker_android](https://pub.dev/packages/image_picker_android),
[image](https://pub.dev/packages/image).

## Struktur

- `core/images/`: image DTO, validation/normalization, managed storage, maintenance.
- `features/capture/domain/`: picker contract dan recovery result.
- `features/capture/data/`: system adapter dan coordinator draft/file acquisition.
- `features/capture/application/`: lossless form checkpoint serialization.
- `features/capture/presentation/`: photo editor dan preview konfirmasi.
- `app/composition/image_providers.dart`: injection, startup maintenance, recovery,
  dan resolusi `ImageProvider`. Widget tidak membaca filesystem/plugin langsung.
- `CoffeePhotoEdit`: explicit replace/remove plus expected cover ID. Null mutation
  mempertahankan foto lama. `DriftCoffeeRepository` mengoordinasikan save atomik.

## Managed storage dan transaksi

Semua path database relatif terhadap application-support directory:

```text
photos/<coffee-id>/<photo-id>.jpg
photos/<coffee-id>/<photo-id>.jpg.thumb.jpg
drafts/<operation-id>/cover.jpg
drafts/<operation-id>/cover.jpg.thumb.jpg
drafts/<operation-id>/context.json
drafts/<operation-id>/image.json
maintenance/pending-picker.json
```

Draft image sengaja berada pada app-support, bukan OS cache, agar recovery tidak
bergantung pada cache eviction. UUID menjadi nama file; path traversal dan path
absolut ditolak. Image bytes tidak dimasukkan ke SQLite/log.

Sebelum native picker dibuka, `CoffeeDrafts` mencatat kepemilikan session dan
temporary reference. Sidecar `context.json` menyimpan checkpoint form termasuk
teks yang belum valid, tags, baseline edit, dan expected photo ID. Sidecar bersifat
temporary recovery payload; permanent coffee tetap bersumber dari Drift.

Save menyiapkan cover + thumbnail permanen terlebih dahulu. Transaksi kemudian
menulis coffee/tags, memeriksa expected cover, mengganti photo metadata, mengantrekan
file lama/temporary, dan menghapus draft yang telah digunakan. Hanya setelah commit
cleanup berjalan. Kegagalan sebelum commit mempertahankan foto lama dan staging
untuk retry; kandidat permanen gagal masuk antrean cleanup.

Penghapusan coffee memakai antrean Phase 5 dan kini benar-benar mengeksekusi file
cleanup. Setiap task memeriksa referensi photo/draft dalam transaksi sebelum delete.
Kegagalan filesystem tidak membatalkan data yang sudah committed; task tetap ada
untuk retry saat startup/save/delete berikutnya.

Startup sweep membersihkan file tanpa referensi yang berumur >24 jam, termasuk
artefak crash yang belum sempat masuk antrean. Referensi database selalu diperiksa;
umur file saja tidak cukup. Maintenance selesai sebelum service acquisition
diekspos. Folder kosong tidak dihapus secara rekursif.

## Recovery dan error

- Cancel picker adalah hasil normal; tidak menghasilkan coffee atau error UI.
- `retrieveLostData()` diperiksa saat collection mulai memuat recovery service.
- Hanya pending operation ID yang tepat yang boleh menerima lost result. Hasil
  tanpa pasangan draft tidak pernah ditebak atau otomatis disimpan ke coffee.
- Foto yang sudah diolah tetapi belum disimpan ditawarkan melalui tombol restore
  pada Collection dan form yang sesuai. Pengguna melihat preview dan memilih
  `Gunakan foto` sebelum checkpoint/foto diterapkan kembali.
- Checkpoint dibuat sebelum picker, bukan autosave setiap pengetikan. Perubahan
  setelah checkpoint dapat hilang saat proses dihentikan; autosave draft lengkap
  mengikuti Phase 8. Tidak ada automatic OCR/promotion pada Phase 6.
- Input invalid, permission denial, format rusak, atau storage failure menampilkan
  pesan aman. Input manual tetap tersedia. File cover yang hilang/rusak memakai
  fallback; thumbnail hilang dapat diregenerasi dari cover.

## Verifikasi

Automated coverage meliputi normalization/EXIF, batas ukuran, preview confirmation,
cancel/denial, round-trip disk SQLite dan file, replace/remove, stale-cover conflict,
rollback, file hilang, retry cleanup, orphan/reference safety, dan lost-result
association. Golden form diperbarui setelah pemeriksaan visual.

Jalankan quality gate:

```powershell
.\tool\quality_check.ps1
git diff --check
```

Pengujian Android menggunakan UI dan production Drift/filesystem dengan adapter
acquisition fixture deterministik. Jalankan tahap berikut secara terpisah, gunakan
force-stop antartahap, dan jangan uninstall/clear data:

```powershell
flutter test integration_test/flows/image_handling_test.dart -d emulator-5554 --no-uninstall --dart-define=IMAGE_STAGE=seed
flutter test integration_test/flows/image_handling_test.dart -d emulator-5554 --no-uninstall --dart-define=IMAGE_STAGE=verify
flutter test integration_test/flows/image_handling_test.dart -d emulator-5554 --no-uninstall --dart-define=IMAGE_STAGE=deleted
```

Seed menambah foto lewat form; verify memeriksa restart, mengganti lewat jalur
kamera, dan menghapus; deleted memeriksa hasil penghapusan setelah restart lagi.
Fixture adapter tidak membuktikan UI kamera/Photo Picker native; QA native dicatat
terpisah di `progress.md`.

## Hasil sesi 29 September 2026

- Quality gate penuh lulus: generation, format, analyzer tanpa issue, **90 test**
  (5 golden), debug APK, dan `git diff --check`.
- Integration Android `seed`, `verify`, `deleted` lulus dengan force-stop antartahap.
- QA native Pixel 7: camera capture ke preview; cancel preview; Android Photo
  Picker memilih label; force-stop pada preview; recover foto serta checkpoint
  nama/roastery; save; restart menampilkan thumbnail; delete membersihkan cover,
  thumbnail, dan sidecar. Screenshot lokal tersedia di `build/phase6-qa/` (ignored).
- Hard kill proses ketika system picker masih terbuka tidak menghasilkan lost
  result dari Android pada percobaan ini. Aplikasi kembali ke manual dengan aman
  tanpa membuat coffee. Exact association ketika plugin mengembalikan lost result
  diuji melalui adapter test; tidak diklaim sebagai recovery native yang terbukti
  untuk seluruh mode Activity destruction/OEM.
- Golden form dan screenshot native diperiksa visual. Input JPEG dengan SOF
  berukuran ekstrem ditolak sebelum `image` menyiapkan buffer komponen JPEG.
- Jalankan quality script langsung pada Windows PowerShell. Redirect gabungan
  `*>` dapat memperlakukan warning Java pada stderr sebagai `NativeCommandError`;
  verifikasi akhir dilakukan tanpa redirect dan exit code 0.

## QA perangkat fisik lanjutan

1. Tambah dari kamera dan galeri, batal/pilih ulang, lalu simpan.
2. Force-stop dan buka lagi; periksa cover serta thumbnail.
3. Ubah foto, hapus foto, hapus coffee; periksa tidak ada file yang masih dipakai
   ikut terhapus.
4. Uji izin kamera ditolak/permanen, low storage, file rusak/hilang, serta Activity
   destruction ketika picker terbuka. Form manual harus tetap dapat digunakan.
5. Periksa label foto asli yang kecil/gelap, orientation, text scale besar, TalkBack,
   dan responsivitas pada perangkat dengan RAM rendah.

Validasi hardware kamera fisik, TalkBack, low-storage perangkat nyata, dan seluruh
variasi OEM tetap bagian QA perangkat/release; tidak disamakan dengan unit test.
