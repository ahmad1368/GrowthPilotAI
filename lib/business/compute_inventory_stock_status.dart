import 'package:growth_pilot_ai/business/build_inventory_category_path.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

/// Flags inventory items at or below their reorder threshold, lowest-stock
/// first (Issue #435), annotated with their category path (Issue #436).
class ComputeInventoryStockStatus {
  static List<InventoryStockItem> call(List<InventoryItemEntity> items) {
    final results = items.map((item) {
      final status = item.quantityOnHand <= item.reorderThreshold
          ? InventoryStockStatus.lowStock
          : InventoryStockStatus.ok;
      final category = item.category.target;
      return InventoryStockItem(
        name: item.name,
        quantityOnHand: item.quantityOnHand,
        reorderThreshold: item.reorderThreshold,
        unitCost: item.unitCost,
        status: status,
        categoryPath: category == null ? null : BuildInventoryCategoryPath.call(category),
        sku: item.sku,
      );
    }).toList()
      ..sort((a, b) => a.quantityOnHand.compareTo(b.quantityOnHand));

    return results;
  }
}
