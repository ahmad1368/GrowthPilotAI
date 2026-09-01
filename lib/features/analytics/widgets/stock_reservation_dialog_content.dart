import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_reservation_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_dialog_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showStockReservationDialog] (Issue #445).
class StockReservationDialogContent extends StatefulWidget {
  final List<InventoryItemEntity> items;

  const StockReservationDialogContent({super.key, required this.items});

  @override
  State<StockReservationDialogContent> createState() => _StockReservationDialogContentState();
}

class _StockReservationDialogContentState extends State<StockReservationDialogContent> {
  final _quantityController = TextEditingController();
  InventoryItemEntity? _selectedItem;

  void _submit() {
    final item = _selectedItem;
    final quantity = int.tryParse(_quantityController.text.trim());
    if (item == null || quantity == null || quantity <= 0) return;
    Navigator.of(context).pop(StockReservationDraft(item: item, quantity: quantity));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Reserve for Online Checkout'),
      description: StockReservationFields(
        items: widget.items,
        selectedItem: _selectedItem,
        onItemChanged: (value) => setState(() => _selectedItem = value),
        quantityController: _quantityController,
      ),
      actions: [
        StockDialogActions(
            onCancel: () => Navigator.of(context).pop(), onSubmit: _submit, submitLabel: 'Reserve'),
      ],
    );
  }
}
