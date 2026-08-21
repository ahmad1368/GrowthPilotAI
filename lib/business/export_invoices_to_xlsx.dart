import 'package:excel/excel.dart';
import 'package:growth_pilot_ai/business/build_invoice_itemized_sheet.dart';
import 'package:growth_pilot_ai/business/build_invoice_tax_summary.dart';
import 'package:growth_pilot_ai/business/build_invoice_tax_summary_sheet.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';

/// "Multi-sheet workbook (Sheet 1: Summary, Sheet 2: Itemized
/// Invoices)" (Issue #172) — generated entirely client-side with the
/// `excel` package instead of the issue's NestJS `exceljs` server (no
/// backend exists in this repo; see PR notes).
class ExportInvoicesToXlsx {
  static List<int> call(List<InvoiceEntity> invoices, {DateTime? from, DateTime? to}) {
    final summary = BuildInvoiceTaxSummary.call(invoices, from: from, to: to);
    final filtered = invoices.where((i) {
      if (from != null && i.createdAt.isBefore(from)) return false;
      if (to != null && i.createdAt.isAfter(to)) return false;
      return true;
    }).toList();

    final excel = Excel.createExcel();
    BuildInvoiceTaxSummarySheet.call(excel, 'Tax Summary', summary);
    BuildInvoiceItemizedSheet.call(excel, 'Invoices', filtered);
    excel.delete('Sheet1');
    return excel.encode()!;
  }
}
