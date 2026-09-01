/// One "sold" event reported by an external marketplace (Issue #127).
typedef MarketplaceSaleEvent = ({String providerName, DateTime soldAt});

/// "Conflict Resolution Engine" (Issue #127 AC): when the same listing
/// sells on two platforms at once, the earliest sale wins; every other
/// provider's sale is a conflict that needs reconciliation (e.g.
/// refunding/cancelling the duplicate order).
class ResolveMarketplaceSaleConflict {
  static ({String winner, List<String> conflicts}) call(List<MarketplaceSaleEvent> events) {
    final sorted = [...events]..sort((a, b) => a.soldAt.compareTo(b.soldAt));
    return (
      winner: sorted.first.providerName,
      conflicts: sorted.skip(1).map((e) => e.providerName).toList(),
    );
  }
}
