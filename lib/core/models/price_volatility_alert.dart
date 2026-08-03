/// One product's price change between two consecutive logged
/// observations (Issue #340), and whether it breached the admin's
/// configured threshold.
class PriceVolatilityAlert {
  final String productName;
  final double previousPrice;
  final double currentPrice;
  final double changePercent;
  final bool isBreached;
  final DateTime observedAt;

  const PriceVolatilityAlert({
    required this.productName,
    required this.previousPrice,
    required this.currentPrice,
    required this.changePercent,
    required this.isBreached,
    required this.observedAt,
  });
}
