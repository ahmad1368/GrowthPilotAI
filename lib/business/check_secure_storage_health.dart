import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Round-trips a throwaway probe value through the OS secure enclave
/// (Issue #166's third-party-API indicator, reinterpreted — this app's
/// closest analog to a dependency the encryption keys, e.g. [FieldCipher],
/// rely on being reachable).
class CheckSecureStorageHealth {
  static const _probeKey = 'service_health_probe_v1';

  static Future<ServiceHealthIndicator> call() async {
    try {
      await SecureStorageService.writeData(_probeKey, 'ok');
      final readBack = await SecureStorageService.readData(_probeKey);
      await SecureStorageService.deleteData(_probeKey);
      final ok = readBack == 'ok';
      return ServiceHealthIndicator(
        name: 'Secure Storage',
        status: ok ? ServiceHealthStatus.up : ServiceHealthStatus.degraded,
        message: ok ? 'Reachable' : 'Round-trip mismatch',
      );
    } catch (e) {
      return ServiceHealthIndicator(
        name: 'Secure Storage',
        status: ServiceHealthStatus.down,
        message: 'Unreachable: $e',
      );
    }
  }
}
