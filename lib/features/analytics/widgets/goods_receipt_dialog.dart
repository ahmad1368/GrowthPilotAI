import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Opens the record-goods-receipt dialog (Issue #444). Returns the new
/// receipt (not yet persisted) or null if cancelled/invalid.
Future<GoodsReceiptEntity?> showGoodsReceiptDialog(
    BuildContext context, List<PurchaseOrderEntity> orders) {
  return showShadDialog<GoodsReceiptEntity>(
    context: context,
    builder: (context) => GoodsReceiptDialogContent(orders: orders),
  );
}
