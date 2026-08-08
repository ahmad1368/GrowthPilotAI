import '../../../../objectbox.g.dart';
import '../entities/marketplace_sync_status_entity.dart';

/// Thin ObjectBox wrapper for marketplace sync statuses (Issue #127).
class MarketplaceSyncStatusRepository {
  final Box<MarketplaceSyncStatusEntity> _box;

  MarketplaceSyncStatusRepository(this._box);

  List<MarketplaceSyncStatusEntity> getForListing(int listingId) =>
      _box.getAll().where((s) => s.listingId == listingId).toList();

  void upsertAll(List<MarketplaceSyncStatusEntity> statuses) => _box.putMany(statuses);
}
