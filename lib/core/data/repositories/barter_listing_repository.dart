import '../../../../objectbox.g.dart';
import '../entities/barter_listing_entity.dart';

/// Insert-or-update CRUD for barter listings (Issue #413), mirroring
/// [AssetListingRepository]'s upsert pattern.
class BarterListingRepository {
  final Box<BarterListingEntity> _box;

  BarterListingRepository(this._box);

  int save(BarterListingEntity listing) => _box.put(listing);

  List<BarterListingEntity> getAll() => _box.getAll();
}
