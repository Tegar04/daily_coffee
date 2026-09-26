# Daily Coffee — Product Requirements Document

> **Document type:** Product Requirements Document (PRD)  
> **Status:** Draft baseline untuk MVP  
> **Product:** Daily Coffee  
> **Primary platform:** Flutter untuk Android  
> **Primary language:** Bahasa Indonesia  
> **Product direction:** Specialty coffee journal dan personal coffee library  
> **Related documents:** [`DESIGN_SYSTEM.md`](./DESIGN_SYSTEM.md) · [`UI_SCREENS.md`](./UI_SCREENS.md)

Dokumen ini adalah sumber kebenaran untuk tujuan produk, ruang lingkup, requirement fungsional, aturan bisnis, kebutuhan data, kualitas, keamanan, privasi, dan kriteria penerimaan Daily Coffee.

`PRODUCT_REQUIREMENTS.md` menjelaskan **apa yang harus dibangun dan mengapa**. Detail visual mengikuti `DESIGN_SYSTEM.md`; struktur layar dan interaksi mengikuti `UI_SCREENS.md`; keputusan library, database, provider OCR, struktur kode, dan deployment harus dijelaskan pada dokumen arsitektur teknis terpisah.

---

## 1. Document Control

### 1.1 Authority order

Jika ditemukan konflik antardokumen, gunakan urutan berikut:

1. Keputusan produk dan aturan bisnis pada `PRODUCT_REQUIREMENTS.md`.
2. Perilaku layar dan alur pada `UI_SCREENS.md`.
3. Bahasa visual dan component rules pada `DESIGN_SYSTEM.md`.
4. Detail implementasi pada dokumen arsitektur teknis.

Konflik tidak boleh diselesaikan diam-diam oleh developer atau AI coding assistant. Dokumentasikan konflik, tentukan keputusan, lalu perbarui dokumen yang terdampak.

### 1.2 Priority definitions

| Priority | Meaning |
|---|---|
| `Must` | Wajib agar MVP memenuhi tujuan inti dan layak digunakan |
| `Should` | Penting dan direncanakan, tetapi rilis awal masih dapat digunakan tanpa requirement ini |
| `Could` | Peningkatan bernilai setelah fondasi stabil |
| `Won't now` | Sengaja tidak dibangun pada scope ini; bukan berarti ditolak selamanya |

### 1.3 Requirement language

- **Harus** berarti wajib dipenuhi.
- **Sebaiknya** berarti direkomendasikan dan dapat ditunda dengan alasan terdokumentasi.
- **Dapat** berarti opsional.
- Semua requirement bernomor harus dapat dilacak ke implementasi dan pengujian.

---

## 2. Executive Summary

Daily Coffee adalah aplikasi Android untuk menyimpan kopi yang pernah dibeli dan mencatat pengalaman menyeduhnya. Pengguna dapat membuat koleksi kopi, mengambil foto kemasan, memperoleh bantuan ekstraksi informasi dari label, memperbaiki hasilnya, dan menyimpan catatan seduh yang terhubung ke kopi tersebut.

Masalah yang ingin diselesaikan:

- Informasi penting pada kemasan kopi mudah hilang setelah kemasan habis atau dibuang.
- Mencatat roastery, origin, process, variety, roast date, dan tasting notes secara manual terasa melelahkan.
- Catatan resep sering tersebar dan tidak terhubung dengan kopi yang digunakan.
- Pengguna sulit mengingat resep atau pengalaman terbaik dari kopi sebelumnya.
- Aplikasi kopi yang ada sering berorientasi pada pemesanan, penjualan, atau komunitas, bukan arsip pribadi yang tenang.

Solusi Daily Coffee:

- Koleksi kopi pribadi yang dapat digunakan tanpa akun.
- Jalur input manual yang lengkap dan dapat digunakan offline.
- Pembacaan label sebagai bantuan, bukan pengganti keputusan pengguna.
- Jurnal seduh yang terhubung langsung ke coffee record.
- Search, filter, dan sort untuk menemukan kembali kopi dan pengalaman lama.

---

## 3. Product Vision and Positioning

### 3.1 Vision

Menjadi tempat pribadi yang paling mudah dan menyenangkan untuk mengingat kopi yang diminum, memahami preferensi rasa, dan membangun pengetahuan menyeduh dari waktu ke waktu.

### 3.2 Product positioning

Daily Coffee diposisikan sebagai:

```text
Personal Coffee Library
+
Specialty Coffee Journal
+
Assisted Label Capture
```

Daily Coffee tidak diposisikan sebagai:

```text
Coffee Shop
Marketplace
Food Delivery
Public Review Platform
Social Network
```

### 3.3 Product promise

Pengguna dapat menyimpan sebuah kopi secara manual kapan pun, menggunakan foto untuk mempercepat pencatatan, dan tetap memegang kendali penuh atas data yang akhirnya disimpan.

---

## 4. Product Principles

1. **Manual path must always work**  
   Kegagalan kamera, OCR, jaringan, atau permission tidak boleh mencegah pengguna menyimpan kopi secara manual.

2. **User-reviewed truth**  
   Hasil OCR adalah draft. Informasi hanya menjadi data koleksi setelah pengguna meninjau dan menyimpannya.

3. **Local-first usefulness**  
   Koleksi dan jurnal harus tetap dapat dibaca dan dikelola tanpa jaringan pada scope MVP.

4. **Coffee is the subject**  
   Produk memprioritaskan identitas kopi dan pengalaman pengguna, bukan engagement artifisial atau transaksi.

5. **Optional depth**  
   Pengguna dapat menyimpan coffee record minimum dengan cepat, lalu menambahkan detail saat dibutuhkan.

6. **No silent data loss**  
   Error yang dapat dipulihkan tidak boleh membuang foto, form, draft, atau record yang masih valid.

7. **Honest capability**  
   Produk tidak boleh mengklaim OCR, offline, backup, keamanan, atau sinkronisasi yang tidak benar-benar tersedia.

8. **Private by default**  
   Data pribadi tidak dibagikan, dianalisis, atau dikirim ke layanan eksternal tanpa kebutuhan dan penjelasan yang sah.

---

## 5. Goals and Non-Goals

### 5.1 MVP goals

| ID | Goal | Success signal |
|---|---|---|
| `G-01` | Memungkinkan pengguna menyimpan kopi dengan cepat | Coffee record dapat dibuat melalui input manual lengkap |
| `G-02` | Mengurangi pekerjaan input melalui foto | Foto dapat diproses menjadi draft field yang dapat direview |
| `G-03` | Menjaga data hasil ekstraksi tetap akurat menurut pengguna | Tidak ada hasil OCR yang disimpan tanpa review eksplisit |
| `G-04` | Menghubungkan kopi dengan pengalaman seduh | Journal entry selalu mempunyai coffee reference yang valid |
| `G-05` | Membuat arsip mudah ditemukan kembali | Search, filter, dan sort bekerja pada data koleksi |
| `G-06` | Menjaga fungsi inti tersedia offline | Koleksi, input manual, dan jurnal bekerja tanpa jaringan |
| `G-07` | Memberikan pengalaman Android yang tenang dan accessible | Requirement accessibility dan quality gate terpenuhi |

### 5.2 Non-goals for MVP

- Menjual kopi atau perlengkapan seduh.
- Menampilkan harga, promosi, diskon, cart, checkout, atau pembayaran.
- Membuat profil publik, follower, comment, like, atau social feed.
- Membuat rating publik atau ranking roastery.
- Mewajibkan login atau account.
- Menyediakan cloud sync lintas perangkat.
- Menyediakan brew timer lengkap.
- Mengelola inventory secara otomatis.
- Memberikan rekomendasi medis, nutrisi, atau konsumsi kafein.
- Menjamin OCR selalu akurat.
- Menggantikan penilaian pengguna dengan AI-generated tasting result.

