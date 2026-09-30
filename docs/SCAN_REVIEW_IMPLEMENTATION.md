# Phase 8 — Structured extraction dan editable confirmation

## Menggunakan fitur

Koleksi → Tambah kopi → Scan label kopi → kamera/galeri → **Periksa informasi
kopi**. Foto dan teks OCR asli ditampilkan bersama form yang terisi dari parser.
Semua field bisa dikoreksi atau dikosongkan. Field yang tidak ditemukan tidak
diisi dari pengetahuan umum. Nama kopi dan roastery wajib untuk Coffee permanen.

Perubahan langsung masuk antrean autosave SQLite. Status **Draft tersimpan di
perangkat** berarti write selesai; jangan menganggap write yang masih berjalan
sudah durable. Teks angka/tanggal yang belum lengkap tetap disimpan. Kembali
atau **Simpan draft & kembali** mempertahankan draft dan menunggu write terakhir.
Jika write gagal, isian tetap terlihat dan tersedia retry. **Hapus draft** meminta
konfirmasi dan menghapus teks, kandidat, serta foto sementara melalui cleanup queue.

Pengguna mencentang **Saya sudah memeriksa informasi kopi** lalu menekan
**Konfirmasi & simpan kopi**. Edit berikutnya membatalkan centang review.
Validasi required field, tanggal kalender, bilangan positif, rentang altitude,
roast level/custom, serta batas tags memakai validasi Coffee yang sama dengan
input manual. Foto dapat dikecualikan secara eksplisit, termasuk jika file hilang.

## Parser lokal

`CoffeeLabelParser` adalah pure Dart, terpisah dari ML Kit. Parser membaca alias
Indonesia/Inggris untuk nama coffee, roastery, negara asal, region/farm, producer,
process, varieties, roast level, tasting notes, altitude, roast date, dan weight.
Label dapat memakai pemisah `:`/`=` atau value terpisah. Bila koordinat OCR tersedia,
parser mencari value terdekat di kanan atau bawah dalam batas jarak, tanpa
melompati label lain. Tanpa koordinat, parser memakai baris berikutnya. Alias generik
seperti `Coffee` membutuhkan pemisah agar heading marketing tidak menjadi nama.

- Negara dan proses standalone dikenali dari vocabulary terbatas; negara standalone
  harus merupakan satu baris penuh agar alamat roastery tidak dianggap origin.
  `Origin: Guji, Ethiopia` dipisah menjadi region Guji dan negara Ethiopia.
  Beberapa negara yang dipisahkan delimiter tetap memerlukan review. Region tidak
  dipakai untuk menebak negara. Negara di luar vocabulary dapat diisi pengguna.
- Weight menerima gram atau kg dan mengubah kg ke gram integer.
- Altitude menerima angka/rentang dengan unit m, masl, atau mdpl.
- Tanggal ISO dan tanggal dengan nama bulan Indonesia/Inggris (misalnya
  `29 September 2026`) diterima. Tanggal numerik day-first dinormalisasi hanya ketika
  day > 12. Contoh `03/04/2026` tetap kosong dan perlu review.
- Berat ekuivalen seperti `0.25 kg` dan `250g` tidak dianggap konflik. List
  varietas/tasting notes dapat berlanjut ke baris berikutnya jika baris sebelumnya
  berakhir dengan delimiter; koordinat yang tersedia membatasi perpindahan kolom.
- Kandidat berbeda untuk field yang sama, unit/tanggal tidak valid, dan roast
  level tidak dikenal tidak dipaksakan ke form; teks OCR asli tetap dapat dilihat.
- Confidence berasal dari OCR baris kandidat pertama, bukan skor kebenaran
  semantic parser. Null berarti SDK tidak menyediakan nilai. Nilai < 0.85,
  null, atau ambigu ditandai needs review. Bahkan confidence tinggi tetap
  memerlukan konfirmasi pengguna.
- Parser tidak menebak nama product dari urutan heading. Label tanpa key yang
  jelas bisa memerlukan pengisian manual. Foto blur, teks dekoratif, campuran
  script, dan layout kompleks belum memiliki target akurasi produksi.

## Pengisian AI otomatis - 30 September 2026

AI berjalan otomatis saat review hasil scan baru dibuka, tanpa tombol Isi dengan AI
atau dialog tambahan. Layar scan menjelaskan bahwa teks dikirim ke OpenAI melalui
backend; foto tidak dikirim. Parser lokal tetap menjadi fallback dan input manual
tetap tersedia setelah pemrosesan selesai/gagal.

