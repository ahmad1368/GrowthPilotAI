import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/sync_environment.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';

void main() {
  group('SyncConfig', () {
    test('defaults to an unconfigured development endpoint', () {
      const config = SyncConfig(baseUrl: '');
      expect(config.isConfigured, isFalse);
      expect(config.port, 3000);
      expect(config.environment, SyncEnvironment.development);
    });

    test('is configured once a base URL is present', () {
      const config = SyncConfig(
        baseUrl: 'https://api.example.com',
        port: 8080,
        environment: SyncEnvironment.production,
      );
      expect(config.isConfigured, isTrue);
      expect(config.port, 8080);
      expect(config.environment, SyncEnvironment.production);
    });

    test('fromEnvironment falls back to safe defaults without dart-defines', () {
      final config = SyncConfig.fromEnvironment();
      // No SYNC_BASE_URL define in the test run -> not configured, no secret.
      expect(config.baseUrl, isEmpty);
      expect(config.port, 3000);
      expect(config.environment, SyncEnvironment.development);
    });
  });
}