---

## 6. Target Users

### 6.1 Persona A — Curious Beginner

Pengguna yang mulai membeli specialty coffee dan ingin memahami istilah pada kemasan tanpa harus membuat sistem pencatatan sendiri.

**Needs**

- Penambahan kopi yang tidak terasa rumit.
- Field optional dan penjelasan yang mudah dipahami.
- Cara melihat kembali origin, process, dan tasting notes.

**Pain points**

- Tidak mengenal semua istilah kopi.
- Tidak selalu tahu informasi mana yang perlu dicatat.
- Dapat merasa kewalahan oleh form teknis yang panjang.

### 6.2 Persona B — Regular Home Brewer

Pengguna yang rutin menyeduh manual brew atau espresso dan ingin menghubungkan resep dengan kopi tertentu.

**Needs**

- Mencatat dose, water, temperature, grind, brew time, dan hasil rasa.
- Menemukan resep lama dengan cepat.
- Membandingkan pengalaman dari kopi yang sama secara informal.

**Pain points**

- Catatan tersebar di notes, foto, atau chat.
- Resep kehilangan konteks coffee bean yang digunakan.
- Sulit mengingat konfigurasi terbaik.

### 6.3 Persona C — Coffee Collector

Pengguna yang membeli banyak kopi dari roastery dan origin berbeda.

**Needs**

- Koleksi dengan foto kemasan.
- Search, filter, dan sort.
- Arsip tetap berguna setelah kemasan habis.
- Data yang dapat dipertahankan atau diekspor.

**Pain points**

- Informasi hilang bersama kemasan.
- Banyak coffee record sulit dipindai tanpa struktur.
- Khawatir kehilangan data aplikasi lokal.

### 6.4 Excluded primary audiences

MVP tidak dioptimalkan khusus untuk roastery inventory, café operations, cupping laboratory, green-bean trading, atau kompetisi profesional. Mereka dapat menggunakan aplikasi, tetapi kebutuhan bisnis mereka bukan target utama.

---

## 7. Jobs to Be Done

| ID | Job statement |
|---|---|
| `JTBD-01` | Ketika membeli kopi baru, saya ingin menyimpan kemasan dan informasinya agar dapat ditemukan setelah kemasan habis. |
| `JTBD-02` | Ketika informasi label cukup banyak, saya ingin memfoto kemasan agar tidak perlu mengetik semuanya dari awal. |
| `JTBD-03` | Ketika hasil pembacaan tidak tepat, saya ingin memperbaikinya sebelum masuk ke koleksi. |
| `JTBD-04` | Ketika tidak dapat memakai kamera atau internet, saya tetap ingin menambahkan kopi secara manual. |
| `JTBD-05` | Ketika menyeduh, saya ingin mencatat resep dan rasa agar dapat mengulang hasil yang baik. |
| `JTBD-06` | Ketika melihat kopi lama, saya ingin melihat catatan seduh yang terkait dengannya. |
| `JTBD-07` | Ketika koleksi bertambah, saya ingin mencari berdasarkan nama, roastery, origin, process, atau rasa. |
| `JTBD-08` | Ketika mengganti tema atau memakai accessibility setting, saya ingin aplikasi tetap mudah digunakan. |

---

## 8. Key Product Decisions and Assumptions

Keputusan ini menjadi baseline sampai ada perubahan eksplisit.

| Topic | Baseline decision | Status |
|---|---|---|
| Platform | Android melalui Flutter | Decided |
| Language | Bahasa Indonesia sebagai bahasa awal | Decided |
| Account | Tidak diperlukan pada MVP | Decided |
| Storage | Local-first | Decided |
| Manual entry | Selalu tersedia dan lengkap | Decided |
| OCR role | Asisten pembentuk draft, bukan sumber final | Decided |
| OCR review | Wajib sebelum coffee record disimpan | Decided |
| Photo | Satu foto kemasan utama per coffee record pada MVP | Assumption |
| Journal relation | Setiap entry terhubung ke tepat satu coffee record | Decided |
| Offline | Library, manual entry, edit, dan journal harus tersedia | Decided |
| Cloud sync | Di luar MVP | Decided |
| Export/import | Should-have sebelum penggunaan jangka panjang | Assumption |
| Monetization | Tidak termasuk MVP | Decided |
| Analytics | Tidak wajib; privacy-first jika ditambahkan | Decided |
| OCR implementation | On-device, cloud, atau hybrid belum dipilih | Open |

---

## 9. MVP Scope

### 9.1 Must

- First-launch onboarding singkat.
- Coffee library local-first.
- Tambah coffee record secara manual.
- Ambil atau pilih foto kemasan.
- Proses pembacaan label menjadi draft.
- Review dan edit seluruh hasil pembacaan.
- Lihat, edit, dan hapus coffee record.
- Search, filter, dan sort koleksi.
- Buat, lihat, edit, dan hapus journal entry.
- Hubungan coffee–journal yang konsisten.
- Empty, loading, error, permission, dan offline state.
- Light, dark, dan system theme.
- Accessibility minimum sesuai dokumen desain.

### 9.2 Should

- Draft recovery untuk form panjang dan proses scan.
- Export data dan referensi gambar dalam format terdokumentasi.
- Import data dengan validation yang aman.
- Deteksi kualitas foto dasar sebelum processing jika feasible.
- Undo untuk penghapusan yang dapat dipulihkan.

### 9.3 Could

- Multiple photos per coffee.
- Favorite/pinned coffee.
- Statistik preferensi lokal.
- Recipe template.
- Duplicate detection yang lebih cerdas.
- Backup manual terkompresi.
- Bahasa tambahan.

### 9.4 Won't now

- Account, authentication, dan social login.
- Cloud sync atau web dashboard.
- Marketplace dan payment.
- Social/community features.
- Subscription/paywall.
- Public rating/review.
- AI-generated preference scoring.
- Automatic inventory consumption.
- Wearable integration.

---

## 10. Functional Requirements — Application Foundation

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-APP-001` | Aplikasi harus memuat theme dan local storage sebelum membuka root screen. | Must | `S01` |
| `FR-APP-002` | Aplikasi harus menampilkan onboarding pada first launch dan tidak mengulanginya setelah selesai. | Must | `S02` |
| `FR-APP-003` | Pengguna harus dapat melewati onboarding tanpa memberikan permission. | Must | `S02` |
| `FR-APP-004` | Aplikasi harus menyediakan tiga root destination: Koleksi, Jurnal, dan Pengaturan. | Must | `S03`, `S12`, `S16` |
| `FR-APP-005` | State dan scroll root destination sebaiknya dipertahankan saat berpindah tab. | Should | Navigation shell |
| `FR-APP-006` | Aplikasi harus mendukung theme System, Light, dan Dark. | Must | `S16` |
| `FR-APP-007` | Perubahan theme harus berlaku tanpa restart. | Must | `S16` |
| `FR-APP-008` | Aplikasi harus mengikuti back navigation Android secara konsisten. | Must | Semua screen |
| `FR-APP-009` | Aplikasi tidak boleh membuat artificial loading delay. | Must | `S01`, semua loading |

### Acceptance criteria — application foundation

- First launch yang bersih membuka onboarding, lalu library empty state.
- Launch berikutnya tidak membuka onboarding kembali.
- Theme sudah benar sebelum konten utama dirender dan tidak menghasilkan flash putih pada dark mode.
- Permission kamera tidak diminta saat launch atau onboarding.
- Navigasi root dapat digunakan dengan TalkBack dan label selalu tersedia.

---

## 11. Functional Requirements — Coffee Collection

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-COF-001` | Pengguna harus dapat melihat seluruh coffee record dalam koleksi. | Must | `S03` |
| `FR-COF-002` | Koleksi harus dapat digunakan ketika perangkat offline. | Must | `S03` |
| `FR-COF-003` | Pengguna harus dapat menambahkan coffee record secara manual. | Must | `S09` |
| `FR-COF-004` | Coffee record baru harus mewajibkan nama kopi dan roastery. | Must | `S08`, `S09` |
| `FR-COF-005` | Field selain nama kopi dan roastery harus optional pada MVP. | Must | Coffee form |
| `FR-COF-006` | Pengguna harus dapat membuka detail coffee record. | Must | `S10` |
| `FR-COF-007` | Pengguna harus dapat mengedit semua field coffee record. | Must | `S11` |
| `FR-COF-008` | Pengguna harus dapat mengganti atau menghapus foto kemasan. | Must | `S11` |
| `FR-COF-009` | Pengguna harus dapat menghapus coffee record setelah melihat dampaknya. | Must | `S10` |
| `FR-COF-010` | Aplikasi harus mencegah penyimpanan duplikat akibat double tap pada satu submission. | Must | `S08`, `S09` |
| `FR-COF-011` | Aplikasi harus mempertahankan input ketika save gagal. | Must | `S08`, `S09`, `S11` |
| `FR-COF-012` | Coffee detail harus tetap berguna jika hanya field wajib yang tersedia. | Must | `S10` |
| `FR-COF-013` | Empty collection harus menawarkan aksi tambah kopi. | Must | `S03` |
| `FR-COF-014` | Default sort harus menampilkan record yang baru ditambahkan terlebih dahulu. | Must | `S03` |
| `FR-COF-015` | Aplikasi sebaiknya memulihkan draft manual yang belum selesai setelah interruption. | Should | `S09` |

