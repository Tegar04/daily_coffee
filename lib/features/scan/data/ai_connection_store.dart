import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AiConnection {
  const AiConnection(this.endpoint, this.token);
  final Uri endpoint;
  final String token;

  static AiConnection parse(String address, String token) {
    final uri = Uri.tryParse(address.trim());
    if (uri == null ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment ||
        !(uri.scheme == 'https' ||
            (kDebugMode &&
                uri.scheme == 'http' &&
                ['127.0.0.1', 'localhost'].contains(uri.host))) ||
        !['', '/', '/api/coffee-label/extract'].contains(uri.path) ||
        !RegExp(r'^dc_[a-f0-9]{64}$').hasMatch(token.trim())) {
      throw const FormatException('Invalid AI connection');
    }
    return AiConnection(
      uri.replace(path: '/api/coffee-label/extract'),
      token.trim(),
    );
  }
}

abstract interface class AiConnectionStore {
  Future<AiConnection?> read();
  Future<void> save(AiConnection connection);
  Future<void> clear();
}

class SecureAiConnectionStore implements AiConnectionStore {
  const SecureAiConnectionStore(
    this.storage, {
    this.key = 'coffee_ai_connection_v1',
  });
  final FlutterSecureStorage storage;
  final String key;
  static const _android = AndroidOptions(resetOnError: false);

  @override
  Future<AiConnection?> read() async {
    final raw = await storage.read(key: key, aOptions: _android);
    if (raw == null) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AiConnection.parse(
      json['endpoint'] as String,
      json['token'] as String,
    );
  }

  @override
  Future<void> save(AiConnection connection) => storage.write(
    key: key,
    aOptions: _android,
    value: jsonEncode({
      'endpoint': connection.endpoint.toString(),
      'token': connection.token,
    }),
  );

  @override
  Future<void> clear() => storage.delete(key: key, aOptions: _android);
}
