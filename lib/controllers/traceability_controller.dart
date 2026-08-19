import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_requirement_history_entry.dart';
import 'package:growth_pilot_ai/business/generate_traceability_code.dart';
import 'package:growth_pilot_ai/controllers/traceability_coverage_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_gap_analysis_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_goal_deletion_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_impact_analysis_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_lookup_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_matrix_link_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_status_mixin.dart';
import 'package:growth_pilot_ai/controllers/traceability_suggestion_mixin.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_goal_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/suggested_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_test_case_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceable_requirement_repository.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// Drives the "Traceability Navigator" (Issue #238/#242) — goals <->
/// requirements <-> test cases, with an append-only history log for
/// every requirement link. Read-queries, goal-deletion, and dev-
/// status/result mutation are mixed in.
class TraceabilityController extends GetxController
    with
        TraceabilityLookupMixin,
        TraceabilityGoalDeletionMixin,
        TraceabilityStatusMixin,
        TraceabilityGapAnalysisMixin,
        TraceabilityMatrixLinkMixin,
        TraceabilityImpactAnalysisMixin,
        TraceabilityCoverageMixin,
        TraceabilitySuggestionMixin {
  @override
  final BusinessGoalRepository goalRepository;
  @override
  final TraceableRequirementRepository requirementRepository;
  @override
  final TraceabilityTestCaseRepository testCaseRepository;
  @override
  final TraceabilityLinkRepository linkRepository;
  @override
  final RequirementHistoryRepository historyRepository;
  @override
  final SuggestedLinkRepository suggestionRepository;

  TraceabilityController(this.goalRepository, this.requirementRepository, this.testCaseRepository,
      this.linkRepository, this.historyRepository, this.suggestionRepository);

  @override
  final goalList = <BusinessGoalEntity>[].obs;
  @override
  final requirementList = <TraceableRequirementEntity>[].obs;
  @override
  final testCaseList = <TraceabilityTestCaseEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
    refreshSuggestions();
  }

  @override
  void refreshAll() {
    goalList.assignAll(goalRepository.getAll());
    requirementList.assignAll(requirementRepository.getAll());
    testCaseList.assignAll(testCaseRepository.getAll());
    recomputeCoverage();
  }

  int addGoal(String title) {
    final id = goalRepository.upsert(BusinessGoalEntity(title: title));
    refreshAll();
    return id;
  }

  int addTestCase(String title) {
    final code = GenerateTraceabilityCode.call('TC', testCaseList.length);
    final id = testCaseRepository.upsert(TraceabilityTestCaseEntity(tcCode: code, title: title));
    refreshAll();
    return id;
  }

  int linkRequirementToGoal(String description, int goalId) {
    final code = GenerateTraceabilityCode.call('BR', requirementList.length);
    final requirementId = requirementRepository
        .upsert(TraceableRequirementEntity(reqCode: code, description: description));
    _linkAndRecordHistory(requirementId, description, goalId);
    return requirementId;
  }

  /// "Link the `req_code` back to the `start_index` in the original
  /// document from Issue 228" (Issue #242) — links a real,
  /// already-extracted requirement instead of free-typed text.
  int linkExtractedRequirementToGoal(ExtractedRequirement requirement, int goalId) {
    final code = GenerateTraceabilityCode.call('BR', requirementList.length);
    final requirementId = requirementRepository.upsert(TraceableRequirementEntity(
      reqCode: code,
      description: requirement.description,
      sourceStartIndex: requirement.startIndex,
      sourceEndIndex: requirement.endIndex,
      dbMoscowPriority: requirement.moscowPriority.index,
    ));
    _linkAndRecordHistory(requirementId, requirement.description, goalId);
    return requirementId;
  }

  void _linkAndRecordHistory(int requirementId, String description, int goalId) {
    linkRepository.linkGoalToRequirement(goalId, requirementId);
    historyRepository.append(BuildRequirementHistoryEntry.call(
        requirementId: requirementId,
        type: RequirementChangeType.insert,
        newValue: description,
        reason: 'Linked to goal'));
    refreshAll();
  }

  void linkTestCaseToRequirement(int requirementId, int testCaseId) {
    linkRepository.linkRequirementToTestCase(requirementId, testCaseId);
    refreshAll();
  }
}