### Coffee fields

| Field | Type | Required | Validation/product rule |
|---|---|---:|---|
| `name` | Text | Ya | Trim; tidak boleh kosong |
| `roastery` | Text | Ya | Trim; tidak boleh kosong |
| `originCountry` | Text/select | Tidak | Nilai bebas harus tetap didukung |
| `region` | Text | Tidak | Dapat memuat farm/estate/station |
| `producer` | Text | Tidak | Tidak dipaksa menjadi satu taxonomy |
| `process` | Select + custom | Tidak | Custom value diperbolehkan |
| `varieties` | Multi-value | Tidak | Nilai custom diperbolehkan |
| `roastLevel` | Controlled value | Tidak | Daftar terkurasi; dapat berubah melalui keputusan produk |
| `tastingNotes` | Multi-value | Tidak | Tidak boleh dihasilkan sebagai fakta tanpa review |
| `altitude` | Structured text | Tidak | Harus mempertahankan range/unit bila tersedia |
| `roastDate` | Date | Tidak | Locale-aware; future-date rule mengikuti domain decision |
| `purchaseDate` | Date | Tidak | Locale-aware |
| `weightGrams` | Positive number | Tidak | Lebih besar dari nol |
| `personalNote` | Multiline text | Tidak | Tidak boleh hilang saat save gagal |
| `imageReference` | URI/path | Tidak | Menunjuk file yang dapat diakses aplikasi |

### Acceptance criteria — add coffee manually

Given pengguna tidak memiliki jaringan, when pengguna mengisi nama kopi dan roastery lalu menyimpan, then coffee record tersimpan dan dapat dibuka dari library.

Given field wajib kosong, when pengguna menekan simpan, then aplikasi tidak membuat record, menampilkan pesan di dekat field, dan memindahkan fokus ke error pertama.

Given proses save gagal, when error ditampilkan, then seluruh input dan foto tetap tersedia serta pengguna dapat mencoba lagi.

Given pengguna menekan tombol simpan berulang, when submission pertama masih berjalan, then hanya satu record yang dibuat.

---

## 12. Functional Requirements — Camera and Image

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-IMG-001` | Pengguna harus dapat mengambil foto kemasan melalui kamera. | Must | `S06` |
| `FR-IMG-002` | Pengguna harus dapat memilih foto melalui Android system photo picker bila tersedia. | Must | `S05`, `S06` |
| `FR-IMG-003` | Permission kamera hanya boleh diminta ketika pengguna memilih aksi kamera. | Must | `S05`, `S06` |
| `FR-IMG-004` | Sebelum system prompt, aplikasi harus menjelaskan alasan permission kamera. | Must | `S06` |
| `FR-IMG-005` | Jika permission ditolak, aplikasi harus menawarkan galeri dan input manual. | Must | `S06` |
| `FR-IMG-006` | Jika permission ditolak permanen, aplikasi harus menawarkan pembukaan settings dan alternatif non-camera. | Must | `S06` |
| `FR-IMG-007` | Pengguna harus mengonfirmasi foto sebelum foto diproses. | Must | `S06` |
| `FR-IMG-008` | Aplikasi harus mempertahankan orientation foto yang benar. | Must | `S06` |
| `FR-IMG-009` | Format atau file yang tidak dapat dibaca harus menghasilkan error yang dapat dipahami. | Must | `S06` |
| `FR-IMG-010` | Foto thumbnail harus diproses pada ukuran yang sesuai agar list tidak decode gambar resolusi penuh. | Must | `S03`, `S12` |
| `FR-IMG-011` | Aplikasi dapat memperingatkan bila foto terlalu buram atau kecil jika deteksi tersedia. | Could | `S06` |
| `FR-IMG-012` | Pengguna harus tetap dapat melanjutkan ke form manual dengan foto yang dipilih jika OCR gagal. | Must | `S07`, `S09` |

### Image constraints

Nilai teknis final ditentukan pada arsitektur, tetapi implementasi harus:

- Menerima format gambar umum yang dihasilkan camera/photo picker Android.
- Menolak file yang tidak dapat didecode secara aman.
- Menormalisasi orientation untuk preview dan processing.
- Menghindari penyimpanan salinan yang tidak diperlukan.
- Menghapus temporary file ketika tidak lagi dibutuhkan, tanpa menghapus foto yang masih direferensikan coffee record atau draft.
- Membatasi konsumsi memory selama preview dan thumbnail generation.

---

## 13. Functional Requirements — Label Reading/OCR

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-OCR-001` | Aplikasi harus dapat memulai proses pembacaan dari foto yang dikonfirmasi pengguna. | Must | `S07` |
| `FR-OCR-002` | Proses harus menghasilkan draft, bukan langsung membuat coffee record. | Must | `S07`, `S08` |
| `FR-OCR-003` | Pengguna harus dapat melihat dan mengedit seluruh field hasil pembacaan. | Must | `S08` |
| `FR-OCR-004` | Pengguna harus melakukan save eksplisit sebelum draft menjadi coffee record. | Must | `S08` |
| `FR-OCR-005` | Field dengan keyakinan rendah sebaiknya ditandai “Perlu diperiksa” tanpa menampilkan angka confidence mentah. | Should | `S08` |
| `FR-OCR-006` | Field kosong tidak boleh dianggap error kecuali field tersebut wajib. | Must | `S08` |
| `FR-OCR-007` | Jika tidak ada informasi berguna, aplikasi harus menawarkan foto ulang dan input manual. | Must | `S07` |
| `FR-OCR-008` | Jika proses gagal, aplikasi harus mempertahankan foto dan menawarkan retry/manual entry. | Must | `S07` |
| `FR-OCR-009` | Aplikasi tidak boleh menampilkan persentase progress palsu. | Must | `S07` |
| `FR-OCR-010` | Cancel/back tidak boleh membuat coffee record parsial. | Must | `S07` |
| `FR-OCR-011` | Output OCR harus diperlakukan sebagai untrusted input dan dinormalisasi sebelum menjadi draft. | Must | OCR pipeline |
| `FR-OCR-012` | Aplikasi harus menyatakan kebutuhan jaringan sebelum remote processing bila provider memerlukannya. | Must | `S07` |
| `FR-OCR-013` | Jika foto dikirim ke pihak ketiga, aplikasi harus memberi disclosure yang jelas sebelum pengiriman pertama. | Must if applicable | `S06`/`S07` |
| `FR-OCR-014` | Draft scan sebaiknya dapat dipulihkan setelah app interruption. | Should | `S07`, `S08` |

