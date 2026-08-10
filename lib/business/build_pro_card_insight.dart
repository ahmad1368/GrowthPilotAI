import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';
import 'package:growth_pilot_ai/core/models/pro_card_insight.dart';

/// Translates a #83 "Financial DNA" divergence into the human-readable
/// "Like the Pros" tip (Issue #85: the issue's own example — "Successful
/// {sector} firms usually diversify across N vendors ...").
class BuildProCardInsight {
  static const _insights = {
    FinancialDnaDimension.liquidityRatio:
        'Top-tier %s firms keep a stronger cash buffer relative to short-term liabilities than you currently do.',
    FinancialDnaDimension.burnVelocity:
        'Top-tier %s firms keep expense growth closer to revenue growth than you currently do.',
    FinancialDnaDimension.vendorDiversity:
        'Top-tier %s firms diversify across more vendors than you currently do, reducing concentration risk.',
    FinancialDnaDimension.paymentPunctuality:
        'Top-tier %s firms pay invoices faster than you currently do.',
  };

  static const _actionLabels = {
    FinancialDnaDimension.liquidityRatio: 'Open Cash Flow Simulator',
    FinancialDnaDimension.burnVelocity: 'Review Spend vs. Revenue',
    FinancialDnaDimension.vendorDiversity: 'Explore Vendor Options',
    FinancialDnaDimension.paymentPunctuality: 'Review Payment Schedule',
  };

  static ProCardInsight call(FinancialDnaDimension dimension, String sectorName) {
    return ProCardInsight(
      insightText: _insights[dimension]!.replaceFirst('%s', sectorName),
      actionLabel: _actionLabels[dimension]!,
    );
  }
}
