import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// "Tax Calculation Engine" (Issue #146) — BC rates only (5% GST, 7% PST
/// where applicable); no HST since BC doesn't harmonize its sales tax.
class CalculateGstPst {
  static const gstRate = 0.05;
  static const pstRate = 0.07;

  static TaxBreakdown call(double subtotal, {required bool applyPst}) {
    return TaxBreakdown(
      gst: double.parse((subtotal * gstRate).toStringAsFixed(2)),
      pst: applyPst ? double.parse((subtotal * pstRate).toStringAsFixed(2)) : 0,
    );
  }
}
