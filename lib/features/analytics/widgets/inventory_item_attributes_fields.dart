import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_attribute_row_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Dynamic list of custom key/value attribute rows (Issue #438), e.g.
/// "Size" -> "M" — a business-agnostic alternative to a fixed schema.
class InventoryItemAttributesFields extends StatelessWidget {
  final List<TextEditingController> keyControllers;
  final List<TextEditingController> valueControllers;
  final VoidCallback onAddRow;
  final ValueChanged<int> onRemoveRow;

  const InventoryItemAttributesFields({
    super.key,
    required this.keyControllers,
    required this.valueControllers,
    required this.onAddRow,
    required this.onRemoveRow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < keyControllers.length; i++)
          InventoryAttributeRowFields(
            keyController: keyControllers[i],
            valueController: valueControllers[i],
            onRemove: () => onRemoveRow(i),
          ),
        ShadButton.outline(onPressed: onAddRow, child: const Text('+ Attribute')),
      ],
    );
  }
}
