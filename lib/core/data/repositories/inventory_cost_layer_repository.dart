import '../../../../objectbox.g.dart';
import '../entities/inventory_cost_layer_entity.dart';

/// CRUD for manually recorded inventory cost layers (Issue #446).
class InventoryCostLayerRepository {
  final Box<InventoryCostLayerEntity> _box;

  InventoryCostLayerRepository(this._box);

  int insert(InventoryCostLayerEntity layer) => _box.put(layer);

  List<InventoryCostLayerEntity> getAll() => _box.getAll();

  List<InventoryCostLayerEntity> getForItem(int itemId) {
    final query = _box.query(InventoryCostLayerEntity_.itemId.equals(itemId)).build();
    final layers = query.find();
    query.close();
    return layers;
  }
}
