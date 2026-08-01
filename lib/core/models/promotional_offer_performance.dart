/// One logged offer's engagement read (Issue #335): open and usage
/// rates among the merchants it was dispatched to.
class PromotionalOfferPerformance {
  final String offerText;
  final String targetFilter;
  final int sentCount;
  final double openRatePercent;
  final double usageRatePercent;
  final DateTime dispatchedAt;

  const PromotionalOfferPerformance({
    required this.offerText,
    required this.targetFilter,
    required this.sentCount,
    required this.openRatePercent,
    required this.usageRatePercent,
    required this.dispatchedAt,
  });
}
