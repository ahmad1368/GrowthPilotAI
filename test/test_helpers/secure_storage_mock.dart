import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// [Issue #788] Mocks the `flutter_secure_storage` platform channel with a
/// simple in-memory map, so tests can exercise real read/write flows
/// (registration, then login against the registered account) without a
/// platform binding. Call [install] from `setUp` for a fresh, isolated
/// store per test.
class SecureStorageMock {
  static const _channel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  static void install() {
    TestWidgetsFlutterBinding.ensureInitialized();
    final store = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
      final args = call.arguments as Map;
      switch (call.method) {
        case 'read':
          return store[args['key']];
        case 'write':
          store[args['key'] as String] = args['value'] as String;
          return null;
        case 'delete':
          store.remove(args['key']);
          return null;
        case 'containsKey':
          return store.containsKey(args['key']);
        default:
          return null;
      }
    });
  }
}
