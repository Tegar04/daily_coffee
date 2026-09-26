# Daily Coffee — UI Screens Specification

> **Status:** Spesifikasi layar dan alur pengguna  
> **Platform utama:** Flutter untuk Android  
> **Produk:** Jurnal specialty coffee dan perpustakaan kopi pribadi  
> **Design source of truth:** [`DESIGN_SYSTEM.md`](./DESIGN_SYSTEM.md)  
> **Scope:** MVP yang dapat berkembang tanpa mengubah fondasi navigasi

Dokumen ini menjelaskan struktur informasi, navigasi, alur, isi, perilaku, state, dan acceptance criteria setiap layar Daily Coffee. Dokumen ditujukan untuk product owner, designer, developer, dan AI coding assistant.

Semua keputusan visual—warna, type scale, spacing, radius, elevation, iconography, motion, dan reusable component—wajib mengikuti `DESIGN_SYSTEM.md`. Dokumen ini tidak membuat design token baru.

---

## 1. Product Experience

Daily Coffee membantu pengguna:

1. Menyimpan kopi yang dibeli sebagai koleksi pribadi.
2. Mengambil foto kemasan dan mengekstrak informasi kopi secara otomatis.
3. Menambahkan atau memperbaiki informasi secara manual.
4. Melihat kembali asal, roastery, process, varietas, roast level, dan tasting notes kopi.
5. Menulis pengalaman seduh sebagai journal entry yang terhubung ke sebuah kopi.
6. Menemukan kopi atau catatan lama dengan search, filter, dan sort.

Pengalaman aplikasi harus terasa seperti membuka arsip pribadi yang dikurasi. Konten kopi dan catatan pengguna lebih penting daripada angka statistik atau dekorasi.

### Bukan bagian dari produk

Daily Coffee bukan aplikasi pemesanan atau marketplace. Jangan menambahkan:

- Keranjang, checkout, atau payment.
- Harga sebagai hierarki utama.
- Banner promo, diskon, kupon, atau loyalty points.
- Menu minuman café.
- Rating publik, komentar sosial, atau feed komunitas.
- CTA “Beli sekarang” tanpa perubahan scope produk yang eksplisit.

---

## 2. MVP Scope and Assumptions

### Termasuk dalam MVP

- Onboarding singkat untuk first launch.
- Koleksi kopi dalam grid/list adaptif.
- Tambah kopi melalui kamera, galeri, atau input manual.
- Pemrosesan foto/OCR dan layar review hasil.
- Simpan, lihat, edit, dan hapus kopi.
- Cari, filter, dan urutkan koleksi.
- Jurnal seduh yang terhubung ke kopi.
- Simpan, lihat, edit, dan hapus journal entry.
- Theme mengikuti sistem dengan pilihan light/dark/system.
- Penanganan offline, loading, empty, dan error yang jelas.

### Tidak wajib untuk MVP

- Account dan sinkronisasi cloud.
- Social sharing yang kompleks.
- Statistik lanjutan dan rekomendasi berbasis AI.
- Brew timer.
- Inventory gram yang berkurang otomatis.
- Multi-photo gallery untuk satu kopi.

Fitur di luar MVP tidak boleh diasumsikan tersedia oleh UI. Jika backend belum ditentukan, UI harus dapat bekerja dengan local-first data model.

---

## 3. Information Architecture

```text
Daily Coffee
├── First Launch
│   ├── Splash / App Initialization
│   └── Onboarding
│
├── Koleksi
│   ├── Coffee Library
│   ├── Search and Filter
│   ├── Add Coffee Method
│   ├── Capture / Select Photo
│   ├── Scan Processing
│   ├── Review Scan Result
│   ├── Add Coffee Manually
│   ├── Coffee Detail
│   └── Edit Coffee
│
├── Jurnal
│   ├── Journal List
│   ├── Add Journal Entry
│   ├── Journal Entry Detail
│   └── Edit Journal Entry
│
└── Pengaturan
    ├── Appearance
    ├── Data and Storage
    ├── About
    └── Licenses
```

---

## 4. Primary Navigation

Gunakan bottom navigation dengan tiga destinasi tingkat atas:

| Destinasi | Label | Icon default | Icon selected | Tujuan |
|---|---|---|---|---|
| Koleksi | `Koleksi` | `local_cafe_outlined` | `local_cafe` | Perpustakaan kopi pengguna |
| Jurnal | `Jurnal` | `menu_book_outlined` | `menu_book` | Riwayat pengalaman seduh |
| Pengaturan | `Pengaturan` | `settings_outlined` | `settings` | Preferensi aplikasi dan data |

Aturan navigasi:

- Label selalu terlihat; jangan menggunakan icon-only navigation.
- Posisi tab dan scroll dipertahankan ketika berpindah destinasi.
- Menekan kembali dari child screen kembali ke parent terakhir.
- Menekan back pada root destination mengikuti perilaku Android.
- Deep link ke detail harus dapat kembali ke destinasi induk yang benar.
- Primary add action pada Koleksi boleh menggunakan `DailyFloatingActionButton` berlabel/tooltip “Tambah kopi”.
- Pada Jurnal, aksi “Tambah catatan” muncul sebagai FAB jika sudah ada kopi. Jangan tampilkan dua FAB sekaligus.
- Bottom navigation tidak muncul pada full-screen camera, processing, form, atau detail yang memerlukan fokus.

---

## 5. Shared Content Model

Spesifikasi UI berikut menggunakan model konseptual ini. Nama field implementasi dapat menyesuaikan domain layer, tetapi maknanya harus dipertahankan.

### 5.1 Coffee

| Field | Wajib | Input/format | Catatan UI |
|---|---|---|---|
| `id` | Ya | Generated | Tidak ditampilkan sebagai data pengguna |
| `name` | Ya | Text | Nama kopi/lot; fallback yang jelas bila OCR tidak menemukannya |
| `roastery` | Ya | Text | Nama roastery |
| `originCountry` | Tidak | Select/text | Negara asal |
| `region` | Tidak | Text | Wilayah, farm, estate, atau washing station |
| `producer` | Tidak | Text | Petani/produsen/cooperative |
| `process` | Tidak | Select + custom | Washed, Natural, Honey, Anaerobic, dan lain-lain |
| `varieties` | Tidak | Multi-value | Satu atau lebih varietas |
| `roastLevel` | Tidak | Select | Light, medium-light, medium, medium-dark, dark |
| `tastingNotes` | Tidak | Multi-value | Chip/tag; pengguna dapat menambah nilai custom |
| `altitude` | Tidak | Text terstruktur | Simpan nilai/unit bila tersedia; jangan memaksa angka tunggal |
| `roastDate` | Tidak | Date | Tanggal roasting, jika diketahui |
| `purchaseDate` | Tidak | Date | Tanggal pembelian |
| `weightGrams` | Tidak | Number | Berat awal kemasan dalam gram |
| `personalNote` | Tidak | Multiline text | Catatan umum tentang kopi |
| `imagePath` | Tidak | Local/remote URI | Foto kemasan utama |
| `createdAt` | Ya | Generated | Untuk sort “Baru ditambahkan” |
| `updatedAt` | Ya | Generated | Tidak perlu selalu ditampilkan |

