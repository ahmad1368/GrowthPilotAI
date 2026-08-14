import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/models/invoice_line_item.dart';
import 'package:growth_pilot_ai/core/models/invoice_pdf_params.dart';

/// Converts a persisted [InvoiceEntity] (already assigned an id/invoice
/// number) into the plain-data [InvoicePdfParams] the PDF renderer
/// needs (Issue #146).
class BuildInvoicePdfParamsFromEntity {
  static InvoicePdfParams call(InvoiceEntity invoice, List<InvoiceLineItem> lineItems) {
    return InvoicePdfParams(
      invoiceNumber: invoice.invoiceNumber,
      sellerId: invoice.sellerId,
      buyerId: invoice.buyerId,
      sellerBusinessNumber: invoice.sellerBusinessNumber,
      lineItems: lineItems,
      subtotal: invoice.subtotal,
      gst: invoice.gst,
      pst: invoice.pst,
      total: invoice.total,
      issuedAt: invoice.createdAt,
    );
  }
}
