import '../../../../objectbox.g.dart';
import '../entities/group_purchase_entity.dart';

/// Insert-or-update CRUD for group-buying campaigns (Issue #414),
/// mirroring [BarterListingRepository]'s upsert pattern.
class GroupPurchaseRepository {
  final Box<GroupPurchaseEntity> _box;

  GroupPurchaseRepository(this._box);

  int save(GroupPurchaseEntity purchase) => _box.put(purchase);

  List<GroupPurchaseEntity> getAll() => _box.getAll();
}
