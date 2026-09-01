import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_take_draft.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showStockTakeDialog] (Issue #441): owns the
/// selected item and physical-count controller.
class StockTakeDialogContent extends StatefulWidget {
  final List<InventoryItemEntity> items;

  const StockTakeDialogContent({super.key, required this.items});

  @override
  State<StockTakeDialogContent> createState() => _StockTakeDialogContentState();
}

class _StockTakeDialogContentState extends State<StockTakeDialogContent> {
  final _physicalCountController = TextEditingController();
  InventoryItemEntity? _selectedItem;

  void _submit() {
    final item = _selectedItem;
    final physicalCount = int.tryParse(_physicalCountController.text.trim());
    if (item == null || physicalCount == null || physicalCount < 0) return;

    final record = InventoryStockTakeEntity(
      itemName: item.name,
      systemQuantity: item.quantityOnHand,
      physicalQuantity: physicalCount,
      takenAt: DateTime.now(),
    );
    Navigator.of(context).pop(StockTakeDraft(record: record, item: item));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Record Stock Take'),
      description: StockTakeFields(
        items: widget.items,
        selectedItem: _selectedItem,
        onItemChanged: (value) => setState(() => _selectedItem = value),
        physicalCountController: _physicalCountController,
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
