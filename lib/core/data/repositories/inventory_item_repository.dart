import '../../../../objectbox.g.dart';
import '../entities/inventory_item_entity.dart';

/// Basic CRUD for inventory items (Issue #435), mirroring
/// [ComplianceItemRepository]'s insert/getAll pattern.
class InventoryItemRepository {
  final Box<InventoryItemEntity> _box;

  InventoryItemRepository(this._box);

  int insert(InventoryItemEntity item) => _box.put(item);

  List<InventoryItemEntity> getAll() => _box.getAll();
}
