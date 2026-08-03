import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/core/models/service_restriction_status.dart';

/// Derives each merchant/service pair's current lockdown status from its
/// most recently logged decision (Issue #337) — this app has no backend
/// access-control service, so block/unblock decisions are logged
/// manually instead, and a merchant/service pair may be logged more than
/// once as its status changes over time.
class ComputeServiceRestrictionStatuses {
  static List<ServiceRestrictionStatus> call(
      List<ServiceRestrictionEntity> restrictions) {
    final latestByPair = <String, ServiceRestrictionEntity>{};
    for (final r in restrictions) {
      final key = '${r.merchantName}::${r.serviceName}';
      final existing = latestByPair[key];
      if (existing == null || r.updatedAt.isAfter(existing.updatedAt)) {
        latestByPair[key] = r;
      }
    }

    final results = latestByPair.values
        .map((r) => ServiceRestrictionStatus(
              merchantName: r.merchantName,
              serviceName: r.serviceName,
              isBlocked: r.isBlocked,
              reasonMessage: r.reasonMessage,
              updatedAt: r.updatedAt,
            ))
        .toList();

    results.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return results;
  }
}
