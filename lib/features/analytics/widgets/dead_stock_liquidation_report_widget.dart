import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_body.dart';

class DeadStockLiquidationReportWidget extends BaseReportWidget {
  const DeadStockLiquidationReportWidget({
    super.key,
    required super.data,
    required super.title,
  });

  @override
  Widget buildContent(BuildContext context) {
    return DeadStockLiquidationBody(
      items: data['items'] as List<InventoryItemEntity>,
      movements: data['movements'] as List<StockMovementEntity>,
      layers: data['layers'] as List<InventoryCostLayerEntity>,
    );
  }
}
