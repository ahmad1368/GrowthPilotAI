import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/filter_requirements_by_quick_filter.dart';
import 'package:growth_pilot_ai/business/find_goals_without_requirements.dart';
import 'package:growth_pilot_ai/business/find_requirements_without_goal.dart';
import 'package:growth_pilot_ai/business/find_requirements_without_test_case.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';

/// "Gap Analysis" + "Quick Filter Chips" (Issue #239), mixed into
/// `TraceabilityController`.
mixin TraceabilityGapAnalysisMixin on GetxController {
  TraceabilityLinkRepository get linkRepository;
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;

  Set<int> get requirementIdsWithoutGoal =>
      FindRequirementsWithoutGoal.call(requirementList, linkRepository.goalLinksFor())
          .map((r) => r.id)
          .toSet();

  Set<int> get goalIdsWithoutRequirements =>
      FindGoalsWithoutRequirements.call(goalList, linkRepository.goalLinksFor())
          .map((g) => g.id)
          .toSet();

  Set<int> get requirementIdsWithoutTestCase =>
      FindRequirementsWithoutTestCase.call(requirementList, linkRepository.allTestCaseLinks())
          .map((r) => r.id)
          .toSet();

  List<TraceableRequirementEntity> filteredRequirements(TraceabilityQuickFilter? filter) =>
      FilterRequirementsByQuickFilter.call(requirementList, filter,
          requirementIdsWithoutGoal: requirementIdsWithoutGoal,
          requirementIdsWithoutTestCase: requirementIdsWithoutTestCase);
}
