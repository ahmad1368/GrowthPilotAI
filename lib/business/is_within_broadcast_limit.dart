import 'package:growth_pilot_ai/business/compute_procurement_broadcast_limit.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// Pairs with [ComputeProcurementBroadcastLimit] to gate opening a new
/// #126 procurement request once the tier's monthly quota is used up.
class IsWithinBroadcastLimit {
  static bool call({required SubscriptionTier tier, required int currentMonthCount}) {
    final limit = ComputeProcurementBroadcastLimit.call(tier);
    return limit == -1 || currentMonthCount < limit;
  }
}
