import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Item picker + physical-count input for a new stock-take audit (Issue
/// #441).
class StockTakeFields extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final InventoryItemEntity? selectedItem;
  final ValueChanged<InventoryItemEntity?> onItemChanged;
  final TextEditingController physicalCountController;

  const StockTakeFields({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemChanged,
    required this.physicalCountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadSelect<InventoryItemEntity?>(
          initialValue: selectedItem,
          placeholder: const Text('Select item'),
          options: [
            for (final item in items) ShadOption(value: item, child: Text(item.name)),
          ],
          selectedOptionBuilder: (context, value) => Text(value?.name ?? 'Select item'),
          onChanged: onItemChanged,
        ),
        const SizedBox(height: 8),
        ShadInput(
          placeholder: const Text('Physical count'),
          controller: physicalCountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }
}
