# Daily Coffee — Design System

> **Status:** Sumber kebenaran desain (single source of truth)  
> **Platform utama:** Flutter untuk Android  
> **Produk:** Jurnal specialty coffee dan perpustakaan kopi pribadi  
> **Dokumen terkait:** `UI_SCREENS.md` akan dibuat terpisah dan harus mengikuti dokumen ini.

Dokumen ini mendefinisikan bahasa visual, token, perilaku komponen, dan aturan implementasi Daily Coffee. Dokumen ditujukan untuk manusia maupun AI coding assistant. Semua layar dan komponen baru wajib menggunakan token dan pola yang didefinisikan di sini.

---

## 1. Design Direction

Daily Coffee adalah **personal coffee library** dan **specialty coffee journal**. Pengguna menyimpan kopi yang pernah dibeli, membaca informasi dari kemasan, melengkapi detail kopi, dan membangun arsip rasa serta pengalaman mereka.

Karakter visual utama:

- **Warm minimalism** — hangat, sederhana, dan tidak terasa steril.
- **Modern** — struktur bersih dengan pola interaksi Android yang familiar.
- **Calm** — ruang kosong cukup, hierarki tenang, dan animasi halus.
- **Premium** — tipografi rapi, foto berkualitas, dan detail visual yang terkendali.
- **Editorial** — informasi kopi diperlakukan seperti catatan kurasi, bukan katalog barang.
- **Personal** — koleksi terasa dimiliki pengguna, bukan etalase toko.

Daily Coffee **bukan** aplikasi coffee shop, pemesanan minuman, marketplace, atau e-commerce. Hindari pola visual seperti harga yang dominan, keranjang belanja, tombol “Beli sekarang”, banner diskon, countdown, atau kartu produk bergaya food-delivery.

### Kata kunci suasana

`warm` · `tactile` · `quiet` · `curated` · `earthy` · `thoughtful` · `editorial`

---

## 2. Core Principles

1. **Coffee is the hero**  
   Foto kemasan dan identitas kopi menjadi fokus. UI mendukung konten, bukan bersaing dengannya.

2. **Clarity before decoration**  
   Informasi origin, roastery, process, varietas, roast level, dan tasting notes harus mudah dipindai.

3. **Warm, not rustic**  
   Gunakan warna bumi dan tekstur melalui foto. Jangan memakai ornamen vintage, tekstur kertas palsu, atau ilustrasi biji kopi berlebihan.

4. **Calm density**  
   Berikan ruang yang cukup tanpa membuang area layar. Kelompokkan informasi berdasarkan hubungan, bukan dengan banyak kotak.

5. **Progressive disclosure**  
   Tampilkan informasi penting terlebih dahulu. Detail sekunder boleh hadir di bagian lanjutan, expansion area, atau bottom sheet.

6. **Consistent and learnable**  
   Aksi, bentuk, jarak, warna status, dan pola navigasi harus konsisten di seluruh aplikasi.

7. **Accessible by default**  
   Kontras, ukuran target sentuh, label, dan status tidak boleh bergantung pada warna saja.

---

## 3. Color System

### 3.1 Aturan penggunaan

- Semua warna implementasi harus berasal dari token berikut.
- Gunakan token **semantik** di dalam widget, bukan nilai hex langsung.
- `primary` digunakan untuk aksi utama dan elemen terpilih, bukan sebagai warna dekoratif pada seluruh layar.
- Warna status hanya digunakan untuk menyampaikan status terkait.
- Foto kopi boleh memperkaya warna halaman, tetapi tidak mengubah token UI.
- Jangan menggunakan pure white `#FFFFFF` atau pure black `#000000` sebagai latar utama.

### 3.2 Source palette

Palet dasar ini menjadi sumber token light dan dark mode.

| Token sumber | Hex | Peran |
|---|---:|---|
| `cream.50` | `#FFFDFC` | Permukaan paling terang |
| `cream.100` | `#F8F2EE` | Latar light utama |
| `cream.200` | `#F0E5DE` | Permukaan sekunder |
| `cream.300` | `#E2D1C6` | Border hangat |
| `brown.400` | `#8A6A5A` | Teks/ikon sekunder tertentu |
| `brown.600` | `#56392C` | Brand utama |
| `brown.700` | `#432B22` | Brand pressed/dark |
| `brown.800` | `#2B1B16` | Permukaan gelap terangkat |
| `brown.900` | `#1A110E` | Latar dark |
| `espresso.950` | `#0D0A09` | Teks utama light |
| `orange.600` | `#CE5618` | Aksen terbatas |
| `green.600` | `#52705A` | Success |
| `amber.600` | `#A66A18` | Warning |
| `red.600` | `#B7473E` | Error/destructive |

