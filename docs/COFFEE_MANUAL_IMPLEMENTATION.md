# Coffee MVP manual — Phase 4

Urutan fase mengacu pada `progress.md`. Implementasi ini menyelesaikan alur manual
melalui repository in-memory. Data hanya hidup dalam sesi aplikasi; menutup proses
atau hot restart mengosongkan koleksi. Persistence Drift/SQLite tetap Phase 5.

## Struktur dan kontrak

- `features/coffee/domain`: entity `Coffee`, UUID `CoffeeId`, date-only `CoffeeDate`,
  typed `CoffeeDetails`, `CoffeeVariety`, `CoffeeTastingNote`, `CoffeePhoto`, snapshot
  editable `CoffeeFormValues`, validasi, dan `CoffeeRepository`.
- `features/coffee/data/in_memory_coffee_repository.dart`: source of truth sesi,
  stream collection/detail, create/update/favorite/delete, dan fake relational links
  untuk menguji dampak penghapusan terhadap jurnal.
- `app/composition/coffee_providers.dart`: provider repository keep-alive dengan
  clock/ID injectable; provider ini menjadi titik penggantian adapter pada Phase 5.
- `features/coffee/application`: generated Riverpod query providers, form controller,
  serta action controller untuk favorite/inspect-delete/delete. Provider layar
  auto-dispose; widget tidak mengakses repository concrete atau filesystem.
- `features/coffee/presentation`: collection, detail, shared add/edit form, label
  aman untuk kegagalan, dan input tag. Seluruh styling mengikuti design system.

Query stream mengirim `Result<T>`; write mengembalikan `Future<Result<T>>`.
Kegagalan tak terduga pada boundary controller tidak ditampilkan sebagai raw error.
Collection menampilkan skeleton saat initial loading, empty state, retry saat gagal,
dan grid yang mempertahankan snapshot sukses terakhir jika refresh gagal.
Grid dibangun per baris secara lazy; tinggi mengikuti konten dan text scale.

## Form dan integritas

- Nama dan roastery wajib. Semua field lain opsional: negara, region, produsen,
  process kustom, roast level, varietas, tasting notes, rentang ketinggian, dua tanggal,
  berat awal kemasan, serta catatan pribadi.
- `Detail lainnya` menyediakan progressive disclosure. Error pada field tersembunyi
  membuka section dan membawa fokus ke field bermasalah.
- Tasting notes/varietas adalah child values terpisah, bukan CSV. Nilai yang masih
  diketik di input tag ikut disimpan saat submit; duplikat mempertahankan display
  value pertama. Menghapus lalu menambahkan kembali memungkinkan perubahan tag.
- `CoffeeFormValues` boleh belum valid. Validasi dijalankan oleh controller dan
  kembali di repository sebelum write. Draft autosave/recovery belum diimplementasikan.
- Dirty state membandingkan snapshot awal, termasuk pending tag. Back meminta
  `Tetap mengedit` atau `Buang`; tidak ada opsi simpan draft palsu.
- Submit ganda ditolak; field tidak dapat diubah selama submit. Gagal menyimpan
  mempertahankan nilai, sukses create membuka detail, sukses edit kembali ke detail.
- Edit menolak snapshot basi agar tidak menimpa perubahan lain. Favorite, child ID,
  createdAt, dan metadata foto tetap dipertahankan. Provenance negara/ketinggian
  hanya dibuang jika source field terkait berubah.
- System timestamps UTC, date-only disimpan sebagai tahun/bulan/hari tanpa konversi
  UTC. Integer gram/meter tidak memakai floating point. Jam mundur tidak membuat
  updatedAt lebih awal daripada updatedAt sebelumnya.

## Batas validasi Phase 4

| Nilai | Aturan |
|---|---|
| Teks singkat | Maksimal 200 UTF-16 code units setelah trim |
| Catatan pribadi | Maksimal 5000 UTF-16 code units setelah trim |
| Tag | 1–80 UTF-16 code units setelah trim, maksimal 30 per kelompok |
| Berat/altitude | Integer positif maksimal 2147483647; kosong berarti null |
| Altitude range | Maksimum ≥ minimum jika keduanya terisi |
| Tanggal | Tanggal kalender valid, disimpan sebagai date-only |
| Roast level | Key baku atau `other` dengan custom non-empty |
| Optional text | Whitespace-only menjadi null |