Hanya snapshot parser awal (revision 1) yang diproses otomatis. Controller menyimpan
revision berikutnya sebelum request untuk mencegah pengulangan saat draft dibuka
ulang, termasuk setelah gagal/batal. Draft yang pernah diedit dipertahankan.
Tidak ada retry otomatis; scan baru membuat kesempatan ekstraksi baru.

Hasil yang ditemukan mengganti field label terkait, termasuk kedua batas
altitude. Nilai null/list kosong tidak menghapus isian yang sudah ada. Tanggal
pembelian, catatan pribadi, dan pilihan foto dipertahankan. Hasil masuk antrean
autosave dan menghapus centang konfirmasi; Coffee permanen tetap membutuhkan
review dan konfirmasi pengguna. Per-field OCR hints dihapus agar form ringkas.

Timeout/error tidak mengubah isian. Tidak ada retry otomatis. Respons yang
terlambat setelah pembatalan, navigasi, disposal, atau edit baru diabaikan.
Pembatalan bersifat logis; request yang sudah diterima backend mungkin tetap
mengonsumsi kuota. Response JSON divalidasi sebelum dipetakan ke form.

### Menjalankan di HP Android lokal

1. Di `E:\My Career\daily_coffee_api`, jalankan `php artisan serve --host=127.0.0.1 --port=8000`.
2. Hubungkan HP dengan USB debugging aktif dan izinkan komputer ini.
3. Dari folder Flutter, jalankan `.\tool\connect_backend.ps1`.
   Jika perangkat lebih dari satu, tambahkan `-DeviceId <id>`.
4. Pasang APK debug terbaru atau jalankan `flutter run -d <id>`.
5. Scan label baru, tunggu pengisian otomatis, periksa altitude dan field lain,
   tunggu **Draft tersimpan di perangkat**, lalu konfirmasi simpan kopi.

APK debug memakai `http://127.0.0.1:8000/api/coffee-label/extract` via `adb reverse`.
Mode tanpa token hanya menerima loopback lokal, tidak perlu dibuka ke LAN. USB dan server harus
aktif. Jalankan ulang script setelah kabel/perangkat tersambung kembali.
Cleartext HTTP Android dibatasi ke localhost pada build debug saja.

`COFFEE_API_URL` adalah Dart define berisi URL endpoint penuh tanpa secret.
Build release tidak memiliki endpoint default. Koneksi tersimpan lewat Pengaturan
memiliki prioritas atas Dart define. API key OpenAI tetap di backend; token perangkat
dimasukkan saat runtime dan tidak ditanam dalam APK.

### Koneksi backend pribadi melalui HTTPS

Buka **Pengaturan > Koneksi AI**, masukkan alamat dasar HTTPS backend dan token
perangkat `dc_...`, kemudian tekan **Periksa & simpan**. Pemeriksaan memanggil
`GET /api/device/check` tanpa OCR/OpenAI. Setelah berhasil, buat scan baru.
Tidak perlu rebuild APK untuk mengganti alamat backend.

Endpoint dan token disimpan bersama dengan `flutter_secure_storage`; token tidak
ditampilkan kembali. Redirect HTTP tidak diikuti. Koneksi baru yang gagal diverifikasi
tidak mengganti koneksi lama. Kegagalan membaca penyimpanan aman tidak mengalihkan
request secara diam-diam ke server lain. Backup Android dinonaktifkan.

Backend mendukung satu token pribadi aktif dengan expiry dan hash SHA-256,
batas per token/global 10 request/menit dan 100 request/24 jam. Production memerlukan
HTTPS dan cache database/Redis; data kuota harus berada di penyimpanan persisten.
Menghapus koneksi pada HP tidak mencabut token server; rotasi hash di server mencabutnya.
Tanpa koneksi tersimpan, debug tetap memakai loopback USB seperti sebelumnya.

Petunjuk server dan pembuatan token ada di `E:\My Career\daily_coffee_api\DEVICE_ACCESS.md`.
Deployment publik dan pengujian lewat internet seluler masih belum dilakukan.

### Pengujian

Unit/widget/provider tests memakai fake HTTP/provider, tanpa biaya API.
`integration_test/flows/ai_connection_test.dart` memakai server QA pada loopback
HP dan key secure storage terisolasi untuk memverifikasi pengaturan, persistensi,
Bearer token, dan penghapusan tanpa OpenAI atau menyentuh koneksi pribadi.
Live integration test berikut memakai satu label sintetis, SQLite QA terpisah,
dan satu request berbayar. Pertahankan `--no-uninstall` agar data aplikasi lama
terjaga; setelahnya bangun/pasang APK normal kembali.

