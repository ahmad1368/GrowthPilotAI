import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_body.dart';

/// Registers the Wholesale Dead Stock Clearance marketplace (Issue
/// #411) as a pluggable report widget under id
/// `WHOLESALE_MARKETPLACE` (#111).
class WholesaleMarketplaceReportWidget extends BaseReportWidget {
  const WholesaleMarketplaceReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return WholesaleBody(
      items: data['items'] as List<InventoryItemEntity>,
      movements: data['movements'] as List<StockMovementEntity>,
      layers: data['layers'] as List<InventoryCostLayerEntity>,
    );
  }
}