Ketentuan minimum untuk menyimpan kopi: `name` dan `roastery`. Jika salah satunya tidak terbaca, pengguna wajib melengkapinya pada layar review/manual.

### 5.2 Journal Entry

| Field | Wajib | Input/format | Catatan UI |
|---|---|---|---|
| `id` | Ya | Generated | Internal |
| `coffeeId` | Ya | Coffee picker | Menghubungkan catatan dengan satu kopi |
| `brewedAt` | Ya | Date and time | Default waktu saat ini, dapat diedit |
| `brewMethod` | Ya | Select + custom | V60, AeroPress, French Press, Espresso, dan lain-lain |
| `doseGrams` | Tidak | Decimal | Kopi dalam gram |
| `waterGrams` | Tidak | Decimal | Air dalam gram |
| `waterTemperatureC` | Tidak | Decimal | Celsius di UI MVP |
| `grindSize` | Tidak | Text/select | Deskriptif atau nilai grinder |
| `brewTimeSeconds` | Tidak | Duration | Ditampilkan sebagai `mm:ss` |
| `rating` | Tidak | 1–5 | Penilaian pribadi, bukan rating publik |
| `tastingNotes` | Tidak | Multi-value | Apa yang benar-benar dirasakan pengguna |
| `note` | Tidak | Multiline text | Observasi seduh |
| `createdAt` | Ya | Generated | Internal/sort |
| `updatedAt` | Ya | Generated | Internal |

Ketentuan minimum untuk menyimpan journal entry: `coffeeId`, `brewedAt`, dan `brewMethod`.

---

## 6. Route and Screen Registry

Route names bersifat panduan. Implementasi router boleh menyesuaikan library yang dipilih, tetapi hubungan parent-child dan argument harus konsisten.

| ID | Screen | Suggested route | Presentation |
|---|---|---|---|
| `S01` | Splash / Initialization | `/` | Full screen |
| `S02` | Onboarding | `/onboarding` | Full screen |
| `S03` | Coffee Library | `/library` | Root destination |
| `S04` | Search and Filter | `/library/search` | Full screen + filter sheet |
| `S05` | Add Coffee Method | — | Modal bottom sheet |
| `S06` | Camera / Photo Selection | `/coffee/capture` | Full screen/system picker |
| `S07` | Scan Processing | `/coffee/scan` | Full screen |
| `S08` | Review Scan Result | `/coffee/review` | Full screen form |
| `S09` | Add Coffee Manually | `/coffee/new` | Full screen form |
| `S10` | Coffee Detail | `/coffee/:coffeeId` | Full screen detail |
| `S11` | Edit Coffee | `/coffee/:coffeeId/edit` | Full screen form |
| `S12` | Journal List | `/journal` | Root destination |
| `S13` | Add Journal Entry | `/journal/new` | Full screen form |
| `S14` | Journal Entry Detail | `/journal/:entryId` | Full screen detail |
| `S15` | Edit Journal Entry | `/journal/:entryId/edit` | Full screen form |
| `S16` | Settings | `/settings` | Root destination |
| `S17` | Data and Storage | `/settings/data` | Full screen settings |
| `S18` | About | `/settings/about` | Full screen settings |

---

## 7. Core User Flows

### 7.1 First launch

```text
App opened
→ Splash / initialize local data
→ First launch?
  ├── Yes → Onboarding → Coffee Library empty state
  └── No  → Last active root destination or Coffee Library
```

### 7.2 Add coffee from photo

```text
Coffee Library
→ Tap “Tambah kopi”
→ Add Coffee Method sheet
→ Camera or Gallery
→ Confirm usable photo
→ Scan Processing
→ Review Scan Result
→ Fix required/uncertain fields
→ Save
→ Coffee Detail + success feedback
```

### 7.3 Add coffee manually

```text
Coffee Library
→ Tap “Tambah kopi”
→ Add Coffee Method sheet
→ “Isi secara manual”
→ Add Coffee Manually
→ Save
→ Coffee Detail + success feedback
```

### 7.4 Add journal entry

```text
Coffee Detail or Journal List
→ Tap “Tambah catatan”
→ Add Journal Entry
→ Select coffee if not preselected
→ Complete brew information
→ Save
→ Journal Entry Detail + success feedback
```

### 7.5 Edit or delete

```text
Detail
→ Overflow menu
  ├── Edit → Form prefilled → Save → Detail
  └── Delete → Confirmation → Delete → Parent list + undo when safe
```

---

## 8. Screen Specifications

## S01 — Splash / App Initialization

### Purpose

Memberi transisi singkat saat aplikasi memuat preferensi, database lokal, theme, dan status onboarding.

### Layout

- Full-screen `color.background`.
- Wordmark/icon Daily Coffee sederhana di tengah.
- Progress indicator hanya tampil jika initialization melewati ±400 ms.
- Tidak ada ilustrasi café, promo, atau tombol.

### Behavior

- Jangan menggunakan artificial delay.
- Setelah berhasil, arahkan ke onboarding pada first launch atau root destination.
- Jika initialization dapat dipulihkan, tampilkan error state ringkas dengan aksi “Coba lagi”.
- Jika data lokal tidak dapat dibuka, jangan langsung menghapus data; tawarkan langkah aman.

### Accessibility

- Logo dekoratif tidak perlu dibacakan berulang.
- Jika loading lama, semantic label: “Menyiapkan Daily Coffee”.

### Acceptance criteria

- Theme yang benar sudah aktif sebelum screen berikutnya tampil.
- Tidak terjadi flash pure white di dark mode.
- Tidak ada delay buatan.

---

## S02 — Onboarding

### Purpose

Menjelaskan nilai aplikasi dengan singkat dan mengantar pengguna ke koleksi pertama.

### Structure

Maksimal 3 halaman atau satu halaman vertikal ringkas. Rekomendasi isi:

1. **Simpan kopi yang kamu temukan**  
   Arsipkan kemasan dan informasi specialty coffee dalam koleksi pribadi.
