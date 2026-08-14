import 'package:growth_pilot_ai/business/calculate_gst_pst.dart';
import 'package:growth_pilot_ai/business/monthly_price_for_tier.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// "GST/PST applied to the subscription fee" (Issue #150 AC) — reuses
/// #146's BC tax engine instead of a second copy of the rates.
class ComputeSubscriptionRenewalCharge {
  static ({double subtotal, TaxBreakdown tax, double total}) call(
      SubscriptionTier tier, {required bool applyPst}) {
    final subtotal = MonthlyPriceForTier.call(tier);
    final tax = CalculateGstPst.call(subtotal, applyPst: applyPst);
    return (subtotal: subtotal, tax: tax, total: subtotal + tax.total);
  }
}
