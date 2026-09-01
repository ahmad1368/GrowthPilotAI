import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

/// Reads the existing [ConnectivityService] (Issue #166's third-party
/// reachability indicator, reinterpreted — this app has no Plaid/
/// QuickBooks backend to ping; network reachability is the real local
/// dependency every sync-dependent feature needs).
class CheckConnectivityHealth {
  static ServiceHealthIndicator call(ConnectivityService connectivity) {
    final isOnline = connectivity.isOnline.value;
    return ServiceHealthIndicator(
      name: 'Network Connectivity',
      status: isOnline ? ServiceHealthStatus.up : ServiceHealthStatus.down,
      message: isOnline ? 'Online' : 'Offline',
    );
  }
}
