import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/core/models/invoice_tax_summary.dart';

/// "Tax Summary sheet specifically breaking down GST and PST for BC
/// businesses" (Issue #172 AC) — the executive-summary sheet of
/// [ExportInvoicesToXlsx]'s workbook, mirroring this repo's existing
/// #245 `BuildTraceabilitySummarySheet` layout.
class BuildInvoiceTaxSummarySheet {
  static void call(Excel excel, String sheetName, InvoiceTaxSummary summary) {
    final sheet = excel[sheetName];
    sheet.appendRow([TextCellValue('GST/PST Tax Summary (BC)')]);
    if (summary.periodStart != null || summary.periodEnd != null) {
      sheet.appendRow([
        TextCellValue('Period'),
        TextCellValue(
            '${summary.periodStart?.toIso8601String() ?? 'earliest'} — ${summary.periodEnd?.toIso8601String() ?? 'latest'}'),
      ]);
    }
    sheet.appendRow([TextCellValue('Invoice Count'), IntCellValue(summary.invoiceCount)]);
    sheet.appendRow([TextCellValue('Total Subtotal (pre-tax)'), DoubleCellValue(summary.totalSubtotal)]);
    sheet.appendRow([TextCellValue('Total GST Collected (5%)'), DoubleCellValue(summary.totalGst)]);
    sheet.appendRow([TextCellValue('Total PST Collected (7%)'), DoubleCellValue(summary.totalPst)]);
    sheet.appendRow([TextCellValue('Total Collected (incl. tax)'), DoubleCellValue(summary.totalCollected)]);
  }
}
