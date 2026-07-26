import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_body.dart';

/// Registers the Automated Purchase Order widget (Issue #443) as a
/// pluggable report widget under id `PURCHASE_ORDER` (#111).
class PurchaseOrderReportWidget extends BaseReportWidget {
  const PurchaseOrderReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PurchaseOrderBody(
      initialOrders: data['orders'] as List<PurchaseOrderEntity>,
      items: data['items'] as List<InventoryItemEntity>,
    );
  }
}
