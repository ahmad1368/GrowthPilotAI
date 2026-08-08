import 'dart:typed_data';

import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// Constructs an [InvoiceEntity] from a computed subtotal/tax split
/// (Issue #146) — PDF bytes start empty since the entity needs an
/// assigned id (for its invoice number) before the PDF can be rendered.
class BuildInvoiceEntity {
  static InvoiceEntity call({
    required int requestId,
    required String sellerId,
    required String buyerId,
    required String? sellerBusinessNumber,
    required double subtotal,
    required TaxBreakdown tax,
    required DateTime now,
    String currencyCode = 'CAD',
    double? agreedExchangeRate,
    bool isExport = false,
    double? dutyEstimate,
  }) {
    return InvoiceEntity(
      requestId: requestId,
      sellerId: sellerId,
      buyerId: buyerId,
      sellerBusinessNumber: sellerBusinessNumber,
      subtotal: subtotal,
      gst: tax.gst,
      pst: tax.pst,
      total: subtotal + tax.total,
      currencyCode: currencyCode,
      agreedExchangeRate: agreedExchangeRate,
      isExport: isExport,
      dutyEstimate: dutyEstimate,
      pdfBytes: Uint8List(0),
      createdAt: now,
    );
  }
}