2. **Baca informasi dari kemasan**  
   Foto label kopi, lalu periksa hasil sebelum menyimpannya.
3. **Catat setiap seduhan**  
   Hubungkan metode, resep, rasa, dan catatan dengan kopi yang kamu miliki.

### Components

- Ilustrasi/ikon sederhana dan tidak dominan.
- Progress indicator yang menyebut posisi halaman secara semantik.
- `DailyPrimaryButton`: “Mulai koleksi”.
- `DailyTextButton`: “Lewati”, jika menggunakan beberapa halaman.

### Rules

- Jangan meminta permission kamera, galeri, atau notifikasi pada onboarding.
- Jangan meminta account/login untuk MVP local-first.
- Setelah selesai, onboarding tidak ditampilkan lagi kecuali data aplikasi direset.
- Copy menggunakan bahasa yang tenang dan tidak menjanjikan OCR sempurna.

### Acceptance criteria

- Dapat dilewati tanpa permission.
- Mendukung back gesture dan text scale 200%.
- CTA akhir membuka `S03 Coffee Library`.

---

## S03 — Coffee Library

### Purpose

Menjadi beranda utama dan menampilkan seluruh koleksi kopi pengguna.

### App bar

- Title: `Koleksi`.
- Optional supporting greeting tidak diperlukan untuk MVP.
- Actions:
  - Search → `S04`.
  - View toggle grid/list, bila kedua mode diimplementasikan.
  - Overflow hanya jika ada aksi global yang nyata.

### Content hierarchy

1. Optional compact summary: jumlah kopi dalam koleksi; tidak lebih dominan dari daftar.
2. Active filter/sort summary jika bukan default.
3. Grid/list kopi.
4. FAB “Tambah kopi”.

### Coffee card content

- Foto kemasan atau fallback.
- Nama kopi, maksimal 2 baris.
- Roastery, maksimal 1 baris.
- Satu metadata bermakna, prioritas: origin → process → roast level.
- Jangan menampilkan harga.

### Default behavior

- Default sort: `Baru ditambahkan` berdasarkan `createdAt` descending.
- Tap card → `S10 Coffee Detail`.
- Long press bukan satu-satunya cara mengakses aksi.
- Scroll position dipertahankan ketika kembali dari detail.

### States

**Empty**

- Headline: `Koleksimu masih kosong`.
- Body: `Tambahkan kemasan kopi pertama untuk mulai membangun perpustakaan pribadimu.`
- Primary action: `Tambah kopi`.

**Loading**

- Skeleton sesuai grid/list, bukan spinner global jika cache dapat dibaca.

**Error**

- Jelaskan bahwa koleksi gagal dimuat.
- Aksi `Coba lagi`.
- Jangan menghilangkan cache yang masih tersedia.

**Filtered empty**

- Headline: `Tidak ada kopi yang cocok`.
- Aksi: `Hapus filter`.
- Jangan menampilkan onboarding empty state.

### Acceptance criteria

- Grid beradaptasi terhadap lebar dan text scale.
- FAB tidak menutupi card terakhir; sediakan bottom padding.
- Library usable offline.
- Setiap card memiliki semantic label berisi nama dan roastery.

---

## S04 — Search and Filter

### Purpose

Membantu pengguna menemukan kopi berdasarkan informasi yang benar-benar tersimpan.

### Layout

- Search field autofocus di bagian atas.
- Tombol back dan clear yang dapat diakses.
- Recent searches hanya jika benar-benar disimpan; jangan membuat dummy history.
- Hasil memakai `CoffeeListCard` agar mudah dipindai.
- Filter action membuka modal bottom sheet.

### Search behavior

Search case-insensitive terhadap:

- Nama kopi.
- Roastery.
- Negara/region origin.
- Producer.
- Process.
- Varietas.
- Tasting notes.

Gunakan debounce di logic layer. Search lokal harus tetap terasa langsung.

### Filter sheet

Kelompok filter:

- Origin country/region.
- Roastery.
- Process.
- Roast level.
- Tasting notes.
- Rentang roast date/purchase date jika tersedia.

Actions:

- `Terapkan` sebagai primary action.
- `Reset` sebagai text action.
- Tampilkan jumlah filter aktif pada tombol/filter chip.

### Sort options

- Baru ditambahkan.
- Terakhir diperbarui.
- Nama A–Z.
- Roastery A–Z.
- Roast date terbaru, jika field tersedia.

### States

- Query kosong: prompt netral `Cari nama kopi, roastery, origin…`.
- No result: tampilkan query, saran memperluas pencarian, dan aksi reset filter.
- Error: pertahankan query/filter agar pengguna tidak mengulang input.

### Acceptance criteria

- Clear action menghapus query tanpa menghapus filter kecuali dipilih pengguna.
- Back mengembalikan pengguna ke library dan mempertahankan state library.
- Filter yang aktif selalu terlihat atau dapat ditemukan dengan jelas.

---

## S05 — Add Coffee Method

### Purpose

Menawarkan cara penambahan kopi tanpa membuat pengguna memilih terlalu banyak opsi.

### Presentation

Modal bottom sheet dengan drag handle, title `Tambah kopi`, dan tiga pilihan:

1. `Ambil foto kemasan` — camera icon.
2. `Pilih dari galeri` — photo library icon.
3. `Isi secara manual` — edit icon.

Supporting text menjelaskan bahwa hasil foto tetap dapat diperiksa sebelum disimpan.

### Behavior

- Pilihan kamera meminta permission just-in-time.
- Pilihan galeri menggunakan Android system photo picker bila tersedia.
- Manual membuka `S09` tanpa meminta permission.
- Tap scrim/back menutup sheet tanpa perubahan data.

### Acceptance criteria

- Semua pilihan memiliki label, supporting text, dan target sentuh ≥48 dp.
- Tidak ada opsi yang diberi label “AI” jika teknologi tersebut belum menjadi fitur produk yang dapat dijelaskan.

---

## S06 — Camera / Photo Selection

### Purpose

Memperoleh foto kemasan yang cukup jelas untuk dibaca serta disimpan sebagai cover kopi.

### Camera layout

- Full-screen preview.
- Top actions: close dan flash bila didukung.
- Framing guide ringan untuk bagian depan label; bukan crop wajib.
- Instruction: `Pastikan nama kopi dan informasi pada label terlihat jelas.`
- Bottom actions: gallery shortcut, shutter, optional camera switch.

### Photo review

Setelah capture, tampilkan preview dengan actions:

- `Gunakan foto`.
- `Ambil ulang`.
- Optional rotate/crop hanya jika implementasi stabil dan diperlukan.

