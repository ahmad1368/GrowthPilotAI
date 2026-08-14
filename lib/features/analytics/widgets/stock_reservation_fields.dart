import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_item_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_quantity_input.dart';

/// Item + quantity fields for a new online-checkout reservation (Issue
/// #445).
class StockReservationFields extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final InventoryItemEntity? selectedItem;
  final ValueChanged<InventoryItemEntity?> onItemChanged;
  final TextEditingController quantityController;

  const StockReservationFields({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemChanged,
    required this.quantityController,
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
      ],
    );
  }
}