### Target extraction fields

OCR/extraction mencoba menemukan data berikut jika tercetak pada kemasan:

1. Nama kopi atau nama lot.
2. Roastery.
3. Negara asal.
4. Region, farm, estate, washing station, atau cooperative.
5. Producer.
6. Process.
7. Variety/varieties.
8. Roast level jika dinyatakan eksplisit.
9. Tasting notes.
10. Altitude beserta unit/range.
11. Roast date.
12. Net weight.

Tidak semua field harus ditemukan. Sistem dilarang mengarang nilai untuk melengkapi field kosong.

### Normalization requirements

- Pertahankan raw extracted text selama diperlukan untuk debugging/review, sesuai kebijakan privasi.
- Trim whitespace dan karakter OCR yang jelas tidak bermakna.
- Jangan menerjemahkan nama roastery, farm, variety, atau proper noun secara otomatis.
- Jangan mengubah satuan tanpa mempertahankan makna asal.
- Nilai tanggal ambigu harus ditandai untuk review, bukan ditebak diam-diam.
- Multiple candidates tidak boleh dipilih secara acak; gunakan empty/uncertain state atau tampilkan pilihan bila UX mendukung.

### Acceptance criteria — OCR

Given foto berhasil diproses, when extraction selesai, then pengguna tiba di review screen dan belum ada coffee record permanen.

Given hasil memiliki nama kopi yang salah, when pengguna mengubah nama lalu menyimpan, then nilai edit pengguna yang disimpan.

Given proses tidak menemukan teks, when failure state tampil, then foto tetap tersedia dan pengguna dapat memilih foto ulang atau manual entry.

Given remote OCR memerlukan jaringan dan perangkat offline, when scan dimulai, then aplikasi menjelaskan kondisi tersebut tanpa memblokir manual input.

---

## 14. Functional Requirements — Search, Filter, and Sort

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-FIND-001` | Pengguna harus dapat mencari coffee record secara case-insensitive. | Must | `S04` |
| `FR-FIND-002` | Search harus mencakup nama, roastery, origin, region, producer, process, variety, dan tasting notes. | Must | `S04` |
| `FR-FIND-003` | Pengguna harus dapat membersihkan query tanpa otomatis menghapus filter aktif. | Must | `S04` |
| `FR-FIND-004` | Pengguna harus dapat memfilter berdasarkan origin, roastery, process, roast level, dan tasting notes. | Must | `S04` |
| `FR-FIND-005` | Date filter dapat tersedia untuk roast date atau purchase date. | Should | `S04` |
| `FR-FIND-006` | Jumlah filter aktif harus dapat diketahui pengguna. | Must | `S04` |
| `FR-FIND-007` | Pengguna harus dapat mereset seluruh filter. | Must | `S04` |
| `FR-FIND-008` | Sort harus menyediakan baru ditambahkan, terakhir diperbarui, nama A–Z, dan roastery A–Z. | Must | `S04` |
| `FR-FIND-009` | Sort roast date terbaru harus tersedia jika data mendukung. | Should | `S04` |
| `FR-FIND-010` | Empty result harus dibedakan dari empty collection. | Must | `S04` |
| `FR-FIND-011` | Query dan filter harus dipertahankan ketika recoverable search error terjadi. | Must | `S04` |

### Acceptance criteria — discovery

- Pencarian `ethiopia` menemukan record dengan origin Ethiopia tanpa memperhatikan kapitalisasi.
- Search kosong dengan filter aktif tetap menampilkan hasil sesuai filter.
- Clear query tidak menghapus filter.
- Reset filter mengembalikan default library sort dan hasil yang sesuai.
- No result menawarkan clear/reset, bukan CTA tambah kopi pertama.

---

## 15. Functional Requirements — Journal

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-JRN-001` | Pengguna harus dapat melihat journal entry berdasarkan brewed date terbaru. | Must | `S12` |
| `FR-JRN-002` | Pengguna harus dapat membuat journal entry untuk coffee record yang valid. | Must | `S13` |
| `FR-JRN-003` | Coffee, brewed date/time, dan brew method wajib untuk menyimpan entry. | Must | `S13` |
| `FR-JRN-004` | Recipe field lain harus optional. | Must | `S13` |
| `FR-JRN-005` | Pengguna harus dapat melihat detail journal entry. | Must | `S14` |
| `FR-JRN-006` | Pengguna harus dapat mengedit journal entry. | Must | `S15` |
| `FR-JRN-007` | Pengguna harus dapat menghapus journal entry tanpa menghapus coffee record. | Must | `S14` |
| `FR-JRN-008` | Pengguna harus dapat membuat entry dari Coffee Detail dengan coffee sudah dipilih. | Must | `S10`, `S13` |
| `FR-JRN-009` | Jika koleksi kosong, aplikasi harus mengarahkan pengguna menambah kopi sebelum membuat journal entry. | Must | `S12` |
| `FR-JRN-010` | Rating harus bersifat optional dan tidak boleh default ke nilai maksimum. | Must | `S13` |
| `FR-JRN-011` | Brew ratio dapat dihitung dari dose dan water yang valid. | Should | `S13`, `S14` |
| `FR-JRN-012` | Derived ratio tidak menjadi source of truth permanen jika dapat dihitung kembali. | Should | Domain layer |
| `FR-JRN-013` | Aplikasi harus mempertahankan journal input ketika save gagal. | Must | `S13`, `S15` |
| `FR-JRN-014` | Aplikasi sebaiknya mendukung filter journal berdasarkan coffee, method, rating, dan date range. | Should | `S12` |

### Journal fields

| Field | Type | Required | Validation/product rule |
|---|---|---:|---|
| `coffeeId` | Reference | Ya | Harus menunjuk coffee record valid |
| `brewedAt` | Date/time | Ya | Default sekarang; dapat diedit |
| `brewMethod` | Select + custom | Ya | Trim; custom value diperbolehkan |
| `doseGrams` | Decimal | Tidak | Lebih besar dari nol |
| `waterGrams` | Decimal | Tidak | Lebih besar dari nol |
| `waterTemperatureC` | Decimal | Tidak | Validasi range wajar tanpa merusak custom use case |
| `grindSize` | Text/select | Tidak | Dapat berupa deskripsi atau grinder setting |
| `brewTimeSeconds` | Duration | Tidak | Tidak negatif; display `mm:ss` |
| `rating` | Integer | Tidak | 1–5; null jika tidak dinilai |
| `tastingNotes` | Multi-value | Tidak | Nilai custom diperbolehkan |
| `note` | Multiline text | Tidak | Dipertahankan saat error |

### Acceptance criteria — journal

Given setidaknya satu coffee record tersedia, when pengguna mengisi coffee, waktu, dan brew method lalu menyimpan, then entry muncul pada journal dan Coffee Detail.

Given dose 15 g dan water 240 g, when keduanya valid, then UI dapat menampilkan rasio 1:16.

Given entry dihapus, when penghapusan selesai, then coffee record tetap tersedia.

Given coffee record akan dihapus dan memiliki journal entries, when confirmation tampil, then dampak relasi dijelaskan sebelum pengguna melanjutkan.

---

## 16. Functional Requirements — Settings and Data Control