### 3.3 Light theme tokens

| Token semantik | Nilai | Penggunaan |
|---|---:|---|
| `color.background` | `#F8F2EE` | Latar utama aplikasi |
| `color.surface` | `#FFFDFC` | Card, dialog, sheet, input |
| `color.surfaceSubtle` | `#F0E5DE` | Area sekunder, skeleton, chip netral |
| `color.surfaceStrong` | `#E2D1C6` | Permukaan dengan penekanan lebih tinggi |
| `color.primary` | `#56392C` | Tombol utama, selected state, fokus |
| `color.primaryPressed` | `#432B22` | Primary pressed |
| `color.onPrimary` | `#FFFDFC` | Konten di atas primary |
| `color.accent` | `#CE5618` | Sorotan kecil dan terkontrol |
| `color.onAccent` | `#FFFDFC` | Konten di atas accent |
| `color.textPrimary` | `#0D0A09` | Judul dan body utama |
| `color.textSecondary` | `#6F5A50` | Metadata dan helper text |
| `color.textDisabled` | `#9D8D84` | Konten disabled |
| `color.iconPrimary` | `#2B1B16` | Ikon utama |
| `color.iconSecondary` | `#7D675C` | Ikon pendukung |
| `color.border` | `#D8C8BE` | Border default |
| `color.borderStrong` | `#A88F81` | Border aktif/penekanan |
| `color.divider` | `#E2D1C6` | Divider halus |
| `color.focusRing` | `#CE5618` | Indikator fokus |
| `color.scrim` | `#0D0A0999` | Overlay modal (60%) |
| `color.success` | `#52705A` | Status berhasil |
| `color.warning` | `#A66A18` | Status peringatan |
| `color.error` | `#B7473E` | Error/destructive |
| `color.onStatus` | `#FFFDFC` | Konten di atas status solid |

### 3.4 Dark theme tokens

Dark mode mempertahankan kehangatan. Hindari latar abu-abu kebiruan dan kontras putih yang terlalu tajam.

| Token semantik | Nilai | Penggunaan |
|---|---:|---|
| `color.background` | `#1A110E` | Latar utama aplikasi |
| `color.surface` | `#241713` | Card, dialog, sheet, input |
| `color.surfaceSubtle` | `#2B1B16` | Area sekunder dan skeleton |
| `color.surfaceStrong` | `#3A271F` | Permukaan dengan penekanan |
| `color.primary` | `#D7B7A5` | Tombol utama, selected state, fokus |
| `color.primaryPressed` | `#C49B84` | Primary pressed |
| `color.onPrimary` | `#241713` | Konten di atas primary |
| `color.accent` | `#E77A3F` | Sorotan kecil dan terkontrol |
| `color.onAccent` | `#1A110E` | Konten di atas accent |
| `color.textPrimary` | `#F8F2EE` | Judul dan body utama |
| `color.textSecondary` | `#C8B5AA` | Metadata dan helper text |
| `color.textDisabled` | `#806F66` | Konten disabled |
| `color.iconPrimary` | `#F0E5DE` | Ikon utama |
| `color.iconSecondary` | `#B6A096` | Ikon pendukung |
| `color.border` | `#4B362D` | Border default |
| `color.borderStrong` | `#8A6A5A` | Border aktif/penekanan |
| `color.divider` | `#3A271F` | Divider halus |
| `color.focusRing` | `#E77A3F` | Indikator fokus |
| `color.scrim` | `#0D0A09B3` | Overlay modal (70%) |
| `color.success` | `#7FA087` | Status berhasil |
| `color.warning` | `#D4A052` | Status peringatan |
| `color.error` | `#E17A71` | Error/destructive |
| `color.onStatus` | `#1A110E` | Konten di atas status solid |

> Token warna status untuk background lembut dibuat melalui opacity maksimal 12% dari warna status di atas permukaan aktif; jangan membuat hex status baru.

---

## 4. Typography

### 4.1 Font family

- **Display/editorial:** `Lora` — digunakan hemat untuk judul besar, nama kopi pada detail, dan empty-state headline.
- **UI/body:** `Inter` — digunakan untuk navigasi, tombol, input, metadata, label, dan body text.
- **Fallback:** gunakan fallback sans-serif bawaan platform jika Inter gagal dimuat; jangan mengganti karakter desain dengan font ketiga.

Font harus dibundel sebagai asset aplikasi agar tampilan tidak bergantung pada jaringan.

### 4.2 Type scale

