import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';
import 'package:growth_pilot_ai/core/models/financial_dna_vector.dart';

/// Which "Financial DNA" dimension most differs from the sector's
/// Success Vector (Issue #83: "Course Correction logic provides at
/// least one actionable tip") — the caller uses this to pick which tip
/// to show.
class FindMostDivergentDimension {
  static FinancialDnaDimension call(FinancialDnaVector user, FinancialDnaVector success) {
    final gaps = {
      FinancialDnaDimension.liquidityRatio: (success.liquidityRatio - user.liquidityRatio).abs(),
      FinancialDnaDimension.burnVelocity: (success.burnVelocity - user.burnVelocity).abs(),
      FinancialDnaDimension.vendorDiversity:
          (success.vendorDiversity - user.vendorDiversity).abs(),
      FinancialDnaDimension.paymentPunctuality:
          (success.paymentPunctuality - user.paymentPunctuality).abs(),
    };
    return gaps.entries.reduce((a, b) => b.value > a.value ? b : a).key;
  }
}