| ID | Requirement | Priority | Related screen |
|---|---|---|---|
| `FR-SET-001` | Pengguna harus dapat memilih theme System, Light, atau Dark. | Must | `S16` |
| `FR-SET-002` | Pengaturan harus menampilkan app version dari package metadata. | Must | `S18` |
| `FR-SET-003` | Aplikasi harus menyediakan halaman data dan storage. | Must | `S17` |
| `FR-SET-004` | Pengguna harus dapat melihat jumlah coffee record dan journal entry. | Must | `S17` |
| `FR-SET-005` | Pengguna harus dapat menghapus seluruh data melalui confirmation yang jelas. | Must | `S17` |
| `FR-SET-006` | Penghapusan seluruh data tidak boleh dipicu oleh satu tap tanpa confirmation. | Must | `S17` |
| `FR-SET-007` | Aplikasi sebaiknya menyediakan export data dalam format terdokumentasi. | Should | `S17` |
| `FR-SET-008` | Aplikasi sebaiknya menyediakan import dengan validation dan conflict policy. | Should | `S17` |
| `FR-SET-009` | Import failure tidak boleh merusak data yang sudah ada. | Must if import exists | `S17` |
| `FR-SET-010` | Aplikasi tidak boleh menampilkan setting yang belum berfungsi. | Must | `S16` |
| `FR-SET-011` | Link legal/privacy hanya boleh tampil jika destination benar-benar tersedia. | Must | `S18` |

---

## 17. Business Rules

| ID | Rule |
|---|---|
| `BR-001` | Coffee record minimum terdiri dari nama kopi dan roastery. |
| `BR-002` | Hasil OCR tidak pernah menjadi coffee record tanpa save eksplisit pengguna. |
| `BR-003` | Semua hasil OCR dapat diedit sebelum disimpan. |
| `BR-004` | Manual entry tersedia terlepas dari status kamera, jaringan, atau OCR. |
| `BR-005` | Journal entry harus terhubung ke tepat satu coffee record yang valid. |
| `BR-006` | Menghapus journal entry tidak menghapus coffee record. |
| `BR-007` | Menghapus coffee record tidak boleh menghasilkan orphan journal entry. |
| `BR-008` | Dampak penghapusan coffee terhadap journal harus dinyatakan sebelum confirmation. |
| `BR-009` | Optional text kosong dinormalisasi menjadi `null`, bukan empty string. |
| `BR-010` | Input whitespace-only dianggap kosong. |
| `BR-011` | Nilai numeric yang mewakili kuantitas harus positif jika diisi. |
| `BR-012` | Rating journal adalah penilaian pribadi dengan range 1–5 dan boleh kosong. |
| `BR-013` | Tasting notes coffee dan tasting notes journal berbeda: yang pertama profil/label, yang kedua pengalaman pengguna. |
| `BR-014` | Coffee profile tidak boleh diubah otomatis berdasarkan journal entry. |
| `BR-015` | Derived values seperti brew ratio dihitung dari source values dan tidak menggantikannya. |
| `BR-016` | Satu submission tidak boleh menghasilkan record ganda akibat repeat tap atau retry yang sama. |
| `BR-017` | Foto sementara hanya dapat dibersihkan jika tidak digunakan oleh record atau recoverable draft. |
| `BR-018` | Tidak ada field yang diisi dengan data rekaan hanya agar tampak lengkap. |

### Coffee deletion policy

Pilihan teknis final perlu ditentukan sebelum implementasi delete. Baseline produk:

- Jika coffee memiliki journal entries, aplikasi harus menampilkan jumlah entry terdampak.
- Implementasi boleh menggunakan cascade delete hanya setelah confirmation yang eksplisit.
- Alternatif yang lebih aman adalah mencegah delete sampai entry ditangani atau memakai soft delete.
- Pilihan final harus konsisten di UI, database, export, dan tests.

**Rekomendasi MVP:** gunakan confirmation eksplisit dengan cascade terkontrol dalam satu transaksi, ditambah undo hanya jika seluruh relasi dapat dipulihkan secara atomik.

---

## 18. Data Requirements

### 18.1 Coffee entity

Minimum logical fields:

```text
Coffee
├── id
├── name
├── roastery
├── originCountry?
├── region?
├── producer?
├── process?
├── varieties[]
├── roastLevel?
├── tastingNotes[]
├── altitude?
├── roastDate?
├── purchaseDate?
├── weightGrams?
├── personalNote?
├── imageReference?
├── createdAt
└── updatedAt
```

### 18.2 Journal entry entity

```text
JournalEntry
├── id
├── coffeeId
├── brewedAt
├── brewMethod
├── doseGrams?
├── waterGrams?
├── waterTemperatureC?
├── grindSize?
├── brewTimeSeconds?
├── rating?
├── tastingNotes[]
├── note?
├── createdAt
└── updatedAt
```

### 18.3 Draft entity/state

Draft boleh disimpan di persistence terpisah dan tidak boleh muncul sebagai coffee/journal permanen.

Draft minimum dapat menyimpan:

- Draft type: manual coffee, scan review, atau journal.
- Field values.
- Temporary image reference.
- Created/updated timestamp.
- OCR status dan normalized result jika relevan.
- Schema/app version untuk recovery/migration.

### 18.4 Referential integrity

- `JournalEntry.coffeeId` harus menunjuk coffee yang ada.
- Write coffee dan related image reference harus konsisten; rollback jika persistence gagal.
- Delete policy harus atomic terhadap coffee dan journal relation.
- Import harus memvalidasi ID collision dan relation sebelum commit.
- Migration database tidak boleh menghapus data tanpa backup/recovery plan yang terdokumentasi.

### 18.5 Date and unit handling

- Timestamp internal disimpan dalam bentuk yang tidak ambigu.
- Display mengikuti locale dan timezone perangkat.
- Brewed time merepresentasikan waktu yang dimaksud pengguna.
- Gram dan Celsius menjadi unit UI awal MVP.
- Raw altitude text dapat mempertahankan unit/range sumber.
- Perubahan unit pada masa depan tidak boleh merusak source value.

### 18.6 Data ownership and lifecycle

- Data yang dibuat pengguna dimiliki pengguna.
- Uninstall dapat menghapus data lokal sesuai perilaku platform; risiko ini harus jujur jika belum ada backup.
- Clear cache tidak boleh menghapus database/record pengguna.
- “Hapus semua data” mencakup record, relasi, draft, dan gambar yang dimiliki aplikasi sesuai copy confirmation.
- Temporary processing artifacts harus dibersihkan setelah tidak direferensikan.

---

## 19. Offline Requirements

| ID | Requirement | Priority |
|---|---|---|
| `NFR-OFF-001` | Library dapat dibuka dan dibaca tanpa jaringan. | Must |
| `NFR-OFF-002` | Coffee manual create/edit/delete dapat dilakukan tanpa jaringan. | Must |
| `NFR-OFF-003` | Journal create/read/edit/delete dapat dilakukan tanpa jaringan. | Must |
| `NFR-OFF-004` | Search/filter/sort local data dapat digunakan tanpa jaringan. | Must |
| `NFR-OFF-005` | Theme/settings lokal dapat digunakan tanpa jaringan. | Must |
| `NFR-OFF-006` | Jika OCR membutuhkan jaringan, hanya fitur OCR yang boleh terblokir. | Must |
| `NFR-OFF-007` | Manual fallback harus tersedia dari offline OCR state. | Must |
| `NFR-OFF-008` | Network failure tidak boleh menghapus cache/data lokal. | Must |

---

## 20. Privacy and Permissions

### 20.1 Privacy principles

- Kumpulkan hanya data yang diperlukan untuk fitur yang digunakan.
- Jangan mengirim coffee, journal, foto, atau usage event ke pihak ketiga tanpa disclosure dan dasar yang jelas.
- Jangan mengaktifkan analytics secara diam-diam jika analytics mengirim data keluar perangkat.
- Jangan menyertakan journal note atau raw OCR text dalam crash log.
- Jangan mencatat filesystem path, image content, atau user-entered text dalam production log tanpa redaction.

