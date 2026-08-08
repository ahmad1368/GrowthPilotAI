import 'package:growth_pilot_ai/core/models/invoice_line_item.dart';

/// Input for `BuildInvoicePdfDocument.call` — plain data so it can
/// safely cross the `compute()` isolate boundary (Issue #146).
class InvoicePdfParams {
  final String invoiceNumber;
  final String sellerId;
  final String buyerId;
  final String? sellerBusinessNumber;
  final List<InvoiceLineItem> lineItems;
  final double subtotal, gst, pst, total;
  final DateTime issuedAt;

  const InvoicePdfParams({
    required this.invoiceNumber,
    required this.sellerId,
    required this.buyerId,
    this.sellerBusinessNumber,
    required this.lineItems,
    required this.subtotal,
    required this.gst,
    required this.pst,
    required this.total,
    required this.issuedAt,
  });
}
