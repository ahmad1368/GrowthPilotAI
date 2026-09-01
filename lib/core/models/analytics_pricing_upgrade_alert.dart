/// One logged pricing tier assignment's read (Issue #336): whether it
/// represents a tariff upgrade from the merchant's previous tier, and by
/// how much the monthly fee increased.
class AnalyticsPricingUpgradeAlert {
  final String merchantName;
  final String tierName;
  final String previousTierName;
  final double monthlyFee;
  final double invoicedAmount;
  final bool isUpgrade;
  final double feeIncreasePercent;
  final DateTime effectiveAt;

  const AnalyticsPricingUpgradeAlert({
    required this.merchantName,
    required this.tierName,
    required this.previousTierName,
    required this.monthlyFee,
    required this.invoicedAmount,
    required this.isUpgrade,
    required this.feeIncreasePercent,
    required this.effectiveAt,
  });
}
