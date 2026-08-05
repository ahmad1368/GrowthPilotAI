import 'package:growth_pilot_ai/business/compute_dead_stock_liquidation.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';

/// Picks the highest tied-up-capital dead-stock item not already
/// listed for wholesale (Issue #411, acceptance criterion 1) — reuses
/// [ComputeDeadStockLiquidation]'s (#370) surplus detection over the
/// default 90-day lookback instead of a second heuristic.
class FindNextWholesaleCandidate {
  static DeadStockLiquidationSnapshot? call({
    required List<InventoryItemEntity> items,
    required List<StockMovementEntity> movements,
    required List<InventoryCostLayerEntity> layers,
    required List<WholesaleListingEntity> listings,
  }) {
    final listedIds = listings.map((l) => l.inventoryItemId).toSet();
    final candidates = ComputeDeadStockLiquidation.call(
            items, movements, layers, DateTime.now(), TurnoverPeriod.last90.duration)
        .where((s) => !listedIds.contains(s.item.id));
    return candidates.isEmpty ? null : candidates.first;
  }
}
