import '../../../../objectbox.g.dart';
import '../entities/market_snapshot_entity.dart';

/// The benchmark history archive (Issue #102) — separate from any raw
/// entity, holding only category/region aggregates.
class MarketSnapshotRepository {
  final Box<MarketSnapshotEntity> _box;

  MarketSnapshotRepository(this._box);

  int save(MarketSnapshotEntity snapshot) => _box.put(snapshot);

  List<MarketSnapshotEntity> getForPeerGroup(String category, String region) => _box
      .query(MarketSnapshotEntity_.category
          .equals(category)
          .and(MarketSnapshotEntity_.region.equals(region)))
      .build()
      .find();
}
