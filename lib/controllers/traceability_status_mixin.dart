import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_test_case_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceable_requirement_repository.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';
import 'package:growth_pilot_ai/core/enum/test_case_result.dart';

/// "dev_status"/test case "result" mutation (Issue #242), mixed into
/// `TraceabilityController`.
mixin TraceabilityStatusMixin on GetxController {
  TraceableRequirementRepository get requirementRepository;
  TraceabilityTestCaseRepository get testCaseRepository;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  void refreshAll();

  void setDevStatus(int requirementId, RequirementDevStatus status) {
    final requirement = requirementList.firstWhere((r) => r.id == requirementId);
    requirement.devStatus = status;
    requirementRepository.upsert(requirement);
    refreshAll();
  }

  void setTestCaseResult(int testCaseId, TestCaseResult result) {
    final testCase = testCaseList.firstWhere((t) => t.id == testCaseId);
    testCase.result = result;
    testCaseRepository.upsert(testCase);
    refreshAll();
  }
}
