import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';

/// One row per invoice (Issue #172's "multi-sheet workbook... Sheet 2:
/// Itemized Invoices") backing [ExportInvoicesToXlsx]'s second sheet.
class BuildInvoiceItemizedSheet {
  static void call(Excel excel, String sheetName, List<InvoiceEntity> invoices) {
    final sheet = excel[sheetName];
    sheet.appendRow([
      TextCellValue('Invoice #'),
      TextCellValue('Date'),
      TextCellValue('Buyer'),
      TextCellValue('Subtotal'),
      TextCellValue('GST'),
      TextCellValue('PST'),
      TextCellValue('Total'),
    ]);
    for (final invoice in invoices) {
      sheet.appendRow([
        TextCellValue(invoice.invoiceNumber),
        TextCellValue(invoice.createdAt.toIso8601String()),
        TextCellValue(invoice.buyerId),
        DoubleCellValue(invoice.subtotal),
        DoubleCellValue(invoice.gst),
        DoubleCellValue(invoice.pst),
        DoubleCellValue(invoice.total),
      ]);
    }
  }
}
