/// Aggregated GST/PST totals across a set of invoices (Issue #172 AC:
/// "Excel exports must include a Tax Summary sheet specifically
/// breaking down GST and PST for BC businesses") — BC only (5% GST,
/// 7% PST), matching this repo's existing [CalculateGstPst] rates.
class InvoiceTaxSummary {
  final int invoiceCount;
  final double totalSubtotal;
  final double totalGst;
  final double totalPst;
  final double totalCollected;
  final DateTime? periodStart;
  final DateTime? periodEnd;

  const InvoiceTaxSummary({
    required this.invoiceCount,
    required this.totalSubtotal,
    required this.totalGst,
    required this.totalPst,
    required this.totalCollected,
    this.periodStart,
    this.periodEnd,
  });
}
