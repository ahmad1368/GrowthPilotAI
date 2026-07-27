import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

/// Not-yet-applied stock movement request from the record-movement dialog
/// (Issue #439): which item, how many units, and which direction.
class StockMovementDraft {
  final InventoryItemEntity item;
  final int quantity;
  final StockMovementType type;

  const StockMovementDraft({required this.item, required this.quantity, required this.type});
}