### 20.2 Permission requirements

| Permission/capability | Timing | Requirement |
|---|---|---|
| Camera | Saat pengguna memilih ambil foto | Just-in-time rationale dan alternative path |
| Photo selection | Saat pengguna memilih galeri | Gunakan system picker bila tersedia; hindari broad storage permission |
| Internet | Hanya jika OCR/provider memerlukan | Disclosure fungsi dan offline fallback |
| Notification | Tidak dibutuhkan MVP | Jangan diminta |
| Location | Tidak dibutuhkan MVP | Jangan diminta |
| Contacts | Tidak dibutuhkan | Jangan diminta |

### 20.3 External OCR disclosure

Jika foto diproses oleh layanan eksternal, disclosure harus menjelaskan:

- Bahwa gambar dikirim untuk membaca label.
- Pihak/provider atau kategori pihak yang memproses, sesuai kebutuhan kebijakan.
- Tujuan pemrosesan.
- Apakah gambar disimpan oleh provider dan berapa lama, jika diketahui.
- Alternatif manual yang tidak memerlukan pengiriman.
- Link ke privacy policy bila dipublikasikan.

Provider tidak boleh dipilih hanya berdasarkan kualitas ekstraksi; data retention, wilayah pemrosesan, biaya, terms, dan keamanan juga harus dinilai.

---

## 21. Security Requirements

| ID | Requirement | Priority |
|---|---|---|
| `NFR-SEC-001` | API key atau secret tidak boleh ditanam langsung pada aplikasi client. | Must if remote service exists |
| `NFR-SEC-002` | Network request harus menggunakan transport terenkripsi. | Must if network exists |
| `NFR-SEC-003` | OCR result, imported data, dan file metadata harus divalidasi sebagai untrusted input. | Must |
| `NFR-SEC-004` | File path dari import/provider tidak boleh memungkinkan path traversal atau akses di luar scope. | Must |
| `NFR-SEC-005` | Log produksi tidak boleh memuat sensitive user content. | Must |
| `NFR-SEC-006` | Database migration dan write penting harus transactional jika didukung. | Must |
| `NFR-SEC-007` | Export harus dibuat melalui lokasi yang dipilih pengguna dan tidak otomatis dipublikasikan. | Must if export exists |
| `NFR-SEC-008` | Import harus divalidasi sepenuhnya sebelum mengubah data existing. | Must if import exists |
| `NFR-SEC-009` | Error dari service eksternal tidak boleh ditampilkan mentah kepada pengguna. | Must |

Catatan: local-first tidak otomatis berarti encrypted-at-rest. Jika encryption dijanjikan, requirement dan threat model terpisah harus disusun sebelum implementasi.

---

## 22. Accessibility Requirements

| ID | Requirement | Priority |
|---|---|---|
| `NFR-A11Y-001` | Target sentuh minimum 48 × 48 dp. | Must |
| `NFR-A11Y-002` | Kontras teks normal minimal 4.5:1 dan teks besar/icon esensial minimal 3:1. | Must |
| `NFR-A11Y-003` | Informasi/status tidak boleh disampaikan melalui warna saja. | Must |
| `NFR-A11Y-004` | Semua action icon-only harus memiliki semantic label dan tooltip. | Must |
| `NFR-A11Y-005` | Semua core flow harus dapat digunakan dengan TalkBack. | Must |
| `NFR-A11Y-006` | Layout harus usable pada text scaling 200%. | Must |
| `NFR-A11Y-007` | Error validation harus diumumkan dan fokus diarahkan secara tepat. | Must |
| `NFR-A11Y-008` | Urutan fokus mengikuti urutan baca dan hierarki visual. | Must |
| `NFR-A11Y-009` | Motion harus menghormati reduce-motion platform. | Must |
| `NFR-A11Y-010` | Rating dan selected filter harus memiliki semantic state yang jelas. | Must |

Accessibility bukan fase polish. Requirement ini berlaku pada Definition of Done setiap feature.

---

## 23. Performance and Reliability Requirements

Target berikut adalah baseline produk; angka final diuji pada device kelas menengah yang ditentukan pada test plan.

| ID | Requirement | Target/Priority |
|---|---|---|
| `NFR-PERF-001` | Warm launch ke konten lokal usable | Target ≤2 detik, Should |
| `NFR-PERF-002` | Interaksi tap memberi feedback visual | Sekitar ≤100 ms, Must |
| `NFR-PERF-003` | Search lokal terasa responsif untuk koleksi personal normal | Target update ≤300 ms, Should |
| `NFR-PERF-004` | Scrolling library tidak decode foto full-resolution sebagai thumbnail | Must |
| `NFR-PERF-005` | Long-running OCR tidak memblokir UI thread | Must |
| `NFR-PERF-006` | Save harus mencegah duplicate submission | Must |
| `NFR-PERF-007` | Recoverable failure tidak menyebabkan data loss | Must |
| `NFR-PERF-008` | App interruption selama form/scan sebaiknya dapat dipulihkan | Should |
| `NFR-PERF-009` | Crash-free sessions dipantau pada testing/release jika telemetry tersedia | Should |

Tidak ada SLA OCR yang ditetapkan sampai provider/approach dipilih. UI wajib memberikan progress dan fallback yang jujur.

---

## 24. Compatibility and Localization

### Compatibility

- Minimum Android SDK dan supported device range ditentukan dalam arsitektur teknis setelah dependency audit.
- Core flow harus diuji pada ukuran compact dan medium.
- Landscape harus usable walau mobile portrait tetap menjadi fokus.
- Camera, picker, file access, dan permission behavior harus mengikuti versi Android yang didukung.

### Localization

- Seluruh user-facing string harus dikelola melalui localization resource, meskipun MVP hanya Bahasa Indonesia.
- Jangan hard-code string di reusable widget jika seharusnya dilokalkan.
- Tanggal, waktu, angka, dan decimal separator mengikuti locale perangkat.
- Nama roastery, region, farm, process, variety, dan tasting terms tidak diterjemahkan paksa.
- Layout harus siap menghadapi string yang lebih panjang.

---

## 25. Error and Recovery Requirements

| Scenario | Required response | Data preservation |
|---|---|---|
| Local database initialization gagal | Jelaskan masalah dan sediakan retry; jangan reset otomatis | Data existing tidak dihapus |
| Camera tidak tersedia | Tawarkan galeri dan manual entry | Draft existing dipertahankan |
| Camera permission ditolak | Jelaskan alternatif | Tidak ada data hilang |
| File tidak dapat dibaca | Jelaskan file bermasalah dan pilih ulang | Form/draft tetap ada |
| OCR tidak menemukan informasi | Foto ulang atau manual entry | Foto dapat diteruskan ke manual form |
| OCR network failure | Retry atau manual entry | Foto/draft tetap ada |
| Save coffee gagal | Inline/global feedback dan retry | Seluruh input dipertahankan |
| Save journal gagal | Feedback dan retry | Seluruh input dipertahankan |
| Delete gagal | Jelaskan record belum terhapus | Data existing tetap konsisten |
| Import validation gagal | Tampilkan alasan yang aman | Data existing tidak berubah |
| Export gagal | Tawarkan retry/lokasi baru | Data aplikasi tidak berubah |
| App masuk background | Hindari kehilangan input aktif | Pulihkan draft jika feasible |

User-facing error tidak boleh memuat stack trace, SQL error, exception class, raw provider response, atau secret.

---

## 26. Analytics and Success Metrics

