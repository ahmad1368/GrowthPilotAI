import '../../../../objectbox.g.dart';
import '../entities/wholesale_order_entity.dart';

/// Insert-or-update CRUD for wholesale orders (Issue #411), mirroring
/// [AdvertisingRequestRepository]'s upsert pattern.
class WholesaleOrderRepository {
  final Box<WholesaleOrderEntity> _box;

  WholesaleOrderRepository(this._box);

  int save(WholesaleOrderEntity order) => _box.put(order);

  List<WholesaleOrderEntity> getAll() => _box.getAll();
}