| Style token | Font | Size / line height | Weight | Penggunaan |
|---|---|---:|---:|---|
| `type.displayLarge` | Lora | 36 / 44 | 600 | Hero atau empty state khusus |
| `type.displayMedium` | Lora | 30 / 38 | 600 | Judul editorial layar |
| `type.headlineLarge` | Lora | 26 / 34 | 600 | Nama kopi pada detail |
| `type.headlineMedium` | Inter | 22 / 28 | 700 | Judul layar |
| `type.titleLarge` | Inter | 20 / 26 | 700 | Judul section/card utama |
| `type.titleMedium` | Inter | 16 / 22 | 600 | Judul card/list item |
| `type.bodyLarge` | Inter | 16 / 24 | 400 | Body utama |
| `type.bodyMedium` | Inter | 14 / 20 | 400 | Body ringkas, deskripsi |
| `type.labelLarge` | Inter | 14 / 20 | 600 | Tombol dan label navigasi |
| `type.labelMedium` | Inter | 12 / 16 | 600 | Chip dan field label |
| `type.caption` | Inter | 12 / 16 | 400 | Metadata dan helper text |

### 4.3 Aturan tipografi

- Gunakan sentence case, bukan ALL CAPS.
- Batasi judul card maksimal 2 baris dan metadata maksimal 1 baris jika ruang terbatas.
- Gunakan ellipsis hanya pada konteks yang dapat dibuka untuk melihat nilai lengkap.
- Jangan menggunakan weight di bawah 400 atau di atas 700.
- Jangan memakai Lora untuk tombol, input, tab, label kecil, atau paragraf panjang.
- Hormati text scaling Android. Layout wajib tetap dapat digunakan hingga skala teks 200%.
- Angka statistik boleh menggunakan `FontFeature.tabularFigures()` bila perataan angka diperlukan.

---

## 5. Spacing — 8pt System

Grid dasar adalah 8 dp. Nilai 4 dp hanya untuk jarak mikro di dalam komponen. Semua jarak lain memakai kelipatan 8.

| Token | Nilai | Penggunaan umum |
|---|---:|---|
| `space.0` | 0 dp | Tanpa jarak |
| `space.0_5` | 4 dp | Jarak mikro ikon–label atau internal |
| `space.1` | 8 dp | Elemen yang sangat terkait |
| `space.1_5` | 12 dp | Padding chip dan kontrol kecil |
| `space.2` | 16 dp | Padding horizontal mobile default |
| `space.3` | 24 dp | Jarak antarkelompok |
| `space.4` | 32 dp | Jarak antarsection |
| `space.5` | 40 dp | Ruang section besar |
| `space.6` | 48 dp | Pemisah area utama |
| `space.8` | 64 dp | Ruang hero/editorial |

Aturan:

- Margin horizontal layar ponsel: `space.2` (16 dp); naik menjadi 24 dp pada lebar ≥ 600 dp.
- Gap default antarelemen dalam card: 8–12 dp.
- Gap default antarcard: 12–16 dp.
- Jangan memakai nilai acak seperti 5, 10, 14, 18, atau 22 dp untuk spacing.

---

## 6. Border Radius

| Token | Nilai | Penggunaan |
|---|---:|---|
| `radius.none` | 0 dp | Divider atau media edge-to-edge |
| `radius.small` | 8 dp | Chip persegi, badge, image kecil |
| `radius.medium` | 12 dp | Input, tombol, compact card |
| `radius.large` | 16 dp | Card utama dan image card |
| `radius.xlarge` | 24 dp | Dialog, sheet content tertentu |
| `radius.full` | 999 dp | Pill, avatar, icon button bulat |

Jangan mencampur lebih dari dua tingkat radius dalam satu komponen. Bottom sheet menggunakan radius 24 dp hanya pada sudut atas.

---

## 7. Elevation and Shadow

Gunakan border dan perbedaan warna permukaan sebelum menggunakan shadow. Shadow harus lembut dan netral-hangat.

| Token | Elevation | Shadow | Penggunaan |
|---|---:|---|---|
| `elevation.none` | 0 | Tidak ada | Default card dan surface |
| `elevation.low` | 1 | `#2B1B1614`, blur 8, y 2 | Floating control ringan |
| `elevation.medium` | 3 | `#2B1B1624`, blur 16, y 6 | Sticky action, menu |
| `elevation.high` | 6 | `#0D0A0933`, blur 28, y 12 | Dialog dan modal sheet |

Dark mode menggunakan elevation melalui surface yang lebih terang dan border; kurangi shadow karena tidak terbaca baik pada latar gelap.

---

## 8. Iconography

