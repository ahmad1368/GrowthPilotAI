import '../../../../objectbox.g.dart';
import '../entities/purchase_order_entity.dart';

/// Basic CRUD for purchase orders (Issue #443), mirroring
/// [WasteLogRepository]'s insert/getAll pattern.
class PurchaseOrderRepository {
  final Box<PurchaseOrderEntity> _box;

  PurchaseOrderRepository(this._box);

  int insert(PurchaseOrderEntity order) => _box.put(order);

  List<PurchaseOrderEntity> getAll() => _box.getAll();
}
