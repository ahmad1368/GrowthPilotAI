import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';

void main() {
  group('MockRemoteSyncDataSource.healthCheck', () {
    test('returns a 200 success when an endpoint is configured', () async {
      final source = MockRemoteSyncDataSource(
          const SyncConfig(baseUrl: 'https://api.example.com'));
      final response = await source.healthCheck();

      expect(response.success, isTrue);
      expect(response.statusCode, 200);
      expect(response.data, isTrue);
    });

    test('returns a 503 failure when no endpoint is configured', () async {
      final source =
          MockRemoteSyncDataSource(const SyncConfig(baseUrl: ''));
      final response = await source.healthCheck();

      expect(response.success, isFalse);
      expect(response.statusCode, 503);
      expect(response.data, isNull);
    });
  });
}