- Gunakan **Material Symbols Rounded** atau ikon Material rounded yang tersedia konsisten di Flutter.
- Gaya default: outlined/rounded; gunakan filled hanya untuk selected state atau status yang membutuhkan penekanan.
- Ukuran standar: 20 dp untuk inline, 24 dp untuk aksi/navigasi, 32 dp untuk empty-state supporting icon.
- Stroke dan optical weight ikon dalam satu area harus konsisten.
- Ikon yang tidak universal wajib disertai label atau tooltip.
- Jangan menggunakan emoji sebagai ikon antarmuka.
- Jangan mencampur paket ikon tanpa kebutuhan produk yang kuat.
- Ikon dekoratif harus dikeluarkan dari semantic tree; ikon aksi wajib memiliki semantic label.

---

## 9. Imagery

Foto kemasan kopi adalah aset utama dan harus terasa autentik.

### Prinsip

- Utamakan foto kemasan yang diambil pengguna atau gambar produk yang jelas.
- Pertahankan warna asli foto; jangan beri filter cokelat global.
- Gunakan crop `cover` untuk card dan `contain` bila seluruh label kemasan perlu dibaca.
- Rasio default library card: **4:5**. Thumbnail list: **1:1**. Hero detail dapat memakai **4:3** atau **3:4** sesuai isi foto.
- Terapkan radius sesuai container dan selalu gunakan `clipBehavior` yang benar.
- Gunakan placeholder `surfaceSubtle` dengan ikon outline kemasan/kopi yang tenang.
- Sediakan fallback saat gambar gagal dimuat; jangan biarkan area kosong atau menampilkan ikon error teknis.
- Overlay teks di atas foto hanya diperbolehkan bila kontras minimum tetap terpenuhi melalui scrim yang konsisten.

### Hindari

- Stock photo latte/café sebagai dekorasi umum.
- Foto biji kopi yang diulang sebagai pola latar.
- Gradient dekoratif berat, vignette dramatis, atau filter vintage.
- Gambar AI yang menyerupai produk pengguna tanpa label bahwa gambar bersifat ilustratif.

---

## 10. Buttons

Semua tombol harus memiliki tinggi minimum 48 dp dan target sentuh minimum 48 × 48 dp.

### `DailyPrimaryButton`

- Aksi utama tunggal dalam satu konteks.
- Background `color.primary`, konten `color.onPrimary`.
- Radius `radius.medium`; horizontal padding 20 dp.
- Boleh memakai leading icon 20 dp.
- Satu layar idealnya hanya memiliki satu primary action yang dominan.

### `DailySecondaryButton`

- Aksi penting sekunder.
- Background transparan atau `color.surface`; border `color.borderStrong`.
- Teks dan ikon `color.primary`.

### `DailyTextButton`

- Aksi tersier, aksi dalam dialog, atau tautan internal.
- Tanpa container permanen; gunakan `color.primary`.
- Tetap mempertahankan target sentuh minimum.

### `DailyIconButton`

- Untuk aksi yang maknanya universal: back, close, favorite, more.
- Visual icon 24 dp; target sentuh minimum 48 dp.
- Tooltip dan semantic label wajib.

### `DailyFloatingActionButton`

- Digunakan hanya untuk aksi utama “tambah kopi” jika pola layar memerlukannya.
- Jangan tampilkan bersamaan dengan primary bottom action yang melakukan aksi sama.

### States

- `pressed`: gunakan `primaryPressed` atau overlay on-color 12%.
- `focused`: focus ring 2 dp menggunakan `focusRing`.
- `disabled`: tidak interaktif; foreground 38% dan background 12% dari warna teks pada surface.
- `loading`: pertahankan lebar tombol, nonaktifkan tap, tampilkan progress kecil serta label yang relevan bila ruang cukup.

---

## 11. Inputs

Gunakan `DailyTextField` sebagai wrapper standar untuk semua input teks.

- Tinggi minimum single-line: 56 dp.
- Background `color.surface`; border 1 dp `color.border`; radius `radius.medium`.
- Label selalu tersedia dan tidak hanya mengandalkan placeholder.
- Focused border: 2 dp `color.primary`.
- Error border dan helper: `color.error`; sertakan pesan yang menjelaskan cara memperbaiki.
- Helper/counter memakai `type.caption` dan `textSecondary`.
- Leading/trailing icon 20–24 dp; trailing action memiliki target sentuh 48 dp.
- Required field diberi penanda teks yang dapat dipahami, bukan warna saja.
- Gunakan keyboard type, input action, autofill hint, capitalization, dan validation yang sesuai.
- Jangan memvalidasi agresif saat pengguna baru mulai mengetik. Validasi setelah blur atau submit, kecuali format real-time memang membantu.

