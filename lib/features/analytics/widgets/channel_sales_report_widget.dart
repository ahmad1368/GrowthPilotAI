import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_sales_body.dart';

/// Registers the Online vs In-Store Sales Performance Comparative
/// Analyzer (Issue #384) as a pluggable report widget under id
/// `CHANNEL_SALES_COMPARISON` (#111).
class ChannelSalesReportWidget extends BaseReportWidget {
  const ChannelSalesReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ChannelSalesBody(
      movements: data['movements'] as List<StockMovementEntity>,
      items: data['items'] as List<InventoryItemEntity>,
    );
  }
}
