import 'package:daily_coffee/features/scan/data/ai_connection_store.dart';

class MemoryAiConnectionStore implements AiConnectionStore {
  AiConnection? value;
  bool fail = false;
  @override
  Future<AiConnection?> read() async {
    if (fail) throw StateError('storage unavailable');
    return value;
  }

  @override
  Future<void> save(AiConnection connection) async {
    if (fail) throw StateError('storage unavailable');
    value = connection;
  }

  @override
  Future<void> clear() async {
    if (fail) throw StateError('storage unavailable');
    value = null;
  }
}
