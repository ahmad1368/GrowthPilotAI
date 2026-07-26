import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

/// Flags inventory items at or below their reorder threshold, lowest-stock
/// first (Issue #435).
class ComputeInventoryStockStatus {
  static List<InventoryStockItem> call(List<InventoryItemEntity> items) {
    final results = items.map((item) {
      final status = item.quantityOnHand <= item.reorderThreshold
          ? InventoryStockStatus.lowStock
          : InventoryStockStatus.ok;
      return InventoryStockItem(
        name: item.name,
        quantityOnHand: item.quantityOnHand,
        reorderThreshold: item.reorderThreshold,
        unitCost: item.unitCost,
        status: status,
      );
    }).toList()
      ..sort((a, b) => a.quantityOnHand.compareTo(b.quantityOnHand));

    return results;
  }
}
