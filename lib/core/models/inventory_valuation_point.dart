/// One plotted point on the inventory-valuation trend (Issue #446):
/// cumulative cost-layer investment received by [receivedAt].
class InventoryValuationPoint {
  final DateTime receivedAt;
  final double cumulativeValue;

  const InventoryValuationPoint({required this.receivedAt, required this.cumulativeValue});
}
