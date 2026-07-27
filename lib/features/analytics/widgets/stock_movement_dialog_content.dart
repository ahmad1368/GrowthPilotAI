import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_movement_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showStockMovementDialog] (Issue #439).
class StockMovementDialogContent extends StatefulWidget {
  final List<InventoryItemEntity> items;

  const StockMovementDialogContent({super.key, required this.items});

  @override
  State<StockMovementDialogContent> createState() => _StockMovementDialogContentState();
}

class _StockMovementDialogContentState extends State<StockMovementDialogContent> {
  final _quantityController = TextEditingController();
  InventoryItemEntity? _selectedItem;
  StockMovementType _type = StockMovementType.sale;

  void _submit() {
    final item = _selectedItem;
    final quantity = int.tryParse(_quantityController.text.trim());
    if (item == null || quantity == null || quantity <= 0) return;
    Navigator.of(context).pop(StockMovementDraft(item: item, quantity: quantity, type: _type));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Record Stock Movement'),
      description: StockMovementFields(
        items: widget.items,
        selectedItem: _selectedItem,
        onItemChanged: (value) => setState(() => _selectedItem = value),
        type: _type,
        onTypeChanged: (value) => setState(() => _type = value ?? _type),
        quantityController: _quantityController,
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
