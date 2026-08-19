import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/business/write_traceability_matrix_header.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';

/// "Sheet 1 (Matrix): Full matrix representation" (Issue #245) — one
/// row per requirement: code, description, dev status (conditionally
/// colored), linked goals, linked test case codes, last modified by.
class BuildTraceabilityMatrixWorkbook {
  static void call(
    Excel excel,
    String sheetName, {
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
    required Map<int, String> lastModifiedByRequirementId,
  }) {
    final sheet = excel[sheetName];
    WriteTraceabilityMatrixHeader.call(sheet);

    for (final requirement in requirements) {
      final goalTitles = goalLinks
          .where((l) => l.requirement.targetId == requirement.id)
          .map((l) => goals.firstWhere((g) => g.id == l.goal.targetId).title)
          .join(', ');
      final tcCodes = testCaseLinks
          .where((l) => l.requirement.targetId == requirement.id)
          .map((l) => testCases.firstWhere((t) => t.id == l.testCase.targetId).tcCode)
          .join(', ');

      final rowIndex = sheet.maxRows;
      sheet.appendRow([
        TextCellValue(requirement.reqCode),
        TextCellValue(requirement.description),
        TextCellValue(requirement.devStatus.name),
        TextCellValue(goalTitles),
        TextCellValue(tcCodes),
        TextCellValue(lastModifiedByRequirementId[requirement.id] ?? 'local-user'),
      ]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).cellStyle =
          CellStyle(backgroundColorHex: _colorFor(requirement.devStatus));
    }
  }

  static ExcelColor _colorFor(RequirementDevStatus status) {
    switch (status) {
      case RequirementDevStatus.completed:
        return ExcelColor.green200;
      case RequirementDevStatus.inProgress:
        return ExcelColor.orange200;
      case RequirementDevStatus.pending:
        return ExcelColor.grey200;
    }
  }
}
