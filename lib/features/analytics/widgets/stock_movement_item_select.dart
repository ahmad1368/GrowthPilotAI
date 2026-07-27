import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Inventory-item picker for a new stock movement (Issue #439).
class StockMovementItemSelect extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final InventoryItemEntity? selectedItem;
  final ValueChanged<InventoryItemEntity?> onChanged;

  const StockMovementItemSelect({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ShadSelect<InventoryItemEntity?>(
      initialValue: selectedItem,
      placeholder: const Text('Select item'),
      options: [for (final item in items) ShadOption(value: item, child: Text(item.name))],
      selectedOptionBuilder: (context, value) => Text(value?.name ?? 'Select item'),
      onChanged: onChanged,
    );
  }
}
