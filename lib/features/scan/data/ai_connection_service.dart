import 'dart:convert';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:http/http.dart' as http;

import 'ai_connection_store.dart';

class AiConnectionService {
  const AiConnectionService(this.store, this.client);
  final AiConnectionStore store;
  final http.Client client;

  Future<Result<Uri?>> loadEndpoint() async {
    try {
      return Ok((await store.read())?.endpoint);
    } catch (_) {
      return const Err(StorageFailure());
    }
  }

  Future<Result<void>> connect(String address, String token) async {
    final AiConnection connection;
    try {
      connection = AiConnection.parse(address, token);
    } catch (_) {
      return const Err(ValidationFailure());
    }
    try {
      final request =
          http.Request(
              'GET',
              connection.endpoint.replace(path: '/api/device/check'),
            )
            ..followRedirects = false
            ..headers.addAll({
              'Accept': 'application/json',
              'Authorization': 'Bearer ${connection.token}',
            });
      final response = await (() async => http.Response.fromStream(
        await client.send(request),
      ))().timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        return Err(
          ExternalServiceFailure(
            diagnosticContext: {'status': response.statusCode},
          ),
        );
      }
      if (response.bodyBytes.length > 4096 ||
          (jsonDecode(response.body) as Map<String, dynamic>)['status'] !=
              'ok') {
        return const Err(ExternalServiceFailure());
      }
    } catch (_) {
      return const Err(NetworkFailure());
    }
    try {
      await store.save(connection);
      return const Ok(null);
    } catch (_) {
      return const Err(StorageFailure());
    }
  }

  Future<Result<void>> disconnect() async {
    try {
      await store.clear();
      return const Ok(null);
    } catch (_) {
      return const Err(StorageFailure());
    }
  }
}
