import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// One item's basket-optimization suggestion (Issue #390).
class BasketOptimizationSnapshot {
  final InventoryItemEntity item;
  final double turnoverRatio;
  final int idealQuantity;
  final int excessQuantity;
  final int shortfallQuantity;
  final double holdingCostExposure;
  final String recommendedAction;

  const BasketOptimizationSnapshot({
    required this.item,
    required this.turnoverRatio,
    required this.idealQuantity,
    required this.excessQuantity,
    required this.shortfallQuantity,
    required this.holdingCostExposure,
    required this.recommendedAction,
  });
}