### Permission states

**First request**

- Jelaskan alasan kamera dibutuhkan tepat sebelum system permission prompt.

**Denied**

- Tawarkan `Pilih dari galeri` dan `Isi manual`.
- Jangan meminta ulang secara agresif.

**Permanently denied**

- Jelaskan cara mengaktifkan melalui Settings.
- Aksi `Buka pengaturan` dan alternatif tanpa kamera.

### Error states

- Camera unavailable.
- File tidak dapat dibaca.
- Format tidak didukung.
- Foto terlalu kecil/buram bila kualitas dapat dideteksi.

Error tidak boleh menghilangkan akses ke input manual.

### Acceptance criteria

- Tidak ada foto yang dikirim/diproses sebelum pengguna mengonfirmasi penggunaan foto.
- Preview mempertahankan orientation yang benar.
- Screen aman terhadap cutout dan navigation inset.

---

## S07 — Scan Processing

### Purpose

Memberi feedback yang jujur selama informasi kemasan dianalisis.

### Layout

- Thumbnail foto kemasan.
- Headline: `Membaca label kopi…`.
- Supporting text yang tidak menjanjikan hasil sempurna: `Kami akan menyiapkan informasi untuk kamu periksa.`
- Progress indicator determinate hanya jika progress nyata tersedia; selain itu gunakan indeterminate.
- Cancel action jika proses memang dapat dibatalkan dengan aman.

### Behavior

- Cegah double submission.
- Jangan memalsukan persentase.
- Jika proses selesai, buka `S08 Review Scan Result`.
- Jika aplikasi berpindah background, proses dan draft harus dipertahankan jika memungkinkan.

### Failure states

**No useful text found**

- Headline: `Informasi belum terbaca`.
- Actions: `Coba foto lain` dan `Isi manual`.
- Manual form membawa foto yang sudah dipilih.

**Technical/network failure**

- Jelaskan bahwa foto belum berhasil diproses.
- Actions: `Coba lagi` dan `Isi manual`.
- Jangan membuang foto/draft.

**Offline**

- Jika OCR membutuhkan jaringan, jelaskan keterbatasan dengan jelas.
- Manual input harus tetap tersedia.

### Acceptance criteria

- Tidak ada spinner tanpa penjelasan.
- Back/cancel memiliki hasil yang jelas dan tidak membuat coffee record setengah jadi.
- Failure selalu menawarkan jalur manual.

---

## S08 — Review Scan Result

### Purpose

Memungkinkan pengguna memverifikasi, memperbaiki, dan melengkapi hasil pembacaan foto sebelum menyimpan.

### App bar

- Title: `Periksa informasi`.
- Back memicu discard confirmation hanya jika ada perubahan/draft yang akan hilang.

### Content order

1. Preview foto kemasan dengan action `Ganti foto`.
2. Inline info: `Periksa kembali hasil pembacaan sebelum menyimpan.`
3. Section `Identitas`:
   - Nama kopi (required).
   - Roastery (required).
4. Section `Asal`:
   - Negara asal.
   - Region/farm/station.
   - Producer.
   - Altitude.
5. Section `Profil kopi`:
   - Process.
   - Varietas.
   - Roast level.
   - Tasting notes.
6. Section `Tanggal dan kemasan`:
   - Roast date.
   - Purchase date.
   - Weight.
7. Section `Catatan pribadi`.
8. Sticky or safe-area bottom action: `Simpan kopi`.

### OCR confidence treatment

- Jangan menampilkan angka confidence mentah kepada pengguna.
- Field yang tidak yakin dapat diberi status `Perlu diperiksa` dengan `DailyStatusBadge` warning.
- Field yang kosong tidak otomatis dianggap error kecuali wajib.
- Setelah pengguna mengedit field uncertain, status warning pada field tersebut hilang.

### Validation

- Nama kopi dan roastery wajib.
- Trim whitespace dan jangan menyimpan empty string sebagai nilai valid.
- Date tidak boleh memiliki urutan yang mustahil jika aturan domain menentukannya.
- Weight harus positif.
- Validation message tampil dekat field dan fokus menuju error pertama setelah submit.

### Save states

- Saat menyimpan, button mempertahankan lebar dan menampilkan loading.
- Double tap tidak membuat duplicate record.
- Success → `S10 Coffee Detail` + snackbar `Kopi ditambahkan ke koleksi`.
- Failure → draft dan input tetap ada; tampilkan retry.

### Acceptance criteria

- Semua OCR result dapat diedit.
- Tidak ada field hasil scan yang disimpan diam-diam tanpa review.
- Back tidak menghilangkan perubahan tanpa peringatan.
- Keyboard tidak menutupi field aktif atau CTA.

---

## S09 — Add Coffee Manually

### Purpose

Menyimpan kopi tanpa ketergantungan pada kamera/OCR.

### Layout

Gunakan urutan field yang sama dengan `S08` agar mental model dan reusable form tetap konsisten.

Perbedaan:

- App bar title: `Tambah kopi`.
- Photo section bersifat optional dengan action `Tambah foto`.
- Tidak ada OCR confidence/status.
- Supporting text singkat: `Isi yang kamu ketahui. Detail lain dapat ditambahkan nanti.`

### Progressive disclosure

- `Nama kopi` dan `Roastery` langsung terlihat.
- Field penting lain tetap tersedia dalam section yang jelas.
- Field lanjutan boleh berada dalam section `Detail lainnya`, tetapi jangan disembunyikan secara sulit ditemukan.

### Draft behavior

- Simpan draft lokal bila form panjang dan architecture mendukungnya.
- Saat keluar dengan perubahan, tawarkan `Simpan draft`, `Buang`, atau `Tetap mengedit` hanya jika draft benar-benar didukung.
- Jangan menampilkan opsi simpan draft palsu.

### Acceptance criteria

- Dapat selesai sepenuhnya offline.
- Minimum save requirement sama dengan `S08`.
- Success membuka coffee detail, bukan kembali ke form kosong.

---

## S10 — Coffee Detail

### Purpose

Menampilkan identitas kopi sebagai halaman editorial dan menjadi titik masuk ke jurnal seduh terkait.

### App bar

- Back.
- Optional favorite/bookmark tidak ditambahkan pada MVP tanpa fungsi nyata.
- Overflow:
  - `Edit kopi`.
  - `Hapus kopi`.

### Content hierarchy

1. Hero image kemasan atau fallback.
2. Nama kopi menggunakan `type.headlineLarge`.
3. Roastery.
4. Primary metadata row: origin, process, roast level—hanya yang tersedia.
5. Tasting notes sebagai `DailyTagChip`.
6. Section `Tentang kopi`:
   - Region.
   - Producer.
   - Varieties.
   - Altitude.
