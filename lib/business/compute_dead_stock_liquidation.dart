import 'package:growth_pilot_ai/business/compute_inventory_turnover_and_aging.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';

/// Flags zero-turnover stock over the selected [period] (Issue #370) and
/// suggests a liquidation channel, reusing [ComputeInventoryTurnoverAndAging]
/// (#447) for the underlying sales/aging computation.
class ComputeDeadStockLiquidation {
  static const _clearanceDiscount = 0.5;
  static const _bundlingQtyThreshold = 10;
  static const _donationAgingDays = 180;

  static List<DeadStockLiquidationSnapshot> call(
    List<InventoryItemEntity> items,
    List<StockMovementEntity> movements,
    List<InventoryCostLayerEntity> layers,
    DateTime now,
    Duration period,
  ) {
    final snapshots = ComputeInventoryTurnoverAndAging.call(
        items, movements, layers, now, period);

    return snapshots
        .where((s) => s.salesUnits == 0 && s.item.quantityOnHand > 0)
        .map((s) {
      final item = s.item;
      final tiedUpCapital = item.unitCost * item.quantityOnHand;
      final clearancePrice = item.unitCost * _clearanceDiscount;
      final channel = s.agingDays >= _donationAgingDays
          ? 'Donation channel'
          : (item.quantityOnHand >= _bundlingQtyThreshold
              ? 'Bundling'
              : 'Clearance pricing');

      return DeadStockLiquidationSnapshot(
        item: item,
        agingDays: s.agingDays,
        tiedUpCapital: tiedUpCapital,
        suggestedClearancePrice: clearancePrice,
        recoverableCapital: clearancePrice * item.quantityOnHand,
        suggestedChannel: channel,
      );
    }).toList()
      ..sort((a, b) => b.tiedUpCapital.compareTo(a.tiedUpCapital));
  }
}
