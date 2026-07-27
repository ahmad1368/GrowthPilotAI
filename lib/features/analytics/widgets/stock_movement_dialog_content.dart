import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_movement_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_dialog_actions.dart';
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
  SalesChannel _channel = SalesChannel.pos;

  void _submit() {
    final item = _selectedItem;
    final quantity = int.tryParse(_quantityController.text.trim());
    if (item == null || quantity == null || quantity <= 0) return;
    final draft = StockMovementDraft(item: item, quantity: quantity, type: _type, channel: _channel);
    Navigator.of(context).pop(draft);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Record Stock Movement'),
      description: StockMovementFields(
        items: widget.items,
        selectedItem: _selectedItem, onItemChanged: (v) => setState(() => _selectedItem = v),
        type: _type, onTypeChanged: (v) => setState(() => _type = v ?? _type),
        channel: _channel, onChannelChanged: (v) => setState(() => _channel = v ?? _channel),
        quantityController: _quantityController,
      ),
      actions: [
        StockDialogActions(
            onCancel: () => Navigator.of(context).pop(), onSubmit: _submit, submitLabel: 'Save'),
      ],
    );
  }
}