7. Section `Kemasan`:
   - Roast date.
   - Purchase date.
   - Weight.
8. Section `Catatan pribadi`, hanya jika terisi; jika kosong, tampilkan affordance edit yang ringan.
9. Section `Jurnal seduh`:
   - Maksimal beberapa entry terbaru.
   - Action `Lihat semua` bila ada lebih banyak.
   - Empty prompt `Belum ada catatan seduh untuk kopi ini.`
10. Primary contextual action: `Tambah catatan seduh`.

### Missing information

- Jangan menampilkan deretan `—` untuk semua field kosong.
- Sembunyikan row yang tidak memiliki data.
- Jika banyak informasi penting kosong, tampilkan action `Lengkapi informasi` menuju edit.

### Delete behavior

- Confirmation menjelaskan dampak terhadap journal entries.
- Jika deletion coffee juga menghapus jurnal terkait, nyatakan jumlah entry dengan jelas.
- Prefer soft delete/undo jika architecture mendukung dan relasi aman.
- Jangan meninggalkan journal entry orphan.

### Acceptance criteria

- Halaman tetap bermakna walau hanya name dan roastery yang tersedia.
- Semua section menggunakan urutan dan label konsisten.
- Foto tidak memotong informasi penting secara permanen; tersedia cara melihat proporsi lengkap bila diperlukan.
- CTA journal membuka `S13` dengan coffee sudah dipilih.

---

## S11 — Edit Coffee

### Purpose

Mengubah coffee record tanpa kehilangan informasi yang sudah tersimpan.

### Structure

- Reuse form component dan urutan field `S08/S09`.
- Semua field terisi dari current record.
- Title: `Edit kopi`.
- Primary action: `Simpan perubahan`.
- Photo dapat diganti atau dihapus dengan confirmation bila diperlukan.

### Behavior

- Save hanya mengubah field yang memang diedit.
- Back dengan unsaved changes memunculkan confirmation.
- Loading state tidak menutup form sebelum persistence berhasil.
- Success kembali ke detail yang sudah diperbarui.

### Acceptance criteria

- Journal entries yang terhubung tetap terhubung setelah edit.
- Nilai custom untuk process/variety/tasting notes tetap dipertahankan.
- Failed save tidak mereset form.

---

## S12 — Journal List

### Purpose

Menampilkan riwayat pengalaman seduh secara kronologis dan personal.

### App bar

- Title: `Jurnal`.
- Search/filter action jika jumlah data memerlukannya.

### Content hierarchy

- Optional period grouping: `Hari ini`, `Minggu ini`, lalu bulan/tahun; gunakan label locale-aware.
- `JournalEntryCard` menampilkan:
  - Nama kopi.
  - Roastery atau thumbnail kopi.
  - Brew method.
  - Brew date/time.
  - Rating jika ada.
  - Ringkasan tasting notes atau catatan.
- Default sort: brewed date terbaru.
- FAB `Tambah catatan`.

### Add behavior

- Jika koleksi memiliki kopi: buka `S13` dan minta pemilihan kopi.
- Jika koleksi kosong: jangan buka form yang tidak dapat disimpan. Tampilkan sheet/prompt:
  - `Tambahkan kopi terlebih dahulu`.
  - Primary action: `Tambah kopi`.
  - Secondary: `Batal`.

### Filter options

- Coffee.
- Brew method.
- Rating.
- Date range.

### States

**Empty**

- Headline: `Belum ada catatan seduh`.
- Body: `Catat resep dan rasa dari seduhanmu untuk menemukan yang paling kamu sukai.`
- CTA menyesuaikan ketersediaan coffee: `Tambah catatan` atau `Tambah kopi`.

**Filtered empty**

- Jelaskan tidak ada entry yang sesuai dan berikan `Hapus filter`.

### Acceptance criteria

- Entry dapat dipindai tanpa membuka detail.
- Rating ditandai sebagai penilaian personal dan tetap memiliki semantic label.
- Date/time memakai locale pengguna.

---

## S13 — Add Journal Entry

### Purpose

Mencatat resep dan pengalaman seduh yang terkait dengan sebuah kopi.

### App bar

- Title: `Tambah catatan`.
- Back dengan confirmation jika input akan hilang.

### Content order

1. `Pilih kopi` (required).
   - Bila berasal dari Coffee Detail, field sudah terisi dan tetap dapat diganti jika diizinkan.
   - Picker menampilkan foto, nama, dan roastery; dapat dicari.
2. `Tanggal dan waktu` (required, default now).
3. `Metode seduh` (required, select + custom).
4. Section `Resep`:
   - Dose.
   - Water.
   - Temperature.
   - Grind size.
   - Brew time.
5. Section `Hasil seduhan`:
   - Personal rating 1–5.
   - Tasting notes.
   - Free-form note.
6. Primary action: `Simpan catatan`.

### Input rules

- Numeric fields menggunakan keyboard numeric/decimal yang sesuai.
- Unit selalu terlihat, tidak hanya melalui placeholder.
- Brew time dapat diketik dengan format jelas atau melalui duration input yang accessible.
- Rating dapat dikosongkan; jangan default ke 5.
- Rating stars/buttons minimal memiliki target 48 dp dan semantic label `1 dari 5`, dan seterusnya.
- Tasting notes dapat mengambil suggestion dari coffee profile, tetapi tidak otomatis dipilih.

### Optional derived preview

- Brew ratio dapat ditampilkan bila dose dan water valid, misalnya `Rasio 1:16`.
- Nilai turunan bersifat informatif dan tidak perlu disimpan sebagai source of truth.
- Jangan tampilkan ratio jika input tidak valid atau pembaginya nol.

### Save behavior

- Validate required fields dan nilai numeric positif.
- Success → `S14 Journal Entry Detail` + snackbar.
- Failure mempertahankan seluruh input.
- Cegah duplicate save akibat double tap.

### Acceptance criteria

- Form dapat diselesaikan hanya dengan required fields.
- Optional recipe fields tidak membuat form terasa wajib atau menakutkan.
- Keyboard dan text scaling tidak menutupi CTA.

---

## S14 — Journal Entry Detail

### Purpose

Menyajikan satu pengalaman seduh sebagai catatan yang mudah dibaca dan dibandingkan secara mental.

### App bar

- Back.
- Overflow: `Edit catatan`, `Hapus catatan`.

### Content hierarchy

