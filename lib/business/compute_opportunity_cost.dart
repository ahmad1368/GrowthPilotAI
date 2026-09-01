import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

/// "Loss Meter" (Issue #260): `Days Pending × Daily Opportunity Cost`.
/// A [done]/completed item stops accruing loss once completed, so days
/// are counted up to [ActionImpactItem.completedAt] instead of today.
class ComputeOpportunityCost {
  static double call(ActionImpactItem item, DateTime now) {
    final until = item.completedAt ?? now;
    final daysPending = until.difference(item.createdAt).inDays;
    if (daysPending <= 0) return 0;
    return daysPending * item.dailyOpportunityCost;
  }
}
