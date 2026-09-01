import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_body.dart';

/// Registers the Periodic Stock Take & Reconciliation widget (Issue #441)
/// as a pluggable report widget under id `STOCK_TAKE` (#111).
class StockTakeReportWidget extends BaseReportWidget {
  const StockTakeReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return StockTakeBody(
      initialRecords: data['records'] as List<InventoryStockTakeEntity>,
      items: data['items'] as List<InventoryItemEntity>,
    );
  }
}
