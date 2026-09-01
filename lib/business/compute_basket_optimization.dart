import 'dart:math';

import 'package:growth_pilot_ai/business/compute_inventory_turnover_and_aging.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/basket_optimization_snapshot.dart';

/// Balances stock holding cost against sales velocity (Issue #390): derives
/// the ideal quantity to retain per item and flags reorder/reduce actions,
/// reusing [ComputeInventoryTurnoverAndAging] (#447) for the underlying
/// sales-velocity computation.
class ComputeBasketOptimization {
  static const _targetCoverageDays = 30;

  static List<BasketOptimizationSnapshot> call(
    List<InventoryItemEntity> items,
    List<StockMovementEntity> movements,
    List<InventoryCostLayerEntity> layers,
    DateTime now,
    Duration period,
  ) {
    final snapshots = ComputeInventoryTurnoverAndAging.call(
        items, movements, layers, now, period);

    return snapshots.map((s) {
      final item = s.item;
      final dailyVelocity = s.salesUnits / period.inDays;
      final idealQuantity =
          max((dailyVelocity * _targetCoverageDays).round(), item.reorderThreshold);

      final excessQuantity = max(0, item.quantityOnHand - idealQuantity);
      final shortfallQuantity = max(0, idealQuantity - item.quantityOnHand);
      final holdingCostExposure = item.unitCost * excessQuantity;

      final recommendedAction = shortfallQuantity > 0
          ? 'Reorder $shortfallQuantity units'
          : (excessQuantity > 0 ? 'Reduce by $excessQuantity units' : 'Optimal');

      return BasketOptimizationSnapshot(
        item: item,
        turnoverRatio: s.turnoverRatio,
        idealQuantity: idealQuantity,
        excessQuantity: excessQuantity,
        shortfallQuantity: shortfallQuantity,
        holdingCostExposure: holdingCostExposure,
        recommendedAction: recommendedAction,
      );
    }).toList()
      ..sort((a, b) => b.holdingCostExposure.compareTo(a.holdingCostExposure));
  }
}
