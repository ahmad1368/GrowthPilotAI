import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// Not-yet-applied cost-layer request from the record-layer dialog (Issue
/// #446): which item, how many units, at what unit cost.
class InventoryCostLayerDraft {
  final InventoryItemEntity item;
  final int quantity;
  final double unitCost;

  const InventoryCostLayerDraft(
      {required this.item, required this.quantity, required this.unitCost});
}
