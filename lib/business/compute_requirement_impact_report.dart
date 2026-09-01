import 'package:growth_pilot_ai/business/compute_change_impact_risk_score.dart';
import 'package:growth_pilot_ai/business/find_directly_affected_by_requirement.dart';
import 'package:growth_pilot_ai/business/find_indirectly_affected_by_requirement.dart';
import 'package:growth_pilot_ai/business/find_keyword_contradictions.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/models/requirement_impact_report.dart';

/// "Predict Impact" (Issue #240) — combines the graph-traversal and
/// keyword-heuristic `Find*` classes into one [RequirementImpactReport].
class ComputeRequirementImpactReport {
  static RequirementImpactReport call({
    required TraceableRequirementEntity requirement,
    required List<BusinessGoalEntity> allGoals,
    required List<TraceableRequirementEntity> allRequirements,
    required List<TraceabilityTestCaseEntity> allTestCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
  }) {
    final directGoals = FindDirectlyAffectedByRequirement.goals(requirement.id, goalLinks, allGoals);
    final directTestCases =
        FindDirectlyAffectedByRequirement.testCases(requirement.id, testCaseLinks, allTestCases);
    final indirect = FindIndirectlyAffectedByRequirement.call(requirement.id, goalLinks, allRequirements);
    final contradictions = FindKeywordContradictions.call(requirement.description, indirect);

    return RequirementImpactReport(
      directGoals: directGoals,
      directTestCases: directTestCases,
      indirectRequirements: indirect,
      possibleContradictions: contradictions,
      riskScore: ComputeChangeImpactRiskScore.call(
        directGoalCount: directGoals.length,
        directTestCaseCount: directTestCases.length,
        indirectRequirementCount: indirect.length,
        contradictionCount: contradictions.length,
      ),
    );
  }
}
