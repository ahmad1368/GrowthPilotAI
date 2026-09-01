import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_item_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_quantity_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_unit_cost_input.dart';

/// Item + quantity + unit-cost fields for a new cost layer (Issue #446).
class InventoryCostLayerFields extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final InventoryItemEntity? selectedItem;
  final ValueChanged<InventoryItemEntity?> onItemChanged;
  final TextEditingController quantityController;
  final TextEditingController unitCostController;

  const InventoryCostLayerFields({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemChanged,
    required this.quantityController,
    required this.unitCostController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StockMovementItemSelect(items: items, selectedItem: selectedItem, onChanged: onItemChanged),
        const SizedBox(height: 8),
        StockQuantityInput(controller: quantityController),
        const SizedBox(height: 8),
        StockUnitCostInput(controller: unitCostController),
      ],
    );
  }
}