Komponen terkait:

- `DailySearchField` — search icon, clear action, debounce pada logic layer.
- `DailySelectField` — tampilan konsisten dengan text field; membuka sheet/dialog pilihan.
- `DailyMultilineField` — minimal 3 baris, tumbuh sampai batas yang masuk akal.
- `DailyPhotoInput` — preview, aksi ambil/ganti/hapus, dan status pemrosesan yang jelas.

---

## 12. Chips and Badges

### `DailyFilterChip`

- Untuk filter yang dapat dipilih/dilepas.
- Tinggi 36–40 dp; radius `full`.
- Unselected: `surface`, border `border`.
- Selected: background primary 12%, border `primary`, teks `primary`.
- Selected state wajib memiliki perubahan selain warna, misalnya check icon.

### `DailyTagChip`

- Untuk atribut pasif seperti process, varietas, atau tasting note.
- Tidak tampak interaktif jika memang tidak dapat ditekan.
- Background `surfaceSubtle`, teks `textSecondary`.

### `DailyStatusBadge`

- Untuk status singkat seperti “Diproses”, “Berhasil dipindai”, atau “Perlu dilengkapi”.
- Gunakan warna status semantik dan icon/label yang sesuai.
- Badge tidak boleh menjadi satu-satunya tempat informasi penting muncul.

Jaga label chip tetap singkat. Hindari lebih dari dua baris chip pada card; tampilkan ringkasan `+N` bila diperlukan.

---

## 13. Cards

Card adalah pengelompokan informasi, bukan dekorasi. Jangan membungkus setiap elemen dalam card.

### `CoffeeLibraryCard`

- Menampilkan foto, nama kopi, roastery, dan maksimal dua metadata utama.
- Image 4:5; radius card `large`.
- Surface `color.surface`; gunakan border `color.border`, elevation default `none`.
- Seluruh card dapat ditekan dengan semantic label yang lengkap.
- Aksi tambahan tidak boleh mengganggu area tap utama.

### `CoffeeListCard`

- Untuk tampilan list padat: thumbnail 72–88 dp, konten utama, optional trailing action.
- Tinggi mengikuti konten dan text scaling; jangan hard-code tinggi yang memotong teks.

### `JournalEntryCard`

- Menekankan tanggal, metode seduh, rating/catatan, dan hubungan dengan kopi.
- Tasting notes tampil sebagai ringkasan, bukan seluruh catatan panjang.

### `InfoSectionCard`

- Mengelompokkan detail yang saling berkaitan.
- Gunakan judul section dan key-value layout sederhana.
- Bila pemisahan sudah jelas melalui spacing, card boleh menjadi borderless.

### Interaction

- Pressed state: overlay 6–8% dan perubahan ringan pada border.
- Jangan mengubah ukuran card saat ditekan.
- Swipe action hanya digunakan jika mudah ditemukan dan tersedia alternatif eksplisit.

---

## 14. Navigation Styling Principles

- Gunakan pola navigasi Android yang familiar dan selaras dengan Material 3, tetapi terapkan token Daily Coffee.
- Bottom navigation digunakan bila ada 3–5 destinasi tingkat atas yang setara.
- Navigation bar memakai `surface`; item aktif menggunakan `primary`, item tidak aktif `iconSecondary`/`textSecondary`.
- Selected state harus terlihat dari ikon dan label, bukan warna saja.
- App bar tenang, tanpa shadow default; gunakan perubahan surface atau divider saat konten di-scroll.
- Judul layar rata kiri dan menggunakan `headlineMedium` atau `titleLarge` sesuai hierarki.
- Tombol back mengikuti perilaku platform dan tidak diganti dengan gestur khusus.
- Bottom sheet digunakan untuk pilihan singkat atau aksi kontekstual; bukan untuk alur panjang multi-step tanpa alasan.
- Dialog hanya untuk keputusan penting, konfirmasi destructive, atau informasi yang harus diselesaikan sebelum lanjut.
- Floating action button tidak boleh menutupi konten atau navigation bar.
- Pertahankan state tab, posisi scroll, dan filter ketika pengguna berpindah destinasi utama jika masuk akal.

---

## 15. Feedback and Interaction States

Setiap komponen interaktif harus mendukung keadaan berikut bila relevan:

- `default`
- `hovered` (desktop/web readiness, tidak menjadi prioritas Android)
- `focused`
- `pressed`
- `selected`
- `disabled`
- `loading`
- `success`
- `error`

### Feedback rules

