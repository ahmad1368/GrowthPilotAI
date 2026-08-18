import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';

/// "Consistency Middleware: warns the user when deleting a goal that
/// would leave orphan requirements" (Issue #238) — a requirement is
/// orphaned if the goal being deleted is its only linked goal.
class FindOrphanedRequirementsForGoal {
  static List<int> call(List<GoalRequirementLinkEntity> allLinks, int goalId) {
    final linkedToGoal =
        allLinks.where((l) => l.goal.targetId == goalId).map((l) => l.requirement.targetId);

    return linkedToGoal.where((requirementId) {
      final linkedGoalCount = allLinks
          .where((l) => l.requirement.targetId == requirementId)
          .map((l) => l.goal.targetId)
          .toSet()
          .length;
      return linkedGoalCount <= 1;
    }).toList();
  }
}
