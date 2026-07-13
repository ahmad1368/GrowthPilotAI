import 'package:growth_pilot_ai/core/interfaces/remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for the not-yet-built NestJS backend. Emulates a health
/// check without any real network so the app boots, stays testable offline,
/// and compiles on web (no dart:io / native sockets).
class MockRemoteSyncDataSource implements RemoteSyncDataSource {
  @override
  final SyncConfig config;

  MockRemoteSyncDataSource(this.config);

  @override
  OmniResult<bool> healthCheck() async {
    if (!config.isConfigured) {
      OmniLogger.warning(
          'Sync health check skipped: no endpoint configured (SYNC_BASE_URL)');
      return OmniResponse.error('No sync endpoint configured',
          statusCode: 503);
    }
    OmniLogger.info('Mock sync health check OK for ${config.baseUrl}');
    return OmniResponse.success(true,
        message: 'Mock backend reachable (200 OK)');
  }
}
