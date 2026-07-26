import '../../../../objectbox.g.dart';
import '../entities/inventory_category_entity.dart';

/// Basic CRUD for inventory categories (Issue #436), mirroring
/// [InventoryItemRepository]'s insert/getAll pattern.
class InventoryCategoryRepository {
  final Box<InventoryCategoryEntity> _box;

  InventoryCategoryRepository(this._box);

  int insert(InventoryCategoryEntity category) => _box.put(category);

  List<InventoryCategoryEntity> getAll() => _box.getAll();
}
