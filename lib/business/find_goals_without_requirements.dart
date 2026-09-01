import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';

/// "Empty Columns: Highlight goals with no linked requirements in
/// orange (Gap Analysis)" (Issue #239).
class FindGoalsWithoutRequirements {
  static List<BusinessGoalEntity> call(
      List<BusinessGoalEntity> goals, List<GoalRequirementLinkEntity> allLinks) {
    final linkedIds = allLinks.map((l) => l.goal.targetId).toSet();
    return goals.where((g) => !linkedIds.contains(g.id)).toList();
  }
}