1. Coffee reference card: photo, coffee name, roastery; tap → `S10`.
2. Brew date/time.
3. Brew method sebagai title utama.
4. Rating personal jika ada.
5. Recipe summary:
   - Dose.
   - Water.
   - Ratio derived.
   - Temperature.
   - Grind size.
   - Brew time.
6. Tasting notes chips.
7. Written note.

### Missing information

- Sembunyikan recipe row yang kosong.
- Jika seluruh recipe optional kosong, jangan tampilkan card/section kosong.
- Bila note kosong, jangan tampilkan placeholder besar; gunakan edit affordance jika berguna.

### Delete behavior

- Confirmation menyebut catatan dan kopi terkait.
- Menghapus entry tidak menghapus coffee.
- Setelah success kembali ke journal list atau coffee detail sesuai asal navigasi.

### Acceptance criteria

- Data terbaca sebagai catatan personal, bukan dashboard angka.
- Coffee reference selalu jelas.
- Unit dan format konsisten dengan form.

---

## S15 — Edit Journal Entry

### Purpose

Memperbaiki recipe, rasa, atau informasi catatan seduh.

### Structure and behavior

- Reuse seluruh form `S13` dengan initial data.
- Title: `Edit catatan`.
- CTA: `Simpan perubahan`.
- Back dengan unsaved changes memunculkan confirmation.
- Success kembali ke detail yang telah diperbarui.
- Failure mempertahankan input.

### Acceptance criteria

- Mengganti coffee reference memerlukan tindakan eksplisit.
- Derived ratio diperbarui saat dose/water berubah.
- Empty optional field dapat disimpan sebagai null, bukan string kosong.

---

## S16 — Settings

### Purpose

Menampung preferensi aplikasi tanpa mengganggu alur koleksi dan jurnal.

### Sections

**Tampilan**

- `Tema` → System / Light / Dark.

**Data**

- `Data dan penyimpanan` → `S17`.

**Tentang**

- `Tentang Daily Coffee` → `S18`.
- `Lisensi open source` → native licenses page.
- Versi aplikasi sebagai supporting text, bukan row interaktif jika tidak ada action.

### Rules

- Gunakan setting row yang jelas dengan label dan current value.
- Toggle hanya untuk preference boolean yang langsung berlaku.
- Pilihan 3 arah seperti theme memakai dialog/radio sheet, bukan dua toggle.
- Jangan menambahkan account section jika account belum ada.

### Acceptance criteria

- Theme berubah tanpa restart aplikasi.
- Current value dibacakan oleh TalkBack.
- Tidak ada setting yang belum berfungsi.

---

## S17 — Data and Storage

### Purpose

Menjelaskan lokasi/kendali data dan menyediakan aksi data yang aman.

### MVP content

- Ringkasan jumlah coffee records dan journal entries.
- Informasi bahwa data disimpan lokal jika memang benar.
- Optional `Ekspor data` hanya jika implementasi tersedia dan format dijelaskan.
- Optional `Impor data` hanya jika validation dan conflict behavior tersedia.
- `Hapus semua data` sebagai destructive action terpisah.

### Delete all flow

1. Tap `Hapus semua data`.
2. Dialog menjelaskan coffee, journal, image/draft yang akan dihapus.
3. Primary destructive label spesifik: `Hapus semua data`.
4. Cancel menjadi pilihan yang aman.
5. Bila diperlukan, gunakan second confirmation berbasis input, tetapi jangan berlebihan untuk data yang dapat dipulihkan.
6. Setelah berhasil, kembali ke library empty state dan reset onboarding hanya jika requirement menyatakannya.

### Rules

- Jangan mengklaim cloud backup atau encryption tanpa implementasi nyata.
- Jangan menghitung cache sebagai data pengguna jika “clear cache” tidak menghapus records.
- Aksi export/import harus memakai Android document picker dan memberi feedback hasil.

### Acceptance criteria

- Destructive action tidak berdekatan dengan aksi normal tanpa pemisah.
- Penghapusan tidak dapat terpicu oleh satu tap tidak sengaja.
- Progress dan failure state untuk import/export tidak menghilangkan data existing.

---

## S18 — About

### Purpose

Menjelaskan identitas aplikasi secara ringkas.

### Content

- App icon dan `Daily Coffee`.
- Tagline: `Jurnal dan perpustakaan kopi pribadimu.`
- Deskripsi singkat tujuan aplikasi.
- Version/build number.
- Privacy policy link jika tersedia.
- Open-source licenses link.
- Credits hanya untuk aset/library yang memang digunakan.

### Rules

- Jangan menambahkan social link atau legal link dummy.
- External link menggunakan safe launcher dan memberi feedback bila gagal dibuka.
- Versi dibaca dari package metadata, bukan hard-coded di UI.

### Acceptance criteria

- Informasi akurat terhadap build yang berjalan.
- Semua link yang tampil benar-benar dapat digunakan.

---

## 9. Shared Sheets, Dialogs, and Pickers

## 9.1 Coffee Picker

Digunakan pada journal form.

- Search field.
- List coffee dengan thumbnail, name, roastery.
- Current selection ditandai icon dan semantic state.
- Empty state mengarahkan ke add coffee.
- Pemilihan menutup sheet dan memperbarui form tanpa menghapus input lain.

## 9.2 Controlled Vocabulary Picker

Digunakan untuk process, roast level, brew method, dan field serupa.

- Pilihan umum terkurasi.
- Search bila opsi panjang.
- `Tambahkan nilai lain` untuk field yang menerima custom input.
- Jangan membuat taxonomy baru tanpa product decision.
- Custom value harus dapat diedit dan dipertahankan.

## 9.3 Date Picker

- Gunakan Material date picker yang ditheme dengan token Daily Coffee.
- Locale mengikuti perangkat.
- Current value dan clear action tersedia untuk field optional.
- Batasi future date hanya jika aturan field memang memerlukannya; brewed date dapat mengikuti kebutuhan real use.

## 9.4 Discard Changes Dialog

- Title: `Buang perubahan?`.
- Body menyebut bahwa perubahan yang belum disimpan akan hilang.
- Safe action: `Tetap mengedit`.
- Destructive action: `Buang`.
- Jangan tampilkan jika form belum berubah.

## 9.5 Delete Confirmation Dialog

- Sebut objek yang akan dihapus.
- Jelaskan relasi/dampak yang ikut terhapus.
- Gunakan label spesifik, bukan hanya `Ya`/`Tidak`.
- Focus awal berada pada tindakan aman bila platform memungkinkan.

---

## 10. Global Feedback States

### Success

