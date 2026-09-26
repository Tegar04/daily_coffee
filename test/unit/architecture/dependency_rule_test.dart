import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('core never imports a feature', () {
    final violations = _dartFiles('lib/core').where((file) {
      return file.readAsStringSync().contains('/features/');
    }).toList();

    expect(
      violations,
      isEmpty,
      reason: 'Core must not depend on a feature: ${_paths(violations)}',
    );
  });

  test('feature domain layers stay framework-independent', () {
    final forbiddenImports = <String>[
      'package:flutter/',
      'package:flutter_riverpod/',
      'package:riverpod/',
      'package:drift/',
      'package:go_router/',
    ];
    final violations = _dartFiles('lib/features')
        .where((file) => file.path.replaceAll('\\', '/').contains('/domain/'))
        .where((file) {
          final source = file.readAsStringSync();
          return forbiddenImports.any(source.contains);
        })
        .toList();

    expect(
      violations,
      isEmpty,
      reason: 'Domain must remain pure Dart: ${_paths(violations)}',
    );
  });
}

Iterable<File> _dartFiles(String root) {
  final directory = Directory(root);
  if (!directory.existsSync()) {
    return const Iterable<File>.empty();
  }

  return directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));
}

String _paths(Iterable<File> files) {
  return files.map((file) => file.path).join(', ');
}
