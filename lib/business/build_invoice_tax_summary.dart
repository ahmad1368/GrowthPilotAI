import 'package:growth_pilot_ai/core/data/entities/invoice_entity.dart';
import 'package:growth_pilot_ai/core/models/invoice_tax_summary.dart';

/// Aggregates GST/PST totals across [invoices] (Issue #172 AC: "Tax
/// Summary sheet specifically breaking down GST and PST for BC
/// businesses"). [from]/[to] optionally narrow by `createdAt`, the
/// local stand-in for the issue's server-side Date-Range filter (no
/// backend exists in this repo; see PR notes).
class BuildInvoiceTaxSummary {
  static InvoiceTaxSummary call(List<InvoiceEntity> invoices, {DateTime? from, DateTime? to}) {
    final filtered = invoices.where((i) {
      if (from != null && i.createdAt.isBefore(from)) return false;
      if (to != null && i.createdAt.isAfter(to)) return false;
      return true;
    }).toList();

    return InvoiceTaxSummary(
      invoiceCount: filtered.length,
      totalSubtotal: filtered.fold(0.0, (sum, i) => sum + i.subtotal),
      totalGst: filtered.fold(0.0, (sum, i) => sum + i.gst),
      totalPst: filtered.fold(0.0, (sum, i) => sum + i.pst),
      totalCollected: filtered.fold(0.0, (sum, i) => sum + i.total),
      periodStart: from,
      periodEnd: to,
    );
  }
}
