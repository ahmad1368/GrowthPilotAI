import 'package:growth_pilot_ai/business/compute_inventory_valuation.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';

/// Values every item against its own cost layers (Issue #446). Pure.
class ComputeItemValuations {
  static List<ItemValuation> call(List<InventoryItemEntity> items,
      List<InventoryCostLayerEntity> allLayers, ValuationMethod method) {
    return [
      for (final item in items)
        ItemValuation(
          item: item,
          totalValue: ComputeInventoryValuation.call(
            item.quantityOnHand,
            allLayers.where((l) => l.itemId == item.id).toList(),
            method,
          ),
        ),
    ];
  }
}
