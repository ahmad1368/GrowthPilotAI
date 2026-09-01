import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';

/// Derives each merchant's current suspension status from its most
/// recently logged suspension (Issue #341) — automatic unsuspension
/// (acceptance criterion 3) is simply [now] having passed [expiresAt],
/// re-evaluated on every call rather than needing a background job.
class ComputeAccountSuspensionStatuses {
  static List<AccountSuspensionStatus> call(
      List<AccountSuspensionEntity> suspensions, DateTime now) {
    final latestByMerchant = <String, AccountSuspensionEntity>{};
    for (final s in suspensions) {
      final existing = latestByMerchant[s.merchantName];
      if (existing == null || s.suspendedAt.isAfter(existing.suspendedAt)) {
        latestByMerchant[s.merchantName] = s;
      }
    }

    final results = latestByMerchant.values
        .map((s) => AccountSuspensionStatus(
              id: s.id,
              merchantName: s.merchantName,
              reason: s.reason,
              suspendedAt: s.suspendedAt,
              expiresAt: s.expiresAt,
              isManuallyLifted: s.isManuallyLifted,
              isActive: !s.isManuallyLifted && now.isBefore(s.expiresAt),
            ))
        .toList();

    results.sort((a, b) => b.suspendedAt.compareTo(a.suspendedAt));
    return results;
  }
}
