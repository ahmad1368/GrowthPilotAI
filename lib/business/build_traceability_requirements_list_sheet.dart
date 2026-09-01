import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/business/write_traceability_matrix_header.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "Sheet 3 (Requirements List): a detailed list of all extracted
/// requirements and their metadata" (Issue #247) — scoped to the
/// requirements already pinned into the traceability graph (Issue
/// #238/#242); this repo's #228-#232 extraction pipeline keeps
/// `ExtractedRequirement`s in-memory only, so unlinked/never-pinned
/// candidates aren't included (see PR notes).
class BuildTraceabilityRequirementsListSheet {
  static void call(Excel excel, String sheetName, List<TraceableRequirementEntity> requirements) {
    final sheet = excel[sheetName];
    sheet.appendRow([
      TextCellValue('Code'),
      TextCellValue('Description'),
      TextCellValue('Dev Status'),
      TextCellValue('MoSCoW Priority'),
      TextCellValue('Source Start Index'),
      TextCellValue('Source End Index'),
    ]);
    for (var c = 0; c < 6; c++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle =
          WriteTraceabilityMatrixHeader.style;
    }

    for (final requirement in requirements) {
      sheet.appendRow([
        TextCellValue(requirement.reqCode),
        TextCellValue(requirement.description),
        TextCellValue(requirement.devStatus.name),
        TextCellValue(requirement.moscowPriority?.name ?? ''),
        if (requirement.sourceStartIndex != null)
          IntCellValue(requirement.sourceStartIndex!)
        else
          TextCellValue(''),
        if (requirement.sourceEndIndex != null)
          IntCellValue(requirement.sourceEndIndex!)
        else
          TextCellValue(''),
      ]);
    }
  }
}
