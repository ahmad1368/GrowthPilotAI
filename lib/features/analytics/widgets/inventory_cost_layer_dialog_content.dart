import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_cost_layer_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_cost_layer_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_dialog_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showInventoryCostLayerDialog] (Issue #446).
class InventoryCostLayerDialogContent extends StatefulWidget {
  final List<InventoryItemEntity> items;

  const InventoryCostLayerDialogContent({super.key, required this.items});

  @override
  State<InventoryCostLayerDialogContent> createState() => _InventoryCostLayerDialogContentState();
}

class _InventoryCostLayerDialogContentState extends State<InventoryCostLayerDialogContent> {
  final _quantityController = TextEditingController();
  final _unitCostController = TextEditingController();
  InventoryItemEntity? _selectedItem;

  void _submit() {
    final item = _selectedItem;
    final quantity = int.tryParse(_quantityController.text.trim());
    final unitCost = double.tryParse(_unitCostController.text.trim());
    final valid = item != null && quantity != null && quantity > 0 && unitCost != null && unitCost >= 0;
    if (!valid) return;
    Navigator.of(context)
        .pop(InventoryCostLayerDraft(item: item, quantity: quantity, unitCost: unitCost));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Record Cost Layer'),
      description: InventoryCostLayerFields(
        items: widget.items,
        selectedItem: _selectedItem,
        onItemChanged: (v) => setState(() => _selectedItem = v),
        quantityController: _quantityController,
        unitCostController: _unitCostController,
      ),
      actions: [
        StockDialogActions(
            onCancel: () => Navigator.of(context).pop(), onSubmit: _submit, submitLabel: 'Save'),
      ],
    );
  }
}
