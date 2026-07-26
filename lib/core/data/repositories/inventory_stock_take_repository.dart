import '../../../../objectbox.g.dart';
import '../entities/inventory_stock_take_entity.dart';

/// Basic CRUD for stock-take audit records (Issue #441), mirroring
/// [WasteLogRepository]'s insert/getAll pattern.
class InventoryStockTakeRepository {
  final Box<InventoryStockTakeEntity> _box;

  InventoryStockTakeRepository(this._box);

  int insert(InventoryStockTakeEntity record) => _box.put(record);

  List<InventoryStockTakeEntity> getAll() => _box.getAll();
}
