import 'package:growth_pilot_ai/business/find_goals_without_requirements.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Coverage Formula: goals with >= 1 linked requirement / total
/// goals" (Issue #243) — built on Issue #239's own
/// [FindGoalsWithoutRequirements] gap-analysis logic.
class ComputeGoalCoverageReport {
  static GoalCoverageReport call(List<BusinessGoalEntity> goals, List<GoalRequirementLinkEntity> allLinks) {
    final uncovered = FindGoalsWithoutRequirements.call(goals, allLinks);
    final coverage = goals.isEmpty ? 0.0 : (goals.length - uncovered.length) / goals.length;
    return GoalCoverageReport(
      overallCoverage: coverage,
      uncoveredGoals: uncovered,
      computedAt: DateTime.now(),
    );
  }
}
