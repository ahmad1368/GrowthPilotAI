/// One logged FX observation's landed-cost impact read (Issue #371): how
/// the currency move between the baseline and current rate shifts an
/// imported product's landed cost, and the retail price bump needed to
/// hold the same margin.
class ExchangeRateImpact {
  final String currencyPair;
  final String productName;
  final double baselineRate;
  final double currentRate;
  final double landedCostBaseline;
  final double landedCostCurrent;
  final double costImpact;
  final double costImpactPercent;
  final DateTime observedAt;

  const ExchangeRateImpact({
    required this.currencyPair,
    required this.productName,
    required this.baselineRate,
    required this.currentRate,
    required this.landedCostBaseline,
    required this.landedCostCurrent,
    required this.costImpact,
    required this.costImpactPercent,
    required this.observedAt,
  });

  bool get costIncreased => costImpact > 0;
}
