import '../../../../objectbox.g.dart';
import '../entities/asset_listing_entity.dart';

/// Insert-or-update CRUD for asset listings (Issue #412), mirroring
/// [AdvertisingRequestRepository]'s upsert pattern.
class AssetListingRepository {
  final Box<AssetListingEntity> _box;

  AssetListingRepository(this._box);

  int save(AssetListingEntity listing) => _box.put(listing);

  List<AssetListingEntity> getAll() => _box.getAll();
}
