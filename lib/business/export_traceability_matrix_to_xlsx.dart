import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/business/build_traceability_grid_sheet.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_workbook.dart';
import 'package:growth_pilot_ai/business/build_traceability_requirements_list_sheet.dart';
import 'package:growth_pilot_ai/business/build_traceability_summary_sheet.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Advanced Traceability Matrix Export to Excel (XLSX)" (Issue #245),
/// extended by #247 into the full 4-sheet workbook (Summary/Matrix/
/// Grid/Requirements) — generated entirely client-side with the
/// `excel` package instead of the issues' Node.js `exceljs` server (no
/// backend exists in this repo; see PR notes).
class ExportTraceabilityMatrixToXlsx {
  static List<int> call({
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
    required Map<int, String> lastModifiedByRequirementId,
    required GoalCoverageReport coverageReport,
  }) {
    final excel = Excel.createExcel();
    BuildTraceabilitySummarySheet.call(excel, 'Summary', coverageReport);
    BuildTraceabilityMatrixWorkbook.call(
      excel,
      'Matrix',
      goals: goals,
      requirements: requirements,
      testCases: testCases,
      goalLinks: goalLinks,
      testCaseLinks: testCaseLinks,
      lastModifiedByRequirementId: lastModifiedByRequirementId,
    );
    BuildTraceabilityGridSheet.call(excel, 'Grid', goals: goals, requirements: requirements, goalLinks: goalLinks);
    BuildTraceabilityRequirementsListSheet.call(excel, 'Requirements', requirements);
    excel.delete('Sheet1');
    return excel.encode()!;
  }
}
