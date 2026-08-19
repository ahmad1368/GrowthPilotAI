import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Sheet 2 (Summary Stats): coverage percentages calculated in Issue
/// #244... an executive summary" (Issue #245) — feeding directly off
/// #243's [GoalCoverageReport] (no sparklines: this repo has no
/// historical coverage series to chart, only the current snapshot; see
/// PR notes).
class BuildTraceabilitySummarySheet {
  static void call(Excel excel, String sheetName, GoalCoverageReport report) {
    final sheet = excel[sheetName];
    sheet.appendRow([TextCellValue('Traceability Matrix — Executive Summary')]);
    sheet.appendRow([
      TextCellValue('Overall Coverage'),
      TextCellValue('${(report.overallCoverage * 100).round()}%'),
    ]);
    sheet.appendRow([TextCellValue('Uncovered Goals'), IntCellValue(report.uncoveredGoals.length)]);
    if (report.uncoveredGoals.isNotEmpty) {
      sheet.appendRow([TextCellValue('Goals missing requirements:')]);
      for (final goal in report.uncoveredGoals) {
        sheet.appendRow([TextCellValue('- ${goal.title}')]);
      }
    }
    sheet.appendRow([TextCellValue('Generated at'), TextCellValue(report.computedAt.toIso8601String())]);
  }
}
