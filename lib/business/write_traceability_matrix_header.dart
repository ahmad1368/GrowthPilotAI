import 'package:excel/excel.dart';

/// "Header Row: Dark background with white bold text" (Issue #245) —
/// split out of [BuildTraceabilityMatrixWorkbook] to keep it under the
/// 50-line guideline.
class WriteTraceabilityMatrixHeader {
  static final style =
      CellStyle(bold: true, fontColorHex: ExcelColor.white, backgroundColorHex: ExcelColor.black);

  static void call(Sheet sheet) {
    sheet.appendRow([
      TextCellValue('Code'),
      TextCellValue('Requirement'),
      TextCellValue('Dev Status'),
      TextCellValue('Business Goals'),
      TextCellValue('Test Cases'),
      TextCellValue('Last Modified By'),
    ]);
    for (var c = 0; c < 6; c++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: 0)).cellStyle = style;
    }
  }
}