Analytics eksternal bukan requirement MVP. Jika ditambahkan, implementasi harus privacy-conscious, minim data, dan tunduk pada disclosure/consent yang berlaku.

### 26.1 Product metrics

| Metric | Purpose | Privacy-safe formulation |
|---|---|---|
| Add coffee completion rate | Mengukur apakah flow terlalu sulit | Event step tanpa coffee text/image |
| Manual vs scan start | Menilai usefulness jalur foto | Enum method saja |
| Scan-to-save completion | Menilai apakah scan membantu | Success/failure, tanpa extracted content |
| Scan fallback rate | Mengetahui kebutuhan perbaikan OCR | Reason category, bukan raw error/photo |
| Journal creation rate | Menilai hubungan koleksi–journal | Count/event tanpa notes |
| Save failure rate | Mengukur reliability | Sanitized error category |
| Crash-free sessions | Release health | Melalui tool yang disetujui dan redacted |
| Accessibility test pass | Quality gate | Test result, bukan user telemetry |

### 26.2 MVP success criteria

Sebelum public MVP dianggap layak:

- Seluruh Must requirement lulus acceptance testing.
- Manual add-coffee flow berfungsi sepenuhnya offline.
- Tidak ada known issue yang menyebabkan silent data loss.
- OCR failure selalu mempunyai manual fallback.
- Coffee dan journal referential integrity tervalidasi.
- Core flow lulus light/dark dan text scale 200%.
- Critical/high severity security issue tidak terbuka.
- Crash/blocker pada core flow telah ditangani.

Nilai target metrik penggunaan tidak ditetapkan sebelum ada baseline pengguna nyata. Jangan menciptakan angka keberhasilan tanpa data.

---

## 27. Release Phases

### Phase 1 — Foundation

**Outcome:** aplikasi dapat dibuka, bernavigasi, menggunakan theme, dan menyimpan data lokal dengan fondasi yang dapat diuji.

- Design tokens dan reusable components.
- Navigation shell.
- Coffee/journal domain model.
- Local persistence dan migration strategy.
- Error model.
- Localization foundation.

### Phase 2 — Manual Coffee Collection

**Outcome:** pengguna dapat membangun koleksi tanpa kamera atau jaringan.

- Library.
- Manual add.
- Detail.
- Edit/delete.
- Search/filter/sort dasar.
- Empty/loading/error states.

### Phase 3 — Journal

**Outcome:** pengguna dapat menghubungkan pengalaman seduh dengan kopi.

- Journal list.
- Add/detail/edit/delete entry.
- Coffee-to-journal navigation.
- Recipe validation dan derived ratio.

### Phase 4 — Photo and Label Reading

**Outcome:** foto mempercepat input tanpa mengurangi kontrol pengguna.

- Camera/photo picker.
- Permission states.
- Image pipeline.
- OCR/extraction integration.
- Processing and review.
- Retry/manual fallback.
- Privacy disclosure bila remote.

### Phase 5 — Data Control and Hardening

**Outcome:** aplikasi siap digunakan lebih lama dan diuji secara menyeluruh.

- Onboarding final.
- Settings/about/data.
- Draft recovery.
- Export/import bila masuk release target.
- Accessibility audit.
- Performance/reliability testing.
- Security/privacy review.

Setiap phase harus menghasilkan produk yang konsisten; jangan membuat UI placeholder yang terlihat aktif tetapi belum bekerja.

---

## 28. Dependencies

### Product dependencies

- Keputusan final OCR approach.
- Kebijakan privacy dan disclosure jika remote processing digunakan.
- Supported Android versions.
- Export/import scope dan format.
- Coffee deletion policy.
- Sumber curated values untuk process, roast level, brew method, dan optional tasting suggestions.

### Technical dependencies to evaluate separately

- State management.
- Local database.
- Camera/image picker.
- Image normalization/compression.
- OCR engine atau external service.
- Router.
- Localization.
- Crash reporting/analytics jika digunakan.

Pemilihan package tidak dilakukan di PRD. Setiap dependency harus dievaluasi untuk maintenance, license, Android compatibility, privacy, binary size, dan testability.

---

## 29. Risks and Mitigations

| Risk | Impact | Likelihood | Mitigation |
|---|---|---|---|
| OCR tidak akurat pada desain kemasan bervariasi | High | High | Review wajib, uncertainty marking, manual fallback |
| Remote OCR menimbulkan biaya | Medium–High | Medium | Quota, monitoring, compression, provider comparison, on-device evaluation |
| Foto mengandung data yang tidak sengaja ikut tertangkap | High | Medium | Disclosure, crop/review, minimal retention, provider assessment |
| Data lokal hilang saat uninstall/perangkat rusak | High | Medium | Export/backup sebagai Should; copy yang jujur |
| Database migration merusak data | High | Low–Medium | Migration tests, transactions, backup/recovery strategy |
| Foto memenuhi storage | Medium | Medium | Compression, size limits, orphan cleanup, storage summary |
| Form terlalu panjang bagi pemula | Medium | Medium | Required fields minimum, progressive disclosure, optional depth |
| Taxonomy kopi terlalu kaku | Medium | High | Controlled suggestions plus custom values |
| Delete coffee menghapus journal tanpa disadari | High | Medium | Impact count, explicit confirmation, atomic behavior |
| Scope berkembang ke marketplace/social | Medium | Medium | Enforce goals/non-goals dan change control |
| API key diekstrak dari APK | High | High jika key di client | Backend proxy atau on-device solution; jangan embed secret |
| Analytics menangkap user content | High | Low–Medium | Event allowlist, redaction, no notes/photo/raw OCR |

---

## 30. Open Questions

Pertanyaan berikut harus diputuskan sebelum feature terkait dianggap implementation-ready.

### OCR and processing

1. Apakah OCR dilakukan on-device, melalui service sendiri, provider cloud, atau hybrid?
2. Apakah proses hanya OCR text atau juga structured extraction melalui model AI?
3. Apakah pengguna perlu consent eksplisit sebelum setiap upload atau cukup disclosure/consent awal yang jelas?
4. Berapa retention foto pada provider eksternal?
5. Bagaimana quota, rate limit, timeout, retry, dan biaya dikendalikan?
6. Apakah raw OCR text disimpan setelah record dibuat?

### Data and storage

7. Apakah satu coffee hanya mempunyai satu cover photo atau gallery pada versi berikutnya?
8. Apakah coffee deletion melakukan cascade, soft delete, atau block-if-related?
9. Apakah draft otomatis disimpan, dan berapa lama dipertahankan?
10. Apa format export: JSON, ZIP berisi JSON+images, atau format lain?
11. Bagaimana conflict policy saat import data dengan ID sama?
12. Apakah onboarding direset saat “hapus semua data”?

### Product vocabulary

13. Apakah roast level memakai daftar tetap atau custom value?
14. Daftar awal brew method apa saja yang disediakan?
15. Apakah tasting note suggestion memakai taxonomy tertentu atau free-form sepenuhnya?
16. Apakah altitude disimpan structured range atau source text pada MVP?

### Release and distribution

17. Minimum Android version apa yang didukung?
18. Apakah aplikasi akan dipublikasikan ke Play Store atau digunakan secara pribadi terlebih dahulu?
19. Apakah privacy policy diperlukan pada rilis pertama berdasarkan OCR/telemetry yang dipilih?
20. Apakah analytics/crash reporting eksternal digunakan?

Open question tidak menghalangi pengerjaan phase sebelumnya jika tidak menjadi dependency langsung.

---

## 31. Requirement Traceability

