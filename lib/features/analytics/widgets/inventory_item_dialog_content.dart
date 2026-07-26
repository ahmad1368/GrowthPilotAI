import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showInventoryItemDialog] (Issue #435): owns the
/// name/quantity/reorder-threshold/unit-cost controllers.
class InventoryItemDialogContent extends StatefulWidget {
  const InventoryItemDialogContent({super.key});

  @override
  State<InventoryItemDialogContent> createState() => _InventoryItemDialogContentState();
}

class _InventoryItemDialogContentState extends State<InventoryItemDialogContent> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _reorderThresholdController = TextEditingController();
  final _unitCostController = TextEditingController();

  void _submit() {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim());
    final reorderThreshold = int.tryParse(_reorderThresholdController.text.trim());
    final unitCost = double.tryParse(_unitCostController.text.trim());
    if (name.isEmpty || quantity == null || reorderThreshold == null || unitCost == null) {
      return;
    }
    Navigator.of(context).pop(InventoryItemEntity(
      name: name,
      quantityOnHand: quantity,
      reorderThreshold: reorderThreshold,
      unitCost: unitCost,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Add Inventory Item'),
      description: InventoryItemFields(
        nameController: _nameController,
        quantityController: _quantityController,
        reorderThresholdController: _reorderThresholdController,
        unitCostController: _unitCostController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