- Gunakan ripple/ink response yang mengikuti radius komponen.
- Feedback tap harus langsung; proses lambat harus beralih ke loading dalam ±100 ms.
- Gunakan snackbar untuk hasil aksi singkat dan dapat dibatalkan, misalnya “Kopi dihapus” + “Urungkan”.
- Gunakan inline feedback untuk error form atau status pemrosesan foto.
- Toast bukan pola utama karena kurang aksesibel dan sulit dikendalikan.
- Aksi destructive wajib menggunakan `color.error`, label yang spesifik, dan konfirmasi jika tidak mudah dipulihkan.
- Haptic ringan boleh digunakan untuk keberhasilan scan atau perubahan penting, tetapi bukan pada setiap tap.

### Motion

- Durasi cepat: 100–150 ms untuk pressed/selection.
- Durasi standar: 200–250 ms untuk transition komponen.
- Durasi kompleks: maksimal 300–400 ms untuk sheet atau perubahan layout.
- Gunakan easing standar Material yang natural.
- Hormati pengaturan reduce motion platform. Jangan memakai parallax atau animasi loop dekoratif.

---

## 16. Empty, Loading, and Error States

### Empty state

Empty state harus menjelaskan konteks dan menawarkan langkah berikutnya.

- Ikon/ilustrasi sederhana, maksimal 96 dp dan tidak lebih dominan dari pesan.
- Headline singkat dengan Lora bila sesuai.
- Body menjelaskan manfaat atau alasan keadaan kosong.
- Satu primary action yang relevan, misalnya “Tambahkan kopi pertama”.
- Jangan menyalahkan pengguna atau memakai bahasa teknis.

### Loading state

- Untuk initial content, gunakan skeleton yang mengikuti struktur konten akhir.
- Skeleton memakai `surfaceSubtle` dengan animasi lembut; jangan membuat shimmer yang terlalu terang.
- Untuk aksi lokal, gunakan progress di komponen pemicu dan pertahankan layout.
- Untuk OCR/pemrosesan foto, tampilkan tahap yang mudah dipahami, misalnya “Membaca label kopi…”.
- Jangan menampilkan spinner tanpa konteks lebih dari beberapa detik.

### Error state

- Jelaskan apa yang gagal dalam bahasa manusia.
- Jika diketahui, berikan tindakan perbaikan yang spesifik.
- Sediakan retry untuk error yang dapat dipulihkan.
- Pertahankan input pengguna ketika submit gagal.
- Error jaringan tidak boleh menghapus data cache yang masih dapat ditampilkan.
- Jangan menampilkan stack trace, kode exception, atau pesan backend mentah.

### Offline state

- Karena koleksi bersifat personal, desain harus mengutamakan akses lokal bila arsitektur mendukungnya.
- Gunakan banner/status ringkas untuk menandai perubahan yang belum tersinkron.
- Jangan memblokir seluruh aplikasi hanya karena jaringan tidak tersedia.

---

## 17. Accessibility

- Target sentuh minimum: **48 × 48 dp**.
- Kontras teks normal minimal **4.5:1**; teks besar dan ikon esensial minimal **3:1**.
- Jangan menyampaikan status hanya melalui warna; tambahkan icon, label, atau pola.
- Semua kontrol memiliki semantic label yang menjelaskan fungsi, bukan hanya nama ikon.
- Urutan fokus harus mengikuti urutan baca visual.
- Dukung TalkBack, keyboard traversal dasar, dan switch access.
- Gabungkan semantic node pada card yang menjadi satu aksi; jangan membuat pembaca layar mengulang metadata tanpa kebutuhan.
- Label input harus tetap tersedia saat nilai terisi.
- Hormati text scale hingga 200%; izinkan komponen bertambah tinggi dan teks membungkus.
- Hindari fixed-height untuk area berisi teks dinamis.
- Berikan alternatif teks untuk foto kopi jika foto membawa informasi penting.
- Pesan error harus diumumkan kepada assistive technology.
- Hormati reduce motion dan pengaturan brightness/theme sistem.
- Jangan memaksa orientasi perangkat kecuali ada alasan teknis yang terdokumentasi.

---

## 18. Responsive and Mobile Rules

Daily Coffee dirancang mobile-first untuk Android.

### Breakpoints

| Kategori | Lebar | Aturan dasar |
|---|---:|---|
| `compact` | `< 600 dp` | Satu kolom, padding 16 dp |
| `medium` | `600–839 dp` | Konten lebih lebar, padding 24 dp, grid 2 kolom bila sesuai |
| `expanded` | `≥ 840 dp` | Maksimum content width dan layout dua panel bila bermanfaat |

### Rules

