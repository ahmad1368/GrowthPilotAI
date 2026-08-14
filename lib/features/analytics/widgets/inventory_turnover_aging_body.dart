import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_body_state.dart';

/// Owns the selected lookback period (Issue #447); state logic lives in
/// [InventoryTurnoverAgingBodyState].
class InventoryTurnoverAgingBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;
  final List<InventoryCostLayerEntity> layers;
  final BusinessSector sector;

  const InventoryTurnoverAgingBody({
    super.key,
    required this.items,
    required this.movements,
    required this.layers,
    required this.sector,
  });

  @override
  State<InventoryTurnoverAgingBody> createState() =>
      InventoryTurnoverAgingBodyState();
}
