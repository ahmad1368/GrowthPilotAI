import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_body_state.dart';

/// Owns the selected lookback period (Issue #390); state logic lives in
/// [BasketOptimizationBodyState].
class BasketOptimizationBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;
  final List<InventoryCostLayerEntity> layers;

  const BasketOptimizationBody({
    super.key,
    required this.items,
    required this.movements,
    required this.layers,
  });

  @override
  State<BasketOptimizationBody> createState() =>
      BasketOptimizationBodyState();
}
