import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_body.dart';

/// Registers the Goods Receipt & Invoice Matching widget (Issue #444) as a
/// pluggable report widget under id `GOODS_RECEIPT` (#111).
class GoodsReceiptReportWidget extends BaseReportWidget {
  const GoodsReceiptReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return GoodsReceiptBody(
      initialReceipts: data['receipts'] as List<GoodsReceiptEntity>,
      orders: data['orders'] as List<PurchaseOrderEntity>,
    );
  }
}
