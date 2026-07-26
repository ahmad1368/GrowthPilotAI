import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/purchase_order_draft.dart';

/// Suggests a purchase-order draft from low-stock inventory items (Issue
/// #443). Restocks each item back up to double its reorder threshold — a
/// documented static heuristic, since no sales-velocity data links
/// inventory to actual demand yet (same gap noted in #390/#360).
class GeneratePurchaseOrderDraft {
  static PurchaseOrderDraft? call(List<InventoryItemEntity> items) {
    final lowStock =
        items.where((item) => item.quantityOnHand <= item.reorderThreshold).toList();
    if (lowStock.isEmpty) return null;

    var total = 0.0;
    final lines = lowStock.map((item) {
      final suggestedQty = (item.reorderThreshold * 2 - item.quantityOnHand)
          .clamp(item.reorderThreshold, 1 << 30);
      total += suggestedQty * item.unitCost;
      return '${item.name} x$suggestedQty';
    }).toList();

    return PurchaseOrderDraft(
      itemsSummary: lines.join(', '),
      estimatedTotal: double.parse(total.toStringAsFixed(2)),
    );
  }
}
