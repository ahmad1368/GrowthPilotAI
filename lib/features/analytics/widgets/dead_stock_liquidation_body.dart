import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_body_state.dart';

/// Owns the selected lookback period (Issue #370); state logic lives in
/// [DeadStockLiquidationBodyState].
class DeadStockLiquidationBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;
  final List<InventoryCostLayerEntity> layers;

  const DeadStockLiquidationBody({
    super.key,
    required this.items,
    required this.movements,
    required this.layers,
  });

  @override
  State<DeadStockLiquidationBody> createState() =>
      DeadStockLiquidationBodyState();
}