- Gunakan snackbar singkat setelah save/edit/delete.
- Contoh: `Kopi berhasil disimpan`, `Catatan berhasil diperbarui`.
- Gunakan undo hanya ketika operasi benar-benar dapat dibalik dengan aman.

### Validation error

- Tampil inline dekat field.
- Setelah submit, scroll/focus ke error pertama.
- Sediakan summary hanya untuk form yang sangat panjang jika membantu accessibility.

### Persistence error

- Input/draft tidak hilang.
- Pesan menjelaskan aksi yang gagal, misalnya `Kopi belum berhasil disimpan`.
- Sediakan `Coba lagi` bila aman.

### Network error

- Jangan blokir data lokal.
- Tampilkan network dependency hanya pada fitur yang benar-benar membutuhkannya, seperti remote OCR.

### Offline

- Koleksi dan jurnal lokal tetap dapat dibaca/ditulis.
- Jika ada sync pada fase berikutnya, tampilkan pending sync sebagai status non-blocking.

---

## 11. Content and Microcopy Rules

- Gunakan Bahasa Indonesia yang natural, ringkas, dan tidak teknis.
- Gunakan `kamu` secara konsisten; jangan bercampur dengan `Anda`.
- Gunakan `kopi` untuk record koleksi dan `catatan`/`catatan seduh` untuk journal entry.
- Label button menggunakan kata kerja: `Tambah kopi`, `Simpan perubahan`, `Coba lagi`.
- Hindari label ambigu seperti `OK`, `Yes`, `Submit`, atau `Process`.
- Error menjelaskan masalah dan langkah berikutnya.
- Jangan menyebut OCR confidence, exception, database, atau kode error kepada pengguna.
- Jangan mengklaim “AI mengenali dengan akurat”; gunakan bahasa review-first.
- Tanggal dan angka mengikuti locale perangkat.
- Nama roastery, origin, variety, dan istilah kopi tidak diterjemahkan paksa jika nama aslinya lebih tepat.

### Preferred terms

| Gunakan | Hindari |
|---|---|
| `Koleksi` | Produk, Shop |
| `Tambah kopi` | Add item |
| `Catatan seduh` | Review publik |
| `Membaca label` | AI magic scan |
| `Periksa informasi` | Confirm data OCR |
| `Hapus` | Remove permanently tanpa konteks |
| `Roastery` | Toko, seller |

---

## 12. Accessibility per Screen

Selain aturan global pada `DESIGN_SYSTEM.md`:

- Urutan semantic mengikuti app bar → context → content → primary action → navigation.
- Card tappable dibaca sebagai satu kelompok, tetapi aksi overflow tetap node terpisah.
- Foto kemasan memiliki label seperti `Foto kemasan [nama kopi]`; fallback image dekoratif tidak perlu dibacakan.
- Rating dibaca sebagai `Nilai pribadi 4 dari 5`, bukan lima icon terpisah pada detail.
- Filter aktif diumumkan sebagai selected.
- Loading OCR menggunakan live region yang tidak mengumumkan perubahan terlalu sering.
- Error form diumumkan setelah submit.
- Bottom sheet memiliki title semantic dan fokus awal yang jelas.
- Semua icon-only actions mempunyai tooltip dan semantic label.
- Layout harus usable pada text scale 200% tanpa clipped text atau CTA hilang.

---

## 13. Responsive Behavior

### Compact `< 600 dp`

- Single-column forms dan detail.
- Library memakai 2-column grid hanya jika minimum card width dan text scaling memungkinkan; selain itu list/1 column.
- Bottom navigation digunakan.
- Full-screen form untuk create/edit.

### Medium `600–839 dp`

- Content padding 24 dp.
- Library dapat memakai 2–3 kolom berdasarkan minimum item width.
- Form tetap satu kolom dengan max width 720 dp.
- Detail dapat menempatkan image dan identity secara berdampingan jika content tidak tertekan.

### Expanded `≥ 840 dp`

- Gunakan max content width dari design system.
- Navigation rail dapat menggantikan bottom navigation jika implementasi tablet diprioritaskan.
- Master-detail untuk library/detail boleh digunakan, tetapi route dan back behavior harus tetap konsisten.
- Jangan meregangkan form memenuhi seluruh lebar.

### Keyboard and insets

- Scaffold menyesuaikan keyboard.
- Scroll form menuju focused field.
- Sticky bottom CTA tetap di atas system inset/keyboard atau menjadi bagian scroll yang mudah dijangkau.
- FAB dan snackbar tidak bertabrakan dengan navigation bar.

---

## 14. Suggested Reusable Screen-Level Components

Komponen berikut menggunakan foundations dari `DESIGN_SYSTEM.md`:

| Component | Responsibility |
|---|---|
| `DailyAppScaffold` | Insets, background, app bar, navigation, snackbar placement |
| `CoffeeLibraryGrid` | Responsive grid/list layout untuk coffee cards |
| `CoffeeForm` | Shared fields dan validation untuk add/review/edit coffee |
| `CoffeeImageHeader` | Image, fallback, replace/view behavior |
| `CoffeeMetadataSection` | Semantic key-value details |
| `CoffeePickerSheet` | Search dan select coffee |
| `JournalEntryForm` | Shared fields dan validation add/edit journal |
| `BrewRecipeSummary` | Consistent recipe values dan derived ratio |
| `TastingNotesInput` | Suggested + custom multi-value input |
| `ControlledValuePicker` | Curated choices + custom value |
| `ActiveFilterBar` | Ringkasan dan reset filter |
| `PermissionRationaleSheet` | Penjelasan permission dan alternatives |
| `UnsavedChangesGuard` | Mendeteksi perubahan dan confirm exit |

Rules:

- Screen-level component boleh membaca feature state melalui interface yang jelas.
- Design-system component tidak boleh mengakses repository atau provider feature secara tersembunyi.
- `CoffeeForm` dan `JournalEntryForm` harus reuse validation/domain rules, bukan menduplikasi aturan pada setiap screen.

---

## 15. Flutter Implementation Guidance

### Navigation

- Gunakan declarative router yang mendukung nested navigation dan deep links.
- Setiap root destination mempunyai navigator/state yang dapat dipertahankan.
- Route arguments menggunakan ID/domain reference, bukan object UI mutable sebagai source of truth.
- Camera/system picker result ditangani sebagai nullable; cancellation bukan error.

### State ownership

- Screen state: search query, selected tab lokal, expansion state.
- Feature state: coffee collection, journal entries, filters, drafts.
- Domain/data state: persistence, OCR result, repository errors.
- Jangan menaruh seluruh form state di widget global atau singleton.
- Gunakan immutable state dan explicit loading/error/success state.

### Forms

