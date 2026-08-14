import 'package:growth_pilot_ai/core/data/entities/market_snapshot_entity.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';

/// The "Global Aggregation" job's core math (Issue #102 scope item 2):
/// one day's average price and volume for a category+region, computed
/// from already-anonymized records (#80) — never a raw id or exact
/// coordinate.
class ComputeMarketSnapshot {
  static MarketSnapshotEntity call(
    List<AnonymousRecord> records,
    String category,
    String region,
    DateTime snapshotDate,
  ) {
    final matching =
        records.where((r) => r.category == category && r.region == region).toList();
    final avgPrice = matching.isEmpty
        ? 0.0
        : matching.map((r) => r.amount).reduce((a, b) => a + b) / matching.length;

    return MarketSnapshotEntity(
      category: category,
      region: region,
      avgPrice: avgPrice,
      itemCount: matching.length,
      snapshotDate: snapshotDate,
    );
  }
}
