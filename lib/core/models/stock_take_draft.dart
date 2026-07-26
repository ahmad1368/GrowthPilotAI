import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';

/// Bundles a not-yet-persisted stock-take audit record with the inventory
/// item it reconciles (Issue #441), since recording a stock take also
/// adjusts the item's quantity on hand to match the physical count.
class StockTakeDraft {
  final InventoryStockTakeEntity record;
  final InventoryItemEntity item;

  const StockTakeDraft({required this.record, required this.item});
}
