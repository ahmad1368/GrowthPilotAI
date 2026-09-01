import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';

/// Reduces a list of [ServiceHealthIndicator]s to one overall status
/// (Issue #166) — the local equivalent of the `/health` endpoint's
/// `200 OK` vs `503 Service Unavailable` decision: any indicator down
/// makes the whole snapshot down; degraded-only makes it degraded.
class AggregateServiceHealthSnapshot {
  static ServiceHealthStatus call(List<ServiceHealthIndicator> indicators) {
    if (indicators.any((i) => i.status == ServiceHealthStatus.down)) {
      return ServiceHealthStatus.down;
    }
    if (indicators.any((i) => i.status == ServiceHealthStatus.degraded)) {
      return ServiceHealthStatus.degraded;
    }
    return ServiceHealthStatus.up;
  }
}
