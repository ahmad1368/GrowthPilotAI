import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_body_state.dart';

/// Owns the cost-layer list and selected method (Issue #446); state logic
/// lives in [InventoryValuationBodyState].
class InventoryValuationBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<InventoryCostLayerEntity> initialLayers;

  const InventoryValuationBody({super.key, required this.items, required this.initialLayers});

  @override
  State<InventoryValuationBody> createState() => InventoryValuationBodyState();
}
