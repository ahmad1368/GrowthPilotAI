import '../../../../objectbox.g.dart';
import '../entities/asset_bid_entity.dart';

/// Insert-or-update CRUD for asset bids (Issue #412), mirroring
/// [PromoCardMetricsRepository]'s upsert + lookup pattern.
class AssetBidRepository {
  final Box<AssetBidEntity> _box;

  AssetBidRepository(this._box);

  int save(AssetBidEntity bid) => _box.put(bid);

  List<AssetBidEntity> getAll() => _box.getAll();

  List<AssetBidEntity> forListing(int listingId) =>
      getAll().where((b) => b.listingId == listingId).toList();
}
