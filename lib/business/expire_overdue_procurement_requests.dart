import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// "Request Expiry Logic" (Issue #126) — the local stand-in for the
/// `@Cron(EVERY_HOUR)` job, invoked on-demand instead. Returns only the
/// requests that actually changed, so the caller persists the minimum.
class ExpireOverdueProcurementRequests {
  static List<ProcurementRequestEntity> call(
      List<ProcurementRequestEntity> requests, DateTime now) {
    final changed = <ProcurementRequestEntity>[];
    for (final request in requests) {
      if (request.status != ProcurementRequestStatus.open) continue;
      if (request.deadline.isBefore(now)) {
        request.status = ProcurementRequestStatus.expired;
        changed.add(request);
      }
    }
    return changed;
  }
}
