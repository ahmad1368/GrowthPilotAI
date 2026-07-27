import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Purchase-order picker for a new goods receipt (Issue #444).
class GoodsReceiptOrderSelect extends StatelessWidget {
  final List<PurchaseOrderEntity> orders;
  final PurchaseOrderEntity? selectedOrder;
  final ValueChanged<PurchaseOrderEntity?> onChanged;

  const GoodsReceiptOrderSelect({
    super.key,
    required this.orders,
    required this.selectedOrder,
    required this.onChanged,
  });

  static String _label(PurchaseOrderEntity o) =>
      o.vendorName.isEmpty ? o.itemsSummary : o.vendorName;

  @override
  Widget build(BuildContext context) {
    return ShadSelect<PurchaseOrderEntity?>(
      initialValue: selectedOrder,
      placeholder: const Text('Select purchase order'),
      options: [for (final o in orders) ShadOption(value: o, child: Text(_label(o)))],
      selectedOptionBuilder: (context, value) =>
          Text(value == null ? 'Select purchase order' : _label(value)),
      onChanged: onChanged,
    );
  }
}