```powershell
flutter test integration_test/flows/ai_review_test.dart -d <id> --no-uninstall --dart-define=RUN_LIVE_AI_TEST=true
```

Test membuktikan pengisian otomatis melalui backend termasuk altitude, hasil tersimpan
dan dimuat kembali dari repository, serta tidak ada Coffee dibuat otomatis.
Ini belum menggantikan evaluasi akurasi pada kumpulan kemasan nyata.

## Domain dan persistence

`CoffeeDraft` memuat editable `CoffeeFormValues`, gambar, raw text/lines,
`ScanExtractedField`, pilihan menyertakan foto, dan revision. Kandidat menyimpan
raw/normalized value, confidence nullable, region, status review, dan source.
Source kandidat asli `ocr`; status edited/rejected menandakan keputusan user.
Field tambahan yang tidak berasal dari kandidat memiliki source `user`.

Schema **v3** menambah `review_json` nullable dan `review_revision` default 0
pada `coffee_drafts`. Snapshot v1/v2 dipertahankan dan migrasi v1→v3 maupun
v2→v3 diuji. `review_json` version 1 adalah source of truth untuk editable
snapshot yang boleh mengandung nilai parsial/invalid dan includePhoto. Kolom
draft bertipe numeric/date lama tidak dipakai sebagai editable source karena
tidak dapat mewakili input sementara seperti `2026-0` atau `25g`.

`scan_extracted_fields` menyimpan kandidat/provenance dalam child rows. Raw dan
normalized candidate tidak diubah saat user mengetik; review status diperbarui.
Confidence dikonversi ke basis points sesuai schema. Nilai akhir ada pada snapshot.
Pembukaan review pertama mem-parsing dan menyimpan snapshot/candidate dalam satu
transaksi. Pembukaan berikutnya tidak menjalankan parser ulang atau menimpa edit.
OCR retry/cancel tidak boleh mengganti raw text setelah review mulai; foto baru
membuat draft terpisah.

Autosave diserialisasi oleh controller. Setiap save memeriksa expected revision;
conflict tidak menimpa draft baru. Error menyisakan input di UI; flush/retry
menyimpan snapshot terbaru. Keluar dari halaman tidak membatalkan write yang
sudah diminta, tetapi kill OS sebelum commit tetap dapat kehilangan write in-flight.

## Promotion dan kegagalan

`DriftScanReviewRepository.promote` memuat snapshot tersimpan. Repository Coffee
menyiapkan file kandidat sebelum transaksi, lalu memeriksa id/type/status dan
review revision dalam transaksi yang membuat Coffee/tags/photo metadata,
menambahkan cleanup task, serta menghapus draft/candidate/raw OCR. Semua operasi
database ini commit atau rollback bersama. Permanent photo tidak boleh mereferensi
file yang belum selesai ditulis. Kandidat file dari transaksi gagal masuk cleanup;
draft dan staging asli tetap tersedia untuk retry.

Klik ganda diblokir controller; pengecekan draft/revisi pada transaksi juga
mencegah duplikasi lintas request. Penghapusan draft membuat promotion ulang
gagal tanpa membuat Coffee kedua. Extractor remote tersedia melalui backend; API key tidak berada di Flutter.

## Verifikasi

Host tests: parser bilingual, ambiguity/invalid values, confidence/bounds,
editable snapshot setelah reopen, user source, migration, stale revisions,
photo opt-out, rollback saat insert foto gagal, retry, duplicate save, queued
autosave saat disposal, serta widget validation dan explicit confirmation.

Integration Android memakai native ML Kit, UI/provider produksi, file dan SQLite
di direktori QA terisolasi. `seed` membaca gambar fixture dan menyimpan edit
termasuk tanggal parsial; `verify` membuka ulang proses, memulihkan edit,
memperbaiki tanggal, lalu menyimpan melalui UI dan memeriksa Coffee/foto/draft.

```powershell
flutter test integration_test/flows/scan_review_test.dart -d emulator-5554 --no-uninstall --dart-define=REVIEW_STAGE=seed
# force-stop aplikasi sebelum proses verify
flutter test integration_test/flows/scan_review_test.dart -d emulator-5554 --no-uninstall --dart-define=REVIEW_STAGE=verify
.\tool\quality_check.ps1
```

Hasil aktual dicatat di `progress.md`. Integrasi AI dengan label sintetis telah
lulus pada ponsel Android 16 melalui USB. TalkBack, iOS, dan akurasi pada kumpulan
label kopi nyata belum diverifikasi.
