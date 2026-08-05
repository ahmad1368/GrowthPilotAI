import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';

/// Lists a flagged dead-stock item at its wholesale acquisition price
/// (Issue #411, acceptance criterion 1) — the full on-hand quantity is
/// offered at [InventoryItemEntity.unitCost] with no markup, "wholesale
/// acquisition price" per the issue's own wording, reusing
/// [ComputeDeadStockLiquidation]'s (#370) surplus detection instead of
/// a second dead-stock heuristic.
class FlagSurplusForWholesale {
  static WholesaleListingEntity call(DeadStockLiquidationSnapshot snapshot, DateTime now) {
    final item = snapshot.item;
    return WholesaleListingEntity(
      inventoryItemId: item.id,
      itemName: item.name,
      quantityListed: item.quantityOnHand,
      wholesalePrice: item.unitCost,
      listedAt: now,
    );
  }
}
