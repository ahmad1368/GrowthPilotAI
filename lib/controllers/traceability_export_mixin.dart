import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_csv.dart';
import 'package:growth_pilot_ai/business/export_traceability_matrix_to_xlsx.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/share_xlsx_bytes.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Structured Data Export (XLSX & CSV)" (Issue #245/#247), mixed into
/// `TraceabilityController` — must come after `TraceabilityCoverageMixin`
/// in the `with` clause so [coverageReport] is already available.
mixin TraceabilityExportMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  Rxn<GoalCoverageReport> get coverageReport;

  Future<void> exportMatrixToXlsx() async {
    final report = coverageReport.value;
    if (report == null) return;
    final bytes = ExportTraceabilityMatrixToXlsx.call(
      goals: goalList,
      requirements: requirementList,
      testCases: testCaseList,
      goalLinks: linkRepository.goalLinksFor(),
      testCaseLinks: linkRepository.allTestCaseLinks(),
      lastModifiedByRequirementId: _lastModifiedByMap(),
      coverageReport: report,
    );
    await ShareXlsxBytes.call(bytes, BuildTraceabilityExportFilename.call(DateTime.now()));
  }

  Future<void> exportMatrixToCsv() async {
    final csv = BuildTraceabilityMatrixCsv.call(
      goals: goalList,
      requirements: requirementList,
      testCases: testCaseList,
      goalLinks: linkRepository.goalLinksFor(),
      testCaseLinks: linkRepository.allTestCaseLinks(),
      lastModifiedByRequirementId: _lastModifiedByMap(),
    );
    await ShareCsvBytes.call(csv, BuildTraceabilityExportFilename.call(DateTime.now(), extension: 'csv'));
  }

  Map<int, String> _lastModifiedByMap() =>
      {for (final r in requirementList) r.id: _lastModifiedBy(r.id)};

  String _lastModifiedBy(int requirementId) {
    final history = historyRepository.forRequirement(requirementId);
    return history.isEmpty ? 'local-user' : history.first.changedBy;
  }
}
