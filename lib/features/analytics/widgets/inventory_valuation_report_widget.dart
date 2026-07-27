import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_body.dart';

/// Registers the Inventory Valuation Reporting widget (Issue #446) as a
/// pluggable report widget under id `INVENTORY_VALUATION` (#111).
class InventoryValuationReportWidget extends BaseReportWidget {
  const InventoryValuationReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return InventoryValuationBody(
      items: data['items'] as List<InventoryItemEntity>,
      initialLayers: data['layers'] as List<InventoryCostLayerEntity>,
    );
  }
}