- Gunakan `SafeArea`/insets dengan benar untuk status bar, navigation bar, dan keyboard.
- Lebar maksimum konten form/detail: 720 dp; pusatkan pada layar besar.
- Lebar maksimum feed/library: 1200 dp.
- Library grid compact: 2 kolom bila lebar dan skala teks memungkinkan; turun ke 1 kolom jika card menjadi terlalu sempit.
- Grid memakai minimum item width, bukan jumlah kolom hard-coded untuk semua perangkat.
- Form tetap satu kolom agar mudah dipindai.
- Pada keyboard terbuka, field aktif dan primary action harus tetap dapat dijangkau.
- Gunakan `LayoutBuilder`, `MediaQuery`, dan constraint-driven layout; jangan mengambil keputusan layout dari model perangkat.
- Jangan mengandalkan ukuran pixel fisik.
- Landscape harus tetap usable, tetapi tidak memerlukan desain desktop mini.

---

## 19. Reusable Component Naming

Gunakan prefix `Daily` untuk komponen design system agar mudah dibedakan dari widget Material mentah dan widget fitur.

### Foundations

- `DailyColors`
- `DailySpacing`
- `DailyRadii`
- `DailyElevation`
- `DailyTypography`
- `DailyTheme`
- `DailyThemeExtension`

### Actions and controls

- `DailyPrimaryButton`
- `DailySecondaryButton`
- `DailyTextButton`
- `DailyIconButton`
- `DailyFloatingActionButton`
- `DailyTextField`
- `DailySearchField`
- `DailySelectField`
- `DailyMultilineField`
- `DailyPhotoInput`
- `DailyFilterChip`
- `DailyTagChip`
- `DailyStatusBadge`

### Content and layout

- `CoffeeLibraryCard`
- `CoffeeListCard`
- `JournalEntryCard`
- `InfoSectionCard`
- `DailySectionHeader`
- `DailyEmptyState`
- `DailyErrorState`
- `DailyLoadingSkeleton`
- `DailySnackbar`
- `DailyBottomSheet`

Aturan penamaan:

- Komponen umum design system memakai prefix `Daily`.
- Komponen domain memakai nama objek dan tujuan, misalnya `CoffeeLibraryCard`, bukan `CustomCard2`.
- Hindari nama berdasarkan tampilan semata seperti `BrownButton` atau `RoundedBox`.
- Variant dinyatakan melalui enum/property yang terbatas, bukan duplikasi widget tanpa kebutuhan.

---

## 20. Flutter Implementation Rules

### Theme architecture

- Gunakan Material 3: `ThemeData(useMaterial3: true)`.
- Definisikan light dan dark `ColorScheme` dari token pada dokumen ini.
- Letakkan token tambahan dalam immutable `ThemeExtension`, bukan global mutable state.
- Akses token semantik melalui `Theme.of(context)` atau extension pada `BuildContext`.
- Jangan menulis nilai hex, spacing, radius, shadow, atau text style langsung di feature widget.
- Gunakan `ThemeMode.system` sebagai default; pilihan pengguna dapat ditambahkan tanpa mengubah token.

### Suggested structure

```text
lib/
└── core/
    └── design_system/
        ├── theme/
        │   ├── daily_colors.dart
        │   ├── daily_spacing.dart
        │   ├── daily_radii.dart
        │   ├── daily_typography.dart
        │   ├── daily_theme_extension.dart
        │   └── daily_theme.dart
        └── components/
            ├── buttons/
            ├── inputs/
            ├── cards/
            ├── feedback/
            └── navigation/
```

Struktur boleh menyesuaikan arsitektur proyek, tetapi kepemilikan token dan komponen harus tetap terpusat.

### Engineering rules

- Gunakan `const` constructor jika memungkinkan.
- Gunakan `EdgeInsetsDirectional`, `AlignmentDirectional`, dan API directional lain untuk kesiapan RTL.
- Gunakan semantic widget/label pada kontrol kustom.
- Gunakan `InkWell`/`InkResponse` di atas ancestor `Material` untuk ripple yang terpotong sesuai radius.
- Jangan membuat gesture target lebih kecil dari 48 dp walau ikon visual hanya 20–24 dp.
- Hindari fixed height pada widget dengan teks; gunakan minimum constraints.
- Pisahkan visual state dari business state. Komponen design system tidak boleh mengetahui repository, OCR service, atau state-management feature.
- Widget component menerima data dan callback yang eksplisit; jangan mengambil provider global secara tersembunyi.
- Gunakan format locale-aware untuk tanggal, angka, dan unit.
- Semua asset memiliki fallback dan error handling.
- Tambahkan widget test untuk state penting komponen: default, disabled, loading, error, text scaling, light, dan dark.
- Gunakan golden test untuk komponen inti jika pipeline proyek mendukungnya.
- Uji pada ukuran compact dan medium serta text scale besar sebelum sebuah komponen dianggap selesai.