Limit ini membatasi input tidak sengaja, bukan menebak rentang agronomis. Tidak
ditambahkan aturan tanggal masa depan yang belum disepakati. Country code tidak
ditebak dari nama negara. Normalisasi memakai NFC + whitespace collapse + lowercase
melalui [unorm_dart](https://pub.dev/packages/unorm_dart); diakritik display dipertahankan.
Dependency ini pure Dart dan tidak mengakses network saat runtime.

## Favorite dan delete

Tracker Phase 4 secara eksplisit meminta favorite. Karena itu `isFavorite` ditambahkan
sebagai boolean default false pada Coffee, tanpa pinned ordering atau filter
discovery. Favorite dapat diubah dari detail dan ditandai pada kartu koleksi.

`inspectDeleteImpact` menghasilkan coffee ID, jumlah jurnal/foto, dan revision.
Dialog menyebut jumlah serta sifat irreversible. `delete(confirmedImpact)` memeriksa
ulang revision/dampak; perubahan setelah konfirmasi menghasilkan conflict dan
memerlukan inspeksi/konfirmasi baru. Penghapusan tanpa konfirmasi bukan alur UI.

Adapter in-memory menghapus aggregate (variety/tasting/photo metadata) beserta
fake journal links secara sinkron sebagai satu commit. **Ini belum merupakan
implementasi JournalRepository, file cleanup, atau database cascade.** Test fixture
menguji kontrak relasi tanpa mengklaim fitur jurnal sudah dibuat. Phase 5 harus
menerapkan transaksi, FK, dan revision/impact recheck secara atomik; Phase 6 menangani
file cleanup setelah commit; Phase 9 mengimplementasikan journal entries sebenarnya.

## Batas fase berikutnya

- Tidak ada seed/dummy coffee pada aplikasi utama; fixture hanya dipakai test.
- Foto pada kartu/detail menggunakan fallback. Akuisisi foto belum aktif; add sheet
  saat ini menawarkan manual. Route kamera/scan menyediakan jalan ke form manual.
- Search/filter lengkap tetap Phase 10; entry pencarian di koleksi belum ditampilkan.
- CTA jurnal masih membuka route placeholder Phase 2 dengan coffee ID terpilih.
- Pilihan tema tersimpan, TalkBack perangkat fisik, dan release hardening tetap
  memiliki checklist tersendiri; widget test bukan bukti QA di HP fisik.

## Verifikasi dan manual QA

```powershell
.\tool\quality_check.ps1
flutter run
```

1. Koleksi → Tambah kopi → Isi manual; coba submit tanpa nama/roastery.
2. Isi nama, roastery, dan satu tasting note; Simpan kopi harus membuka detail.
3. Tambahkan favorite, kembali ke koleksi, dan buka lagi kartu yang sama.
4. Edit informasi serta bagian Detail lainnya; periksa tanggal, berat, dan custom values.
5. Ubah field lalu Back: `Tetap mengedit` mempertahankan input, `Buang` membatalkan.
6. Hapus kopi: periksa dialog dampak, coba Batal, lalu konfirmasi penghapusan.
7. Ulangi dengan dark mode, font 200%, keyboard terbuka, dan landscape.
8. Hot restart akan mengosongkan data pada adapter Phase 4; persistensi diverifikasi
   setelah adapter Drift selesai pada Phase 5.

Test domain/repository/controller mencakup normalisasi, validation boundary, tanggal,
metadata foto, child identity, stale updates/deletes, nullable data, dan duplicate
submit. Widget tests menjalankan CRUD/favorite/delete, validation/retry, retained
cache, loading/error/not-found, unsaved changes, dan compact 200% dengan keyboard.
Snapshot visual ada di `test/golden/baselines/coffee_*.png`.

Hasil verifikasi 28 September 2026: quality gate lengkap lulus, analyzer tanpa issue,
56 test lulus (5 golden), dan APK debug berhasil dibangun. Snapshot collection,
detail, serta form sudah diperiksa. `flutter devices` tidak menunjukkan perangkat
Android terhubung; QA fisik belum dilakukan.
