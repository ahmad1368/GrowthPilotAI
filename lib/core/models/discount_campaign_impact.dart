/// Baseline-vs-promotional-window impact read for one logged discount
/// campaign (Issue #362).
class DiscountCampaignImpact {
  final String name;
  final double discountPercent;
  final double baselineRevenue;
  final double campaignRevenue;
  final double discountCost;
  final double netProfitImpact;
  final bool isProfitable;

  const DiscountCampaignImpact({
    required this.name,
    required this.discountPercent,
    required this.baselineRevenue,
    required this.campaignRevenue,
    required this.discountCost,
    required this.netProfitImpact,
    required this.isProfitable,
  });
}
