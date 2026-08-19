import 'dart:convert';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_export_subject.dart';
import 'package:growth_pilot_ai/business/build_last_modified_by_map.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_csv.dart';
import 'package:growth_pilot_ai/business/export_traceability_matrix_to_xlsx.dart';
import 'package:growth_pilot_ai/business/share_multiple_export_files.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Send a PDF report and an Excel matrix in a single 'Share' action"
/// (Issue #250) — bundles the XLSX and CSV exports into one native
/// share call, mixed into `TraceabilityController` (must come after
/// `TraceabilityCoverageMixin`).
mixin TraceabilityMultiShareMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  ExportEventRepository get exportEventRepository;
  Rxn<GoalCoverageReport> get coverageReport;

  Future<void> shareAllExports() async {
    final report = coverageReport.value;
    if (report == null) return;
    final goalLinks = linkRepository.goalLinksFor();
    final testCaseLinks = linkRepository.allTestCaseLinks();
    final lastModifiedBy = BuildLastModifiedByMap.call(requirementList, historyRepository);

    final xlsxBytes = ExportTraceabilityMatrixToXlsx.call(
      goals: goalList,
      requirements: requirementList,
      testCases: testCaseList,
      goalLinks: goalLinks,
      testCaseLinks: testCaseLinks,
      lastModifiedByRequirementId: lastModifiedBy,
      coverageReport: report,
    );
    final csvBytes = utf8.encode(BuildTraceabilityMatrixCsv.call(
      goals: goalList,
      requirements: requirementList,
      testCases: testCaseList,
      goalLinks: goalLinks,
      testCaseLinks: testCaseLinks,
      lastModifiedByRequirementId: lastModifiedBy,
    ));

    final now = DateTime.now();
    final xlsxName = BuildTraceabilityExportFilename.call(now);
    final csvName = BuildTraceabilityExportFilename.call(now, extension: 'csv');

    await ShareMultipleExportFiles.call([
      (
        bytes: xlsxBytes,
        mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        filename: xlsxName
      ),
      (bytes: csvBytes, mimeType: 'text/csv', filename: csvName),
    ], subject: BuildExportSubject.call('Traceability Export', timestamp: now));

    exportEventRepository.append(ExportEventEntity(format: 'xlsx', filename: xlsxName, occurredAt: now));
    exportEventRepository.append(ExportEventEntity(format: 'csv', filename: csvName, occurredAt: now));
  }
}
