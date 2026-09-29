# Phase 8 — Structured extraction dan editable confirmation

## Menggunakan fitur

Koleksi → Tambah kopi → Scan label kopi → kamera/galeri → **Periksa informasi
kopi**. Foto, teks OCR asli, dan kandidat informasi ditampilkan bersama form.
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
Label dapat memakai pemisah `:`/`=` atau value di baris berikutnya. Alias generik
seperti `Coffee` membutuhkan pemisah agar heading marketing tidak menjadi nama.

- Negara dan proses standalone dikenali dari vocabulary terbatas. Region tidak
  dipakai untuk menebak negara. Negara di luar vocabulary dapat diisi pengguna.
- Weight menerima gram atau kg dan mengubah kg ke gram integer.
- Altitude menerima angka/rentang dengan unit m, masl, atau mdpl.
- Tanggal ISO diterima; tanggal numerik day-first dinormalisasi hanya ketika
  day > 12. Contoh `03/04/2026` tetap kosong dan perlu review.
- Kandidat berbeda untuk field yang sama, unit/tanggal tidak valid, dan roast
  level tidak dikenal tidak dipaksakan ke form; raw candidate tetap terlihat.
- Confidence berasal dari OCR baris kandidat pertama, bukan skor kebenaran
  semantic parser. Null berarti SDK tidak menyediakan nilai. Nilai < 0.85,
  null, atau ambigu ditandai needs review. Bahkan confidence tinggi tetap
  memerlukan konfirmasi pengguna.
- Parser tidak menebak nama product dari urutan heading. Label tanpa key yang
  jelas bisa memerlukan pengisian manual. Foto blur, teks dekoratif, campuran
  script, dan layout kompleks belum memiliki target akurasi produksi.

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
gagal tanpa membuat Coffee kedua. Tidak ada OCR/extractor remote atau API key.

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

Hasil aktual dicatat di `progress.md`. Perangkat fisik, TalkBack, iOS, dan
akurasi pada kumpulan label kopi nyata belum diverifikasi.
