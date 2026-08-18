import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_requirement_history_entry.dart';
import 'package:growth_pilot_ai/controllers/traceability_goal_deletion_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_lookup_mixin.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_goal_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_test_case_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceable_requirement_repository.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';

/// Drives the "Traceability Navigator" (Issue #238) — goals <->
/// requirements <-> test cases, with an append-only history log for
/// every requirement link. Read-queries and goal-deletion are mixed
/// in.
class TraceabilityController extends GetxController
    with TraceabilityLookupMixin, TraceabilityGoalDeletionMixin {
  @override
  final BusinessGoalRepository goalRepository;
  final TraceableRequirementRepository _requirements;
  final TraceabilityTestCaseRepository _testCases;
  @override
  final TraceabilityLinkRepository linkRepository;
  @override
  final RequirementHistoryRepository historyRepository;

  TraceabilityController(this.goalRepository, this._requirements, this._testCases,
      this.linkRepository, this.historyRepository);

  final goalList = <BusinessGoalEntity>[].obs;
  @override
  final requirementList = <TraceableRequirementEntity>[].obs;
  @override
  final testCaseList = <TraceabilityTestCaseEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  @override
  void refreshAll() {
    goalList.assignAll(goalRepository.getAll());
    requirementList.assignAll(_requirements.getAll());
    testCaseList.assignAll(_testCases.getAll());
  }

  int addGoal(String title) {
    final id = goalRepository.upsert(BusinessGoalEntity(title: title));
    refreshAll();
    return id;
  }

  int addTestCase(String title) {
    final id = _testCases.upsert(TraceabilityTestCaseEntity(title: title));
    refreshAll();
    return id;
  }

  int linkRequirementToGoal(String description, int goalId) {
    final requirementId = _requirements.upsert(TraceableRequirementEntity(description: description));
    linkRepository.linkGoalToRequirement(goalId, requirementId);
    historyRepository.append(BuildRequirementHistoryEntry.call(
        requirementId: requirementId,
        type: RequirementChangeType.insert,
        newValue: description,
        reason: 'Linked to goal'));
    refreshAll();
    return requirementId;
  }

  void linkTestCaseToRequirement(int requirementId, int testCaseId) {
    linkRepository.linkRequirementToTestCase(requirementId, testCaseId);
    refreshAll();
  }
}
