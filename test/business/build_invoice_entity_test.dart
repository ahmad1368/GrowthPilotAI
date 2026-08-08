import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_invoice_entity.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

void main() {
  test('totals the subtotal plus the tax breakdown', () {
    final invoice = BuildInvoiceEntity.call(
      requestId: 1,
      sellerId: 'vendor',
      buyerId: 'buyer',
      sellerBusinessNumber: '123456789',
      subtotal: 100,
      tax: const TaxBreakdown(gst: 5, pst: 7),
      now: DateTime(2026, 1, 1),
    );

    expect(invoice.total, 112.0);
    expect(invoice.pdfBytes, isEmpty);
    expect(invoice.sellerBusinessNumber, '123456789');
  });

  test('the invoice number is derived from the assigned id and year', () {
    final invoice = BuildInvoiceEntity.call(
      requestId: 1,
      sellerId: 'vendor',
      buyerId: 'buyer',
      sellerBusinessNumber: null,
      subtotal: 100,
      tax: const TaxBreakdown(gst: 5),
      now: DateTime(2026, 3, 1),
    )..id = 7;

    expect(invoice.invoiceNumber, 'INV-2026-00007');
  });
}
