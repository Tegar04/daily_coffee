# Golden tests

Snapshot light/dark komponen stabil berada di `baselines/`. Test memuat font
Inter, Lora, dan MaterialIcons dari asset, tanpa network. Baseline dibuat pada
Flutter 3.47.5 di Windows. Jalankan melalui `flutter test`; periksa perubahan
visual sebelum memperbarui dengan:

```powershell
flutter test test/golden/design_system_golden_test.dart --update-goldens
```

Golden melengkapi behavior test, bukan penggantinya. Perubahan Flutter engine
atau platform bisa memerlukan review baseline karena rasterisasi font berbeda.
