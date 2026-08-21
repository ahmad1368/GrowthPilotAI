import 'dart:convert';
import 'dart:typed_data';
import 'package:growth_pilot_ai/business/build_traceability_matrix_csv.dart';
import 'package:growth_pilot_ai/business/export_traceability_matrix_to_xlsx.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// The three numbered files bundled into Issue #258's batch ZIP — the
/// already-rendered PDF report plus a fresh XLSX and CSV matrix
/// export, named per the issue's own convention
/// ("01_Business_Requirement_Document.pdf", etc).
class BuildBatchExportFiles {
  static List<({String filename, List<int> bytes})> call({
    required Uint8List pdfBytes,
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
    required Map<int, String> lastModifiedByRequirementId,
    required GoalCoverageReport coverageReport,
  }) {
    final xlsxBytes = ExportTraceabilityMatrixToXlsx.call(
      goals: goals,
      requirements: requirements,
      testCases: testCases,
      goalLinks: goalLinks,
      testCaseLinks: testCaseLinks,
      lastModifiedByRequirementId: lastModifiedByRequirementId,
      coverageReport: coverageReport,
    );
    final csvBytes = utf8.encode(BuildTraceabilityMatrixCsv.call(
      goals: goals,
      requirements: requirements,
      testCases: testCases,
      goalLinks: goalLinks,
      testCaseLinks: testCaseLinks,
      lastModifiedByRequirementId: lastModifiedByRequirementId,
    ));

    return [
      (filename: '01_Traceability_Report.pdf', bytes: pdfBytes),
      (filename: '02_Traceability_Matrix.xlsx', bytes: xlsxBytes),
      (filename: '03_Traceability_Matrix.csv', bytes: csvBytes),
    ];
  }
}
