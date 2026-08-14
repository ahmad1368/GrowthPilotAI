import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';

/// Builds the "Delta Change" label (Issue #87 scope item 2: "Keep ...
/// Delta Change, e.g. '+15% Liquidity'") from a #83 Financial DNA
/// dimension and a percent change — never the exact currency amount
/// behind it.
class FormatDeltaChangeLabel {
  static const _dimensionLabels = {
    FinancialDnaDimension.liquidityRatio: 'Liquidity',
    FinancialDnaDimension.burnVelocity: 'Burn Velocity',
    FinancialDnaDimension.vendorDiversity: 'Vendor Diversity',
    FinancialDnaDimension.paymentPunctuality: 'Payment Punctuality',
  };

  static String call(FinancialDnaDimension dimension, double percentChange) {
    final sign = percentChange >= 0 ? '+' : '';
    return '$sign${percentChange.round()}% ${_dimensionLabels[dimension]}';
  }
}
