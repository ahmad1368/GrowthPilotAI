import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_history_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';

/// Derived read queries over the traceability graph (Issue #238's
/// "Traceability Navigator" + "History Timeline"), mixed into
/// `TraceabilityController`.
mixin TraceabilityLookupMixin on GetxController {
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;

  List<TraceableRequirementEntity> requirementsForGoal(int goalId) {
    final ids = linkRepository.goalLinksFor(goalId: goalId).map((l) => l.requirement.targetId).toSet();
    return requirementList.where((r) => ids.contains(r.id)).toList();
  }

  List<TraceabilityTestCaseEntity> testCasesForRequirement(int requirementId) {
    final ids = linkRepository
        .testCaseLinksFor(requirementId: requirementId)
        .map((l) => l.testCase.targetId)
        .toSet();
    return testCaseList.where((t) => ids.contains(t.id)).toList();
  }

  List<RequirementHistoryEntity> historyForRequirement(int requirementId) =>
      historyRepository.forRequirement(requirementId);
}
