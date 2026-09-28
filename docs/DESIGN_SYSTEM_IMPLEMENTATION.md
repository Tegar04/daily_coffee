# Implementasi design system — Phase 3

Phase mengikuti urutan `progress.md`. Nomor phase pada roadmap ringkas di
`ARCHITECTURE.md` bukan nomor tracker implementasi.

## Kepemilikan dan pemakaian

- Import komponen umum dari `package:daily_coffee/core/design_system/design_system.dart`.
- `theme/daily_theme_extension.dart` memiliki seluruh warna semantik light/dark,
  immutable `copyWith`/`lerp`, dan accessor `context.dailyColors`.
- `theme/daily_tokens.dart` memiliki spacing, radius, elevation/shadow, ukuran,
  opacity, responsive breakpoint, dan durasi motion.
- `DailyTheme.light`/`dark` menerapkan Material 3. Background dipetakan ke scaffold,
  surface ke Material/card/input/sheet, primary/error ke ColorScheme, dan role
  tambahan tetap tersedia melalui ThemeExtension. `caption` dipetakan ke `bodySmall`.
- `DailyTypography` memakai Inter untuk UI dan Lora untuk judul editorial.
  Font dan lisensi OFL dibundel di `assets/fonts`; tidak ada runtime font download.
- Bootstrap serta aplikasi memakai `ThemeMode.system`. Pilihan tema yang disimpan
  tetap scope Phase 11. Material localization mendukung `id` dan `en` untuk tanggal,
  dialog, serta kontrol bawaan; copy produk tetap Bahasa Indonesia.
- Komponen umum tidak membaca provider, repository, filesystem, maupun SDK kamera.
  Kartu kopi berada di `features/coffee/presentation/widgets`; kartu jurnal berada
  di `features/journal/presentation/widgets`. Keduanya menerima data presentasi dan
  callback, sehingga belum membutuhkan entity/repository phase berikutnya.

## Komponen tersedia

| Kebutuhan | API |
|---|---|
| Aksi | `DailyPrimaryButton`, `DailySecondaryButton`, `DailyTextButton`, `DailyIconButton` |
| Input | `DailyTextField`, `DailyMultilineField`, `DailySearchField`, `DailySelectField` |
| Pilihan | `DailyFilterChip`, `DailyTagChip`, `DailyStatusBadge`, `ControlledValuePicker` |
| Konten | `DailyCard`, `InfoSectionCard`, `DailyPhoto`, `CoffeeLibraryCard`, `CoffeeListCard`, `JournalEntryCard` |
| Feedback | `DailyEmptyState`, `DailyLoadingState`, `DailyLoadingSkeleton`, `DailyErrorState` |
| Navigasi/modal | `DailyAppBar`, `DailyBottomSheet.show`, `DailyDialog.confirm` |
| Layout | `DailyPageBody`, `DailyAdaptiveGrid` |
| Rating | `DailyRatingInput` |

`DailyTextField` memakai Form/validator saat submit, label permanen, pesan error,
controller opsional, keyboard type, formatters, dan focus node. Debounce search
tetap dimiliki logic layer. Tombol loading menonaktifkan callback dan mempertahankan
ukuran konten sebelumnya. Aksi destructive memakai token error dan konfirmasi.

`ControlledValuePicker` menerima opsi dengan key stabil. Hasilnya
`DailySelectedValue.known(key)` atau `.custom(value)` (`key = other`). Nilai kustom
di-trim dan tidak boleh kosong; pilihan sebelumnya tetap ada saat membuka ulang.
Dismiss/back tidak memanggil `onChanged`; clear secara eksplisit memanggilnya dengan
`null`. Daftar domain/taxonomy ditentukan feature, bukan komponen umum.

`DailyRatingInput` menerima `int?`, hanya 1–5 atau null. Tidak ada default rating.
Rating bisa dihapus; tiap kontrol memiliki label dan target sentuh minimal 48 dp.

`DailyPhoto` menerima ImageProvider, menyediakan placeholder selama loading dan
saat image gagal, serta tidak mengakses file sendiri. Akuisisi foto/permission
tetap Phase 6. Tanggal kartu jurnal diformat melalui MaterialLocalizations.

## Responsive dan accessibility

- Padding 16 dp pada compact dan 24 dp mulai 600 dp; form/detail maksimal 720 dp,
  feed maksimal 1200 dp. Halaman scrollable dan menghormati SafeArea/keyboard.
- Grid menghitung kolom dari lebar minimum kartu 160 dp, gap 16 dp, dan text scale.
  Tinggi kartu mengikuti isi. Pada layar sempit atau teks besar grid menjadi satu kolom.
- `DailyAdaptiveGrid` memakai Wrap untuk koleksi terbatas/preview. Feed data besar
  Phase 4/10 perlu lazy sliver/builder dengan kebijakan lebar yang sama.
- Sheet memiliki batas lebar, scroll, dan keyboard inset. Dialog scrollable.
- Kartu aksi memiliki satu label gabungan beserta semantic tap action. Status
  memakai icon dan label; error/loading memakai live region.
- Motion sheet mengikuti reduce motion. Skeleton statis sengaja dipilih agar tidak
  ada animasi dekoratif berulang. Progress berubah menjadi ikon statis ketika
  `disableAnimations` aktif.
- Teks status memakai `textPrimary` di atas tint status agar kontras teks terjaga.
  Warna status tetap hadir pada ikon dan background.

## Preview dan verifikasi

```powershell
flutter run -t lib/app/preview/design_system_preview.dart
```

Preview memiliki switch light/dark dan teks 200%, data contoh kartu, seluruh input,
rating, picker, loading/empty/error, serta dialog. Entry point terpisah menjaga data
contoh tidak masuk koleksi aplikasi utama. Jalankan kembali `flutter run` untuk app.

```powershell
.\tool\quality_check.ps1
```

Quality gate berhenti pada exit code gagal, termasuk native command di PowerShell.
Test mencakup tombol disabled/loading, validasi submit, clear search, rating nullable,
picker search/custom/edit/cancel/clear, keyboard, fallback image, semantics kartu,
layout 320/600/1000 dp pada teks 100%/200%, light/dark, kontras role teks/primary/error,
dan regresi navigasi termasuk landscape 200%.

Golden light/dark berada di `test/golden/baselines`. Font Inter, Lora, dan MaterialIcons
dimuat eksplisit oleh golden test. Baseline dibuat pada Flutter 3.47.5/Windows;
perbedaan engine/platform perlu review visual sebelum baseline diperbarui:

```powershell
flutter test test/golden/design_system_golden_test.dart --update-goldens
```

QA manual di Android tetap diperlukan: TalkBack, keyboard perangkat, perubahan tema
sistem, portrait/landscape, dan ukuran font sistem. Widget/golden test bukan bukti
bahwa pengujian pada perangkat fisik sudah dilakukan.
