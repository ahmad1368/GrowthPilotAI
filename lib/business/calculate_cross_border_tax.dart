import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// "Cross-Border Tax Logic" (Issue #153): exports are 0% GST/PST; a
/// domestic sale still goes through #146's [CalculateGstPst] unchanged.
/// [dutyEstimate] is an honest, clearly-labeled placeholder — real duty
/// depends on an HS tariff classification this app cannot look up.
class CalculateCrossBorderTax {
  static const dutyPlaceholderRate = 0.05;

  static ({TaxBreakdown tax, double? dutyEstimate}) call(double subtotal,
      {required bool isExport, required bool applyPst}) {
    if (isExport) {
      return (tax: const TaxBreakdown(gst: 0, pst: 0), dutyEstimate: subtotal * dutyPlaceholderRate);
    }
    return (tax: CalculateGstPst.call(subtotal, applyPst: applyPst), dutyEstimate: null);
  }
}
