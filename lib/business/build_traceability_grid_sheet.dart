import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/business/write_traceability_matrix_header.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "The export must perfectly replicate the intersections defined in
/// the app... the Excel cell at that intersection should be marked
/// (e.g., with an 'X')" (Issue #247) — a literal Goal x Requirement
/// grid, distinct from #245's flat one-row-per-requirement "Matrix"
/// sheet. No freeze-panes: this repo's pinned `excel` package version
/// has no freeze-pane API (see PR notes).
class BuildTraceabilityGridSheet {
  static void call(
    Excel excel,
    String sheetName, {
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<GoalRequirementLinkEntity> goalLinks,
  }) {
    final sheet = excel[sheetName];
    sheet.appendRow(
        [TextCellValue('Code'), for (final goal in goals) TextCellValue(goal.title)]);
    for (var c = 0; c <= goals.length; c++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle =
          WriteTraceabilityMatrixHeader.style;
    }

    final linkedPairs = goalLinks.map((l) => '${l.goal.targetId}:${l.requirement.targetId}').toSet();
    for (final requirement in requirements) {
      sheet.appendRow([
        TextCellValue(requirement.reqCode),
        for (final goal in goals)
          TextCellValue(linkedPairs.contains('${goal.id}:${requirement.id}') ? 'X' : ''),
      ]);
    }
  }
}
