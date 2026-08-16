import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_opportunity_cost.dart';
import 'package:growth_pilot_ai/business/compute_projected_profit.dart';
import 'package:growth_pilot_ai/business/determine_achievement_badge.dart';
import 'package:growth_pilot_ai/business/update_action_impact_status.dart';
import 'package:growth_pilot_ai/core/data/repositories/action_impact_item_repository.dart';
import 'package:growth_pilot_ai/core/enum/achievement_badge_tier.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item_mapper.dart';

/// Drives the Action-Impact roadmap UI (Issue #260): loads tracked
/// recommendations, exposes the total "Loss Meter" and projected profit,
/// and applies status changes.
class ActionImpactController extends GetxController {
  final ActionImpactItemRepository _repository;
  final items = <ActionImpactItem>[].obs;

  ActionImpactController(this._repository);

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  void reload() {
    items.assignAll(_repository.getAll().map((e) => e.toModel()));
  }

  double get totalOpportunityLoss => items.fold<double>(
      0, (sum, item) => sum + ComputeOpportunityCost.call(item, DateTime.now()));

  double get projectedProfit => ComputeProjectedProfit.call(items);

  AchievementBadgeTier get badgeTier => DetermineAchievementBadge.call(
      items.where((i) => i.status == ActionImpactStatus.done).length);

  void setStatus(ActionImpactItem item, ActionImpactStatus newStatus) {
    final updated = UpdateActionImpactStatus.call(item, newStatus, DateTime.now());
    _repository.upsert(updated.toEntity());
    reload();
  }
}
