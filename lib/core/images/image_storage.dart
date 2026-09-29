import 'dart:convert';
import 'dart:io';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:path/path.dart' as p;

import 'image_processor.dart';
import 'managed_image.dart';

class ImageStorage {
  ImageStorage(this.root, this.processor);
  final Directory root;
  final ImageProcessor processor;

  File file(String relative) {
    if (relative.isEmpty ||
        relative.contains('\\') ||
        relative.contains(':') ||
        relative
            .split('/')
            .any((part) => part.isEmpty || part == '.' || part == '..') ||
        ![
          'photos',
          'drafts',
          'maintenance',
        ].contains(relative.split('/').first)) {
      throw const ImageValidationFailure();
    }
    return File(p.joinAll([root.path, ...relative.split('/')]));
  }

  Future<void> writeJson(String path, Map<String, Object?> data) async {
    final target = file(path);
    await target.parent.create(recursive: true);
    final temp = File('${target.path}.writing');
    await temp.writeAsString(jsonEncode(data), flush: true);
    await temp.rename(target.path);
  }

  Future<Map<String, dynamic>?> readJson(String path) async {
    final target = file(path);
    if (!await target.exists()) return null;
    return jsonDecode(await target.readAsString()) as Map<String, dynamic>;
  }

  Future<void> delete(String path) async {
    final target = file(path);
    if (await target.exists()) await target.delete();
  }

  Future<ManagedImage> stage(
    String externalPath,
    String id,
    String source,
  ) async {
    final input = File(externalPath);
    if (await input.length() > ImageProcessor.maxInputBytes) {
      throw const ImageValidationFailure();
    }
    final result = await processor.process(await input.readAsBytes());
    final relative = 'drafts/$id/cover.jpg';
    final target = file(relative);
    await target.parent.create(recursive: true);
    await target.writeAsBytes(result.cover, flush: true);
    await file('$relative.thumb.jpg')
        .writeAsBytes(result.thumbnail, flush: true);
    return ManagedImage(
      id: id,
      localPath: relative,
      width: result.width,
      height: result.height,
      byteSize: result.cover.length,
      source: source,
    );
  }

  Future<ManagedImage> promote(ManagedImage image, String coffeeId) async {
    final path = 'photos/$coffeeId/${image.id}.jpg';
    final target = file(path);
    await target.parent.create(recursive: true);
    await file(image.localPath).copy(target.path);
    await file(image.thumbnailPath).copy(file('$path.thumb.jpg').path);
    return ManagedImage(
      id: image.id,
      localPath: path,
      width: image.width,
      height: image.height,
      byteSize: await target.length(),
      source: image.source,
    );
  }

  Future<void> deleteWithThumbnail(String path) async {
    await delete('$path.thumb.jpg');
    await delete(path);
    if (path.startsWith('drafts/')) {
      final directory = p.posix.dirname(path);
      await delete('$directory/context.json');
      await delete('$directory/image.json');
    }
  }
}
