import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_invoice_tax_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';

InvoiceEntity _invoice({
  required double subtotal,
  required double gst,
  required double pst,
  required DateTime createdAt,
}) {
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
  group('BuildInvoiceTaxSummary', () {
    test('aggregates GST/PST/subtotal/total across all invoices (Issue #172 AC)', () {
      final invoices = [
        _invoice(subtotal: 100, gst: 5, pst: 7, createdAt: DateTime(2026, 1, 10)),
        _invoice(subtotal: 200, gst: 10, pst: 14, createdAt: DateTime(2026, 2, 5)),
      ];

      final summary = BuildInvoiceTaxSummary.call(invoices);

      expect(summary.invoiceCount, 2);
      expect(summary.totalSubtotal, 300);
      expect(summary.totalGst, 15);
      expect(summary.totalPst, 21);
      expect(summary.totalCollected, 336);
    });

    test('narrows by createdAt when from/to are given', () {
      final invoices = [
        _invoice(subtotal: 100, gst: 5, pst: 7, createdAt: DateTime(2026, 1, 1)),
        _invoice(subtotal: 200, gst: 10, pst: 14, createdAt: DateTime(2026, 2, 1)),
        _invoice(subtotal: 300, gst: 15, pst: 21, createdAt: DateTime(2026, 3, 1)),
      ];

      final summary = BuildInvoiceTaxSummary.call(invoices, from: DateTime(2026, 1, 15), to: DateTime(2026, 2, 15));

      expect(summary.invoiceCount, 1);
      expect(summary.totalSubtotal, 200);
    });

    test('returns zeroed totals for an empty invoice list', () {
      final summary = BuildInvoiceTaxSummary.call(const []);

      expect(summary.invoiceCount, 0);
      expect(summary.totalSubtotal, 0);
      expect(summary.totalGst, 0);
      expect(summary.totalPst, 0);
      expect(summary.totalCollected, 0);
    });
  });
}
