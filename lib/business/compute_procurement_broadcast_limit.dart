import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// "Usage-based limits on Procurement Broadcasts" (Issue #150 AC) — caps
/// how many #126 RFPs a business may open per month. `-1` means
/// unlimited.
class ComputeProcurementBroadcastLimit {
  static int call(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.starter:
        return 3;
      case SubscriptionTier.pro:
        return 15;
      case SubscriptionTier.enterprise:
        return -1;
    }
  }
}
