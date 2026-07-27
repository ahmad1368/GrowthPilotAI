import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/goods_receipt_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_view.dart';

/// Owns the goods-receipt list (Issue #444), refreshing it locally after
/// each receipt is recorded. Rendering itself is [GoodsReceiptView]'s job.
class GoodsReceiptBody extends StatefulWidget {
  final List<GoodsReceiptEntity> initialReceipts;
  final List<PurchaseOrderEntity> orders;

  const GoodsReceiptBody({super.key, required this.initialReceipts, required this.orders});

  @override
  State<GoodsReceiptBody> createState() => _GoodsReceiptBodyState();
}

class _GoodsReceiptBodyState extends State<GoodsReceiptBody> {
  late List<GoodsReceiptEntity> _receipts = widget.initialReceipts;

  Future<void> _recordReceipt() async {
    final receipt = await showGoodsReceiptDialog(context, widget.orders);
    if (receipt == null) return;
    GoodsReceiptRepository(Get.find<ObjectBox>().store.box<GoodsReceiptEntity>())
        .insert(receipt);
    setState(() => _receipts = [..._receipts, receipt]);
  }

  @override
  Widget build(BuildContext context) =>
      GoodsReceiptView(receipts: _receipts, onRecordReceipt: _recordReceipt);
}
