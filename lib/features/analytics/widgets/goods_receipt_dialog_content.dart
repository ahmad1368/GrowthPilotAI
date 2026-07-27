import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_form_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Form dialog for recording a new goods receipt (Issue #444).
class GoodsReceiptDialogContent extends StatefulWidget {
  final List<PurchaseOrderEntity> orders;

  const GoodsReceiptDialogContent({super.key, required this.orders});

  @override
  State<GoodsReceiptDialogContent> createState() => _GoodsReceiptDialogContentState();
}

class _GoodsReceiptDialogContentState extends State<GoodsReceiptDialogContent> {
  final _receivedItemsController = TextEditingController();
  final _damagedOrMissingController = TextEditingController();
  final _invoiceReferenceController = TextEditingController();
  final _invoiceAmountController = TextEditingController();
  PurchaseOrderEntity? _selectedOrder;

  void _submit() {
    final receivedItems = _receivedItemsController.text.trim();
    final invoiceAmount = double.tryParse(_invoiceAmountController.text.trim());
    if (receivedItems.isEmpty || invoiceAmount == null) return;

    final receipt = GoodsReceiptEntity(
      receivedItemsSummary: receivedItems,
      damagedOrMissingNotes: _damagedOrMissingController.text.trim(),
      invoiceReference: _invoiceReferenceController.text.trim(),
      invoiceAmount: invoiceAmount,
      receivedAt: DateTime.now(),
    );
    if (_selectedOrder != null) receipt.purchaseOrder.target = _selectedOrder;
    Navigator.of(context).pop(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Record Goods Receipt'),
      description: GoodsReceiptFormFields(
        orders: widget.orders,
        selectedOrder: _selectedOrder,
        onOrderChanged: (value) => setState(() => _selectedOrder = value),
        receivedItemsController: _receivedItemsController,
        damagedOrMissingController: _damagedOrMissingController,
        invoiceReferenceController: _invoiceReferenceController,
        invoiceAmountController: _invoiceAmountController,
      ),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
