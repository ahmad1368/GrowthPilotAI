import 'package:growth_pilot_ai/core/enum/canadian_province.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// "Tax Calculation Engine" (Issue #146, extended by #205 for Ontario) —
/// BC (5% GST + 7% PST, unharmonized) and Ontario (13% HST, harmonized:
/// no separate PST line). Defaults to BC to keep existing callers'
/// behavior unchanged.
class CalculateGstPst {
  static const bcGstRate = 0.05;
  static const bcPstRate = 0.07;
  static const ontarioHstRate = 0.13;

  static TaxBreakdown call(
    double subtotal, {
    required bool applyPst,
    CanadianProvince province = CanadianProvince.bc,
  }) {
    if (province == CanadianProvince.ontario) {
      return TaxBreakdown(hst: double.parse((subtotal * ontarioHstRate).toStringAsFixed(2)));
    }
    return TaxBreakdown(
      gst: double.parse((subtotal * bcGstRate).toStringAsFixed(2)),
      pst: applyPst ? double.parse((subtotal * bcPstRate).toStringAsFixed(2)) : 0,
    );
  }
}
