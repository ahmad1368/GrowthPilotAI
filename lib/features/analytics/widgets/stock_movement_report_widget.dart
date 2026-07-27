import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_body.dart';

/// Registers the Real-Time Stock Tracking Engine widget (Issue #439) as a
/// pluggable report widget under id `STOCK_MOVEMENT` (#111).
class StockMovementReportWidget extends BaseReportWidget {
  const StockMovementReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return StockMovementBody(
      initialMovements: data['movements'] as List<StockMovementEntity>,
      items: data['items'] as List<InventoryItemEntity>,
    );
  }
}
