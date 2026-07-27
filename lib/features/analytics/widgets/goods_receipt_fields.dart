import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_order_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Order picker + received-items + damaged/missing fields for a new goods
/// receipt (Issue #444). Invoice fields live in [GoodsReceiptInvoiceFields].
class GoodsReceiptFields extends StatelessWidget {
  final List<PurchaseOrderEntity> orders;
  final PurchaseOrderEntity? selectedOrder;
  final ValueChanged<PurchaseOrderEntity?> onOrderChanged;
  final TextEditingController receivedItemsController;
  final TextEditingController damagedOrMissingController;

  const GoodsReceiptFields({
    super.key,
    required this.orders,
    required this.selectedOrder,
    required this.onOrderChanged,
    required this.receivedItemsController,
    required this.damagedOrMissingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoodsReceiptOrderSelect(
            orders: orders, selectedOrder: selectedOrder, onChanged: onOrderChanged),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Items received'),
            controller: receivedItemsController,
            maxLines: 2),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Damaged/missing items (optional)'),
            controller: damagedOrMissingController,
            maxLines: 2),
      ],
    );
  }
}
