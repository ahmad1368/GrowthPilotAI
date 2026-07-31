import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_body.dart';

/// Registers the Inventory Stock Depletion Warning System (Issue #360) as
/// a pluggable report widget under id `STOCK_DEPLETION_FORECAST` (#111).
class StockDepletionForecastReportWidget extends BaseReportWidget {
  const StockDepletionForecastReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return StockDepletionForecastBody(
      items: data['items'] as List<InventoryItemEntity>,
      movements: data['movements'] as List<StockMovementEntity>,
    );
  }
}
