import '../../../../objectbox.g.dart';
import '../entities/inventory_item_attribute_entity.dart';

/// Basic CRUD for inventory item attributes (Issue #438), mirroring
/// [InventoryItemRepository]'s insert pattern.
class InventoryItemAttributeRepository {
  final Box<InventoryItemAttributeEntity> _box;

  InventoryItemAttributeRepository(this._box);

  int insert(InventoryItemAttributeEntity attribute) => _box.put(attribute);
}