| Product area | Requirement family | Primary UI screens | Primary validation |
|---|---|---|---|
| App foundation | `FR-APP-*` | `S01`, `S02`, navigation shell | Launch/navigation/widget tests |
| Coffee collection | `FR-COF-*`, `BR-*` | `S03`, `S09`, `S10`, `S11` | Repository, validation, widget, integration tests |
| Images | `FR-IMG-*` | `S05`, `S06` | Permission/file/image tests |
| OCR | `FR-OCR-*` | `S07`, `S08` | Pipeline contract, failure, privacy, integration tests |
| Search/filter | `FR-FIND-*` | `S04` | Query/filter unit and UI tests |
| Journal | `FR-JRN-*` | `S12`–`S15` | Relation, calculation, CRUD tests |
| Settings/data | `FR-SET-*` | `S16`–`S18` | Preference, destructive flow, import/export tests |
| Offline | `NFR-OFF-*` | Core flows | Network-disabled integration tests |
| Accessibility | `NFR-A11Y-*` | Semua screen | Semantics, contrast, text scale, manual audit |
| Security | `NFR-SEC-*` | Data/OCR/import/export | Static review, validation, threat checks |
| Performance | `NFR-PERF-*` | Launch/list/search/OCR | Profiling and device tests |

Implementation ticket sebaiknya mencantumkan ID requirement yang dipenuhi. Test name atau test documentation juga sebaiknya mencantumkan ID penting untuk menjaga traceability.

---

## 32. Change Control

Perubahan berikut memerlukan review produk dan pembaruan PRD:

- Menambah account atau cloud sync.
- Mengirim foto/data ke provider baru.
- Mengubah field wajib.
- Mengubah hubungan coffee–journal.
- Mengubah delete/retention policy.
- Menambah monetisasi, marketplace, atau social feature.
- Menambah permission Android.
- Mengubah klaim offline/private.
- Menambah analytics yang mengirim data keluar perangkat.
- Mengubah target pengguna atau positioning produk.

Perubahan UI kecil yang tidak mengubah requirement tetap harus mengikuti `DESIGN_SYSTEM.md` dan `UI_SCREENS.md`.

---

## 33. Global Definition of Done

Sebuah requirement atau feature dianggap selesai jika:

- Behavior memenuhi requirement ID dan acceptance criteria terkait.
- UI mengikuti `UI_SCREENS.md` dan `DESIGN_SYSTEM.md`.
- Happy path serta relevant empty/loading/error/offline/permission states tersedia.
- Data validation dan business rules dijalankan pada layer yang memiliki authority, bukan hanya melalui UI.
- Tidak terjadi silent data loss pada failure yang dapat dipulihkan.
- Duplicate submission dicegah.
- Light, dark, compact, medium, keyboard-open, dan text scale 200% diperiksa jika relevan.
- TalkBack semantics tersedia untuk core interaction.
- Unit/integration/widget tests sebanding dengan risiko feature.
- Privacy dan security implication telah ditinjau.
- Tidak ada secret, raw exception, atau user content sensitif dalam log.
- Dokumentasi diperbarui bila ada keputusan baru.
- Tidak ada affordance yang terlihat aktif tetapi belum bekerja.

---

## 34. MVP Release Acceptance Checklist

### Product integrity

- [ ] Aplikasi tetap jelas sebagai personal coffee library dan journal.
- [ ] Tidak ada marketplace, cart, promo, atau social feature yang tidak diminta.
- [ ] Manual add flow lengkap dan tidak bergantung jaringan.
- [ ] Hasil OCR selalu direview sebelum menjadi record.

### Coffee collection

- [ ] Add, read, edit, dan delete coffee berfungsi.
- [ ] Nama kopi dan roastery divalidasi.
- [ ] Optional field tidak menghalangi save.
- [ ] Foto dapat ditambah, diganti, dan ditampilkan secara aman.
- [ ] Search, filter, dan sort menghasilkan data yang benar.
- [ ] Empty collection dan filtered-empty dibedakan.

### OCR and fallback

- [ ] Camera dan gallery flow berfungsi pada Android yang didukung.
- [ ] Permission ditangani just-in-time.
- [ ] Scan success menghasilkan draft.
- [ ] No-text, timeout, offline, dan provider failure memiliki fallback.
- [ ] Foto/draft tidak hilang pada recoverable error.
- [ ] Disclosure eksternal tersedia jika foto meninggalkan perangkat.

### Journal

- [ ] Add, read, edit, dan delete journal berfungsi.
- [ ] Entry selalu memiliki coffee reference valid.
- [ ] Recipe optional dapat dibiarkan kosong.
- [ ] Rating tidak mempunyai default menyesatkan.
- [ ] Coffee deletion menjaga referential integrity.

### Data quality and safety

- [ ] Double tap tidak membuat duplicate record.
- [ ] Save failure mempertahankan input.
- [ ] Database migration diuji.
- [ ] Temporary/orphan image cleanup aman.
- [ ] “Hapus semua data” memerlukan confirmation jelas.
- [ ] Export/import diuji jika disertakan dalam release.

### Quality

- [ ] Core flow berfungsi offline.
- [ ] Light, dark, dan system theme lulus pemeriksaan.
- [ ] Text scale 200% tidak memotong fungsi utama.
- [ ] TalkBack dapat menyelesaikan core flow.
- [ ] Tidak ada known critical/high security issue.
- [ ] Tidak ada known silent-data-loss issue.
- [ ] Performance diuji pada device target.
- [ ] Seluruh Must requirement dapat dilacak ke test atau verification evidence.

---

## 35. AI Coding Assistant Guardrails

AI coding assistant yang menggunakan PRD ini wajib:

1. Memperlakukan requirement bernomor sebagai kontrak produk.
2. Membaca dokumen terkait sebelum mengimplementasikan feature.
3. Membedakan keputusan final, assumption, dan open question.
4. Tidak mengubah open question menjadi keputusan tanpa persetujuan.
5. Menyebutkan requirement ID pada rencana implementasi dan pengujian.
6. Mengimplementasikan business rule pada authoritative layer, bukan hanya widget validation.
7. Mempertahankan manual fallback untuk semua flow OCR.
8. Mempertahankan user input pada recoverable failure.
9. Menggunakan data dummy hanya pada test/preview yang jelas, bukan production state.
10. Melaporkan verification gap secara jujur.

AI coding assistant dilarang:

- Menambah fitur di luar scope hanya karena umum pada aplikasi lain.
- Menganggap provider, package, API, atau database tertentu sudah dipilih.
- Menanam API key atau secret dalam Flutter client.
- Mengirim gambar atau user content tanpa disclosure yang diwajibkan.
- Menyimpan output OCR langsung sebagai record permanen.
- Menghapus data/draft sebagai cara menangani error.
- Mengarang coffee information yang tidak ditemukan.
- Menganggap local-first sama dengan encrypted atau backed up.
- Menyebut feature selesai hanya berdasarkan tampilan tanpa menguji data rule dan failure state.

Jika implementasi membutuhkan keputusan produk baru, AI harus berhenti pada batas tersebut, menjelaskan pilihan dan trade-off secara ringkas, lalu meminta keputusan sebelum menetapkan pola permanen.

---

## 36. Recommended Next Documentation

Setelah PRD disetujui, dokumen berikut yang paling berguna adalah:

1. `TECHNICAL_ARCHITECTURE.md`  
   State management, layer architecture, local database, routing, repository boundaries, error model, dan testing strategy.

2. `OCR_TECHNICAL_DECISION.md`  
   Perbandingan on-device, cloud, dan hybrid; privacy; biaya; akurasi; latency; serta proof-of-concept acceptance criteria.

3. `DATA_MODEL.md`  
   Schema final, relation, indexes, migrations, deletion behavior, draft, export, dan import contract.

4. `MVP_IMPLEMENTATION_PLAN.md`  
   Milestone, dependency order, requirement traceability, dan definition of done per task.

Dokumen teknis tidak boleh mengubah scope atau business rules dalam PRD tanpa change control.
