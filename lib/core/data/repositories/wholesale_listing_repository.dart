import '../../../../objectbox.g.dart';
import '../entities/wholesale_listing_entity.dart';

/// Insert-or-update CRUD for wholesale listings (Issue #411),
/// mirroring [AdvertisingRequestRepository]'s upsert pattern.
class WholesaleListingRepository {
  final Box<WholesaleListingEntity> _box;

  WholesaleListingRepository(this._box);

  int save(WholesaleListingEntity listing) => _box.put(listing);

  List<WholesaleListingEntity> getAll() => _box.getAll();
}