- Model draft terpisah dari persisted entity.
- Normalisasi whitespace dan optional empty values sebelum persistence.
- Validation rules dapat diuji tanpa merender widget.
- `AutovalidateMode` tidak boleh mengganggu saat pengguna baru mulai mengetik.
- Restore draft/process setelah lifecycle interruption bila risiko kehilangan input tinggi.

### Lists and performance

- Gunakan lazy builders untuk library dan journal.
- Resize/cache image sesuai display size; jangan decode full-resolution photo untuk thumbnail.
- Gunakan stable keys berdasarkan entity ID.
- Search/filter besar dilakukan di logic/data layer, bukan computation berat di `build()`.

### Data safety

- Save bersifat idempotent selama satu submission.
- Delete memperhitungkan relasi coffee–journal.
- OCR output dianggap untrusted input dan selalu dinormalisasi/divalidasi.
- Jangan menyimpan record parsial sebelum review kecuali sebagai draft terpisah.
- Jangan menghapus original photo/draft saat retry masih diperlukan.

### Testing priorities

- First launch → onboarding → empty library.
- Add manual coffee successful dan validation failure.
- Camera denied → gallery/manual fallback.
- OCR success, no text, offline, dan technical failure.
- Review scan prevents duplicate save.
- Coffee detail dengan data minimum dan data lengkap.
- Coffee deletion dengan related journal entries.
- Add/edit/delete journal entry.
- Search/filter/sort dan filtered empty state.
- Theme light/dark/system.
- Text scale 200%, TalkBack semantics, compact/medium layouts.
- Process death/background restoration untuk form/draft bila didukung.

---

## 16. AI Coding Assistant Guardrails

AI yang mengimplementasikan dokumen ini wajib:

1. Membaca `DESIGN_SYSTEM.md` dan section screen terkait sebelum menulis widget.
2. Memakai route, hierarchy, copy intent, state, dan acceptance criteria dalam dokumen ini.
3. Menggunakan reusable component sebelum membuat widget baru.
4. Menjaga pemisahan UI, state, domain, dan persistence.
5. Mengimplementasikan empty/loading/error/permission state yang relevan, bukan hanya happy path.
6. Mempertahankan input saat operasi gagal.
7. Menyediakan semantics dan target sentuh yang sesuai.
8. Menandai assumption atau dependency yang belum tersedia secara eksplisit.

AI dilarang tanpa product decision:

- Menambah screen e-commerce, social feed, account, subscription, leaderboard, atau rewards.
- Menambah field hanya karena umum ditemukan pada coffee app lain.
- Menginvent design token, style, illustration direction, atau navigation pattern baru.
- Mengisi aplikasi dengan dummy content yang terlihat seperti data nyata pada production state.
- Menganggap OCR selalu berhasil atau hasilnya selalu benar.
- Meminta semua permission pada first launch.
- Menghapus input pengguna saat retry/error.
- Menyembunyikan required action hanya dalam gesture atau overflow menu.
- Menggunakan istilah teknis dalam user-facing copy.

Jika requirement implementasi bertentangan dengan dokumen:

1. Jangan diam-diam mengubah flow.
2. Catat konflik secara singkat.
3. Usulkan perubahan pada dokumen beserta alasan dan dampaknya.
4. Setelah disetujui, perbarui spesifikasi sebelum menjadikan perubahan sebagai pola baru.

---

## 17. MVP Delivery Order

Urutan implementasi yang disarankan:

### Phase 1 — Foundations

- Theme dan design tokens.
- Reusable buttons, inputs, cards, states, scaffold.
- Domain model dan local persistence dasar.
- Navigation shell.

### Phase 2 — Manual collection

- `S03 Coffee Library`.
- `S09 Add Coffee Manually`.
- `S10 Coffee Detail`.
- `S11 Edit Coffee`.
- Search/filter dasar.

### Phase 3 — Journal

- `S12 Journal List`.
- `S13 Add Journal Entry`.
- `S14 Journal Entry Detail`.
- `S15 Edit Journal Entry`.

### Phase 4 — Photo and scan

- `S05 Add Coffee Method`.
- `S06 Camera / Photo Selection`.
- `S07 Scan Processing`.
- `S08 Review Scan Result`.
- Permission dan failure fallbacks.

### Phase 5 — Settings and hardening

- Onboarding.
- Settings/data/about.
- Draft restoration.
- Accessibility, responsive, performance, and full state testing.

Fase implementasi tidak mengubah prioritas produk: manual input harus tetap menjadi jalur lengkap meskipun scan belum tersedia atau gagal.

---

## 18. Global Definition of Done

Sebuah screen dianggap selesai jika:

- Tujuan, hierarchy, dan navigation sesuai dokumen.
- Menggunakan token dan component dari `DESIGN_SYSTEM.md`.
- Happy path serta empty/loading/error/offline/permission state yang relevan tersedia.
- Input pengguna tidak hilang akibat validation atau recoverable error.
- Berfungsi pada light dan dark theme.
- Layout lolos compact, medium, keyboard-open, dan text scale 200%.
- Target sentuh dan semantics dapat digunakan dengan TalkBack.
- Copy menggunakan Bahasa Indonesia yang konsisten.
- Tidak memuat affordance palsu atau fitur yang belum bekerja.
- Domain validation dan important widget behavior memiliki test.
- Tidak menggeser produk menjadi coffee shop/e-commerce.

---

## 19. Final Review Checklist

Sebelum menyetujui implementasi Daily Coffee, periksa:

1. Apakah pengguna dapat menyimpan kopi secara manual tanpa kamera atau jaringan?
2. Apakah hasil scan selalu dapat diperiksa dan diedit sebelum disimpan?
3. Apakah kegagalan scan menawarkan foto ulang dan input manual?
4. Apakah library tetap berguna saat offline?
5. Apakah detail kopi tetap bermakna dengan minimum data?
6. Apakah journal entry selalu terhubung ke kopi yang valid?
7. Apakah delete menjelaskan dampak terhadap data terkait?
8. Apakah search/filter mempertahankan query saat gagal?
9. Apakah form mempertahankan input saat save gagal?
10. Apakah permission diminta pada saat dibutuhkan dan memiliki alternatif?
11. Apakah setiap layar memiliki state empty/loading/error yang tepat, bukan generic placeholder?
12. Apakah seluruh UI mengikuti `DESIGN_SYSTEM.md` tanpa token atau style improvisasi?
13. Apakah semua fitur terasa sebagai personal coffee library dan journal, bukan toko?

Jika satu jawaban penting adalah “tidak”, screen belum memenuhi Definition of Done.
