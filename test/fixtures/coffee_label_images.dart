import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Synthetic, project-owned labels: no customer images or brand artwork.
Uint8List coffeeLabelFixture({
  bool columns = false,
  bool degraded = false,
  bool blank = false,
}) {
  var image = img.Image(width: 1400, height: 1000);
  img.fill(image, color: img.ColorRgb8(250, 246, 235));
  if (!blank) {
    final lines = [
      'NUSANTARA ROASTERY',
      'GAYO HIGHLANDS',
      'ORIGIN INDONESIA',
      'PROCESS WASHED',
      '250g',
    ];
    for (var i = 0; i < lines.length; i++) {
      img.drawString(
        image,
        lines[i],
        font: img.arial48,
        x: columns && i > 1 ? 680 : 60,
        y: columns && i > 1 ? 100 + (i - 2) * 130 : 100 + i * 130,
        color: img.ColorRgb8(40, 30, 20),
      );
    }
  }
  if (degraded) {
    image = img.gaussianBlur(img.copyResize(image, width: 1000), radius: 1);
  }
  return Uint8List.fromList(img.encodeJpg(image, quality: degraded ? 45 : 95));
}
