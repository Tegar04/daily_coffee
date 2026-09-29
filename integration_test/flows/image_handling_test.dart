import 'dart:io';

import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';

/// Real Android filesystem/Drift/UI; deterministic acquisition adapter only.
/// Run seed -> verify -> deleted in separate processes with --no-uninstall.
class DeviceFixturePicker implements PhotoPickerGateway {
  DeviceFixturePicker(this.path);
  final String path;
  final sources = <PhotoSource>[];
  @override
  Future<Result<String?>> pick(PhotoSource source) async {
    sources.add(source);
    return Ok(path);
  }

  @override
  Future<Result<String?>> recover() async => const Ok(null);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const stage = String.fromEnvironment('IMAGE_STAGE', defaultValue: 'seed');
  const name = 'Phase 6 image QA';
  Future<void> settle(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 150));
  }

  Future<void> tap(WidgetTester tester, String text) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await settle(tester);
    final finder = find.text(text).last;
    await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
    await settle(tester);
    await tester.tap(finder);
    await settle(tester);
  }

  Future<void> waitFor(WidgetTester tester, String text) async {
    for (var i = 0; i < 80 && find.text(text).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 250));
    }
    expect(find.text(text), findsWidgets);
    await settle(tester);
  }

  testWidgets('image persistence stage $stage', (tester) async {
    final temp = await getTemporaryDirectory();
    final fixture = File('${temp.path}/phase6-label.png');
    final label = img.Image(width: 900, height: 1200);
    img.fill(label, color: img.ColorRgb8(247, 238, 210));
    img.drawString(
      label,
      'DAILY COFFEE',
      font: img.arial48,
      x: 70,
      y: 200,
      color: img.ColorRgb8(45, 25, 15),
    );
    img.drawString(
      label,
      'GUJI - ETHIOPIA',
      font: img.arial48,
      x: 70,
      y: 330,
      color: img.ColorRgb8(45, 25, 15),
    );
    img.drawString(
      label,
      'WASHED 250g',
      font: img.arial48,
      x: 70,
      y: 450,
      color: img.ColorRgb8(45, 25, 15),
    );
    await fixture.writeAsBytes(img.encodePng(label));
    final picker = DeviceFixturePicker(fixture.path);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [photoPickerGatewayProvider.overrideWithValue(picker)],
        child: const DailyCoffeeBootstrap(),
      ),
    );
    await settle(tester);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(DailyCoffeeBootstrap)),
    );
    await container.read(appBootstrapProvider.future);
    await settle(tester);
    if (find.text('Mulai mencatat').evaluate().isNotEmpty) {
      await tap(tester, 'Mulai mencatat');
    }
    await tap(tester, 'Koleksi');
    final repo = container.read(coffeeRepositoryProvider);
    final storage = await container.read(imageStorageProvider.future);
    Future<List<Coffee>> library() async =>
        (await repo.watchLibrary().first as Ok<List<Coffee>>).value;
    if (stage == 'seed') {
      expect((await library()).where((c) => c.details.name == name), isEmpty);
      await tap(tester, 'Tambah kopi');
      await tap(tester, 'Tambah dengan foto');
      await tester.enterText(
        find.widgetWithText(TextField, 'Nama kopi (wajib)'),
        name,
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Roastery (wajib)'),
        'Image QA',
      );
      await tap(tester, 'Pilih dari galeri');
      await waitFor(tester, 'Gunakan foto');
      await tap(tester, 'Gunakan foto');
      await tap(tester, 'Simpan kopi');
      await waitFor(tester, 'Detail kopi');
      final coffee = (await library()).singleWhere(
        (c) => c.details.name == name,
      );
      expect(picker.sources, [PhotoSource.gallery]);
      expect(
        await storage.file(coffee.photos.single.localPath).exists(),
        isTrue,
      );
      expect(
        await storage
            .file('${coffee.photos.single.localPath}.thumb.jpg')
            .exists(),
        isTrue,
      );
    } else if (stage == 'verify') {
      final coffee = (await library()).singleWhere(
        (c) => c.details.name == name,
      );
      final old = coffee.photos.single.localPath;
      expect(await storage.file(old).exists(), isTrue);
      await tap(tester, name);
      await tap(tester, 'Edit kopi');
      await tap(tester, 'Ambil ulang');
      await waitFor(tester, 'Gunakan foto');
      await tap(tester, 'Gunakan foto');
      await tap(tester, 'Simpan perubahan');
      await waitFor(tester, 'Detail kopi');
      final updated = (await library()).singleWhere(
        (c) => c.details.name == name,
      );
      expect(picker.sources, [PhotoSource.camera]);
      expect(updated.photos.single.localPath, isNot(old));
      expect(await storage.file(old).exists(), isFalse);
      await tap(tester, 'Hapus kopi');
      await tap(tester, 'Hapus kopi');
      await settle(tester);
      expect(
        await storage.file(updated.photos.single.localPath).exists(),
        isFalse,
      );
    } else {
      expect((await library()).where((c) => c.details.name == name), isEmpty);
      expect(
        await storage.file('maintenance/pending-picker.json').exists(),
        isFalse,
      );
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await fixture.delete();
  });
}