### Token mapping guidance

- `color.background` → `ColorScheme.surface`/scaffold background sesuai kebutuhan tema.
- `color.primary` → `ColorScheme.primary`.
- `color.onPrimary` → `ColorScheme.onPrimary`.
- `color.error` → `ColorScheme.error`.
- Token yang tidak terwakili langsung di `ColorScheme` → `DailyThemeExtension`.
- Type scale dipetakan ke `TextTheme`, sambil mempertahankan pembagian font Lora dan Inter.

Jangan memaksakan mapping yang menghilangkan makna semantik. Dokumentasikan mapping akhir di file tema.

---

## 21. AI Coding Assistant Guardrails

Instruksi berikut bersifat wajib bagi AI yang membuat atau mengubah UI Daily Coffee.

### Wajib dilakukan

1. Baca dokumen ini sebelum mengimplementasikan UI.
2. Gunakan token dan reusable component yang sudah tersedia.
3. Periksa light mode, dark mode, loading, empty, error, disabled, dan text scaling bila relevan.
4. Pertahankan arah produk sebagai personal coffee library/journal.
5. Gunakan terminologi domain kopi secara konsisten dengan model produk.
6. Buat UI adaptif berdasarkan constraint, bukan perangkat tertentu.
7. Jelaskan dan dokumentasikan bila requirement memang membutuhkan pengecualian design system.

### Dilarang tanpa alasan yang terdokumentasi

- Menginvent warna, opacity, spacing, radius, shadow, text style, atau breakpoint baru.
- Menulis hex color atau angka styling acak langsung di screen/feature widget.
- Mengganti font, icon family, atau style visual karena preferensi pribadi.
- Membuat komponen baru jika komponen design system yang ada dapat diperluas secara aman.
- Mengubah aplikasi menjadi visual coffee shop/e-commerce.
- Menambahkan harga, cart, promo banner, loyalty points, atau CTA pembelian tanpa requirement produk.
- Menggunakan gradient, glassmorphism, neon, shadow berat, atau animasi dekoratif sebagai improvisasi.
- Menggunakan pure white/pure black sebagai background utama.
- Mengandalkan placeholder sebagai pengganti label input.
- Mengandalkan warna saja untuk status.
- Mengorbankan accessibility demi kemiripan visual.

### Prosedur ketika token belum tersedia

Jika kebutuhan nyata tidak dapat dipenuhi oleh token yang ada:

1. Coba komposisi token yang tersedia terlebih dahulu.
2. Pastikan kebutuhan bukan variasi visual yang tidak penting.
3. Usulkan token baru dengan nama semantik, tujuan, light/dark value, dan contoh penggunaan.
4. Periksa kontras serta dampak pada komponen lain.
5. Tambahkan token ke dokumen dan implementasi tema **sebelum** memakainya pada screen.

Jangan membuat nilai lokal sementara yang akhirnya menjadi pola permanen.

---

## 22. Definition of Done for UI Components

Sebuah komponen dianggap siap digunakan jika:

- Menggunakan token, bukan nilai styling acak.
- Berfungsi di light dan dark mode.
- Memiliki semua interaction state yang relevan.
- Mendukung text scaling dan target sentuh minimum.
- Memiliki semantics/label yang sesuai.
- Tidak terikat pada business logic fitur.
- Menangani konten panjang, kosong, dan gagal bila relevan.
- Sudah diperiksa pada ukuran layar compact dan medium.
- Nama dan API komponen menjelaskan tujuan, bukan hanya penampilannya.
- Tidak menyimpang dari arah specialty coffee journal/personal library.

---

## 23. Final Design Check

Sebelum menyetujui sebuah layar, tanyakan:

1. Apakah ini terasa seperti jurnal dan koleksi pribadi, bukan toko kopi?
2. Apakah konten kopi lebih dominan daripada dekorasi UI?
3. Apakah hierarki informasi dapat dipahami dalam beberapa detik?
4. Apakah warna, type, spacing, radius, dan komponen berasal dari token?
5. Apakah tampilan tetap hangat, tenang, dan premium di light maupun dark mode?
6. Apakah layar dapat digunakan dengan TalkBack, text scaling, dan target sentuh yang layak?
7. Apakah empty, loading, error, dan offline state sudah dipikirkan?
8. Apakah ada gaya baru yang diciptakan tanpa alasan produk yang jelas?

Jika jawaban terakhir adalah “ya”, kembali gunakan sistem yang ada atau dokumentasikan alasan pengecualiannya.
