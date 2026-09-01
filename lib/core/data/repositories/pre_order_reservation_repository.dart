import '../../../../objectbox.g.dart';
import '../entities/pre_order_reservation_entity.dart';

/// Insert-or-update CRUD for pre-order reservations (Issue #417),
/// mirroring [GroupPurchaseContributionRepository]'s upsert + lookup
/// pattern.
class PreOrderReservationRepository {
  final Box<PreOrderReservationEntity> _box;

  PreOrderReservationRepository(this._box);

  int save(PreOrderReservationEntity reservation) => _box.put(reservation);

  List<PreOrderReservationEntity> getAll() => _box.getAll();

  List<PreOrderReservationEntity> forCatalogItem(int catalogItemId) =>
      getAll().where((r) => r.catalogItemId == catalogItemId).toList();
}
