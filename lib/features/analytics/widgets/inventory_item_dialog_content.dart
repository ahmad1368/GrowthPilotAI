import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showInventoryItemDialog] (Issue #435): owns the
/// name/quantity/reorder-threshold/unit-cost/category state (category
/// picker added in #436).
class InventoryItemDialogContent extends StatefulWidget {
  final List<InventoryCategoryEntity> categories;

  const InventoryItemDialogContent({super.key, required this.categories});

  @override
  State<InventoryItemDialogContent> createState() => _InventoryItemDialogContentState();
}

class _InventoryItemDialogContentState extends State<InventoryItemDialogContent> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _reorderThresholdController = TextEditingController();
  final _unitCostController = TextEditingController();
  InventoryCategoryEntity? _category;

  void _submit() {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim());
    final reorderThreshold = int.tryParse(_reorderThresholdController.text.trim());
    final unitCost = double.tryParse(_unitCostController.text.trim());
    if (name.isEmpty || quantity == null || reorderThreshold == null || unitCost == null) {
      return;
    }
    final item = InventoryItemEntity(
      name: name,
      quantityOnHand: quantity,
      reorderThreshold: reorderThreshold,
      unitCost: unitCost,
    );
    if (_category != null) item.category.target = _category;
    Navigator.of(context).pop(item);
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
        categories: widget.categories,
        selectedCategory: _category,
        onCategoryChanged: (value) => setState(() => _category = value),
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
