import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/export_invoices_to_xlsx.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';

InvoiceEntity _invoice(double subtotal, double gst, double pst, DateTime createdAt) {
  return InvoiceEntity(
    requestId: 1,
    sellerId: 's1',
    buyerId: 'b1',
    subtotal: subtotal,
    gst: gst,
    pst: pst,
    total: subtotal + gst + pst,
    pdfBytes: Uint8List(0),
    createdAt: createdAt,
  );
}

void main() {
  group('ExportInvoicesToXlsx', () {
    test('produces a workbook with a Tax Summary sheet and an Invoices sheet (Issue #172 AC)', () {
      final invoices = [
        _invoice(100, 5, 7, DateTime(2026, 1, 10)),
        _invoice(200, 10, 14, DateTime(2026, 2, 5)),
      ];

      final bytes = ExportInvoicesToXlsx.call(invoices);
      final decoded = Excel.decodeBytes(bytes);

      expect(decoded.tables.keys, containsAll(['Tax Summary', 'Invoices']));
      expect(decoded.tables.keys, isNot(contains('Sheet1')));

      final invoiceRows = decoded.tables['Invoices']!.rows;
      expect(invoiceRows.length, 3); // header + 2 invoices
      expect(invoiceRows[0][0]?.value.toString(), 'Invoice #');

      final summaryRows = decoded.tables['Tax Summary']!.rows;
      final flat = summaryRows.map((r) => r.map((c) => c?.value.toString()).join('|')).join('\n');
      expect(flat, contains('Total GST Collected (5%)'));
      expect(flat, contains('Total PST Collected (7%)'));
    });

    test('produces a valid (empty) workbook when given no invoices', () {
      final bytes = ExportInvoicesToXlsx.call(const []);
      final decoded = Excel.decodeBytes(bytes);

      expect(decoded.tables['Invoices']!.rows.length, 1); // header only
    });
  });
}
