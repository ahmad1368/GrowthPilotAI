import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_requirement_impact_report.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/requirement_impact_report.dart';

/// "Predict Impact" (Issue #240), mixed into `TraceabilityController`.
mixin TraceabilityImpactAnalysisMixin on GetxController {
  TraceabilityLinkRepository get linkRepository;
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;

  RequirementImpactReport computeImpactReport(int requirementId) {
    final requirement = requirementList.firstWhere((r) => r.id == requirementId);
    return ComputeRequirementImpactReport.call(
      requirement: requirement,
      allGoals: goalList,
      allRequirements: requirementList,
      allTestCases: testCaseList,
      goalLinks: linkRepository.goalLinksFor(),
      testCaseLinks: linkRepository.allTestCaseLinks(),
    );
  }
}
