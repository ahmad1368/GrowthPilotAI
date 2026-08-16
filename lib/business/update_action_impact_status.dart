import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

/// Moves one roadmap item to a new status (Issue #260's DoD: "Users can
/// change the status of a recommendation"). Stamps [completedAt] when
/// entering [ActionImpactStatus.done] and clears it on any reopen, so
/// [ComputeOpportunityCost] stops/resumes accruing loss correctly.
class UpdateActionImpactStatus {
  static ActionImpactItem call(
      ActionImpactItem item, ActionImpactStatus newStatus, DateTime now) {
    return ActionImpactItem(
      id: item.id,
      title: item.title,
      estimatedProfit: item.estimatedProfit,
      dailyOpportunityCost: item.dailyOpportunityCost,
      status: newStatus,
      createdAt: item.createdAt,
      completedAt: newStatus == ActionImpactStatus.done ? now : null,
    );
  }
}
