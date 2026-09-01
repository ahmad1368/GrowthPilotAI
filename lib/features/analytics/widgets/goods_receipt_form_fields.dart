import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_invoice_fields.dart';

/// Combines the receipt fields and invoice fields for the record-receipt
/// dialog (Issue #444).
class GoodsReceiptFormFields extends StatelessWidget {
  final List<PurchaseOrderEntity> orders;
  final PurchaseOrderEntity? selectedOrder;
  final ValueChanged<PurchaseOrderEntity?> onOrderChanged;
  final TextEditingController receivedItemsController;
  final TextEditingController damagedOrMissingController;
  final TextEditingController invoiceReferenceController;
  final TextEditingController invoiceAmountController;

  const GoodsReceiptFormFields({
    super.key,
    required this.orders,
    required this.selectedOrder,
    required this.onOrderChanged,
    required this.receivedItemsController,
    required this.damagedOrMissingController,
    required this.invoiceReferenceController,
    required this.invoiceAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoodsReceiptFields(
          orders: orders,
          selectedOrder: selectedOrder,
          onOrderChanged: onOrderChanged,
          receivedItemsController: receivedItemsController,
          damagedOrMissingController: damagedOrMissingController,
        ),
        const SizedBox(height: 8),
        GoodsReceiptInvoiceFields(
          invoiceReferenceController: invoiceReferenceController,
          invoiceAmountController: invoiceAmountController,
        ),
      ],
    );
  }
}
