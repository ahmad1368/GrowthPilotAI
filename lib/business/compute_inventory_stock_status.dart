import 'package:growth_pilot_ai/business/build_inventory_category_path.dart';
import 'package:growth_pilot_ai/business/build_inventory_expiry_label.dart';
import 'package:growth_pilot_ai/business/compute_inventory_expiry_status.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

/// Flags inventory items at or below their reorder threshold, lowest-stock
/// first (Issue #435), annotated with their category path (Issue #436) and
/// expiry/serial-number/custom-attribute data (Issue #438).
class ComputeInventoryStockStatus {
  static List<InventoryStockItem> call(List<InventoryItemEntity> items, DateTime now) {
    final results = items.map((item) {
      final status = item.quantityOnHand <= item.reorderThreshold
          ? InventoryStockStatus.lowStock
          : InventoryStockStatus.ok;
      final category = item.category.target;
      final expiryStatus = ComputeInventoryExpiryStatus.call(item.expiryDate, now);
      final needsLabel = expiryStatus == InventoryExpiryStatus.expired ||
          expiryStatus == InventoryExpiryStatus.expiringSoon;
      return InventoryStockItem(
        name: item.name,
        quantityOnHand: item.quantityOnHand,
        reorderThreshold: item.reorderThreshold,
        unitCost: item.unitCost,
        status: status,
        categoryPath: category == null ? null : BuildInventoryCategoryPath.call(category),
        sku: item.sku,
        expiryStatus: expiryStatus,
        expiryLabel: needsLabel ? BuildInventoryExpiryLabel.call(item.expiryDate!, now) : null,
        serialNumber: item.serialNumber,
        attributes: {for (final a in item.attributes) a.key: a.value},
      );
    }).toList()
      ..sort((a, b) => a.quantityOnHand.compareTo(b.quantityOnHand));

    return results;
  }
}
