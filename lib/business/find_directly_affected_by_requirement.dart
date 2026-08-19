import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';

/// "DirectlyAffected: Immediate children/parents" (Issue #240) — the
/// upstream goals and downstream test cases one requirement is
/// directly linked to.
class FindDirectlyAffectedByRequirement {
  static List<BusinessGoalEntity> goals(
      int requirementId, List<GoalRequirementLinkEntity> goalLinks, List<BusinessGoalEntity> allGoals) {
    final ids = goalLinks
        .where((l) => l.requirement.targetId == requirementId)
        .map((l) => l.goal.targetId)
        .toSet();
    return allGoals.where((g) => ids.contains(g.id)).toList();
  }

  static List<TraceabilityTestCaseEntity> testCases(int requirementId,
      List<RequirementTestCaseLinkEntity> testCaseLinks, List<TraceabilityTestCaseEntity> allTestCases) {
    final ids = testCaseLinks
        .where((l) => l.requirement.targetId == requirementId)
        .map((l) => l.testCase.targetId)
        .toSet();
    return allTestCases.where((t) => ids.contains(t.id)).toList();
  }
}
