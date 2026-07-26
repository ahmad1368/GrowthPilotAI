import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_body.dart';

/// Registers the Inventory Management widget (Issue #435, hierarchical
/// categories added in #436, supplier association in #442) as a pluggable
/// report widget under id `INVENTORY_STOCK` (#111).
class InventoryReportWidget extends BaseReportWidget {
  const InventoryReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return InventoryReportBody(
      initialItems: data['items'] as List<InventoryItemEntity>,
      initialCategories: data['categories'] as List<InventoryCategoryEntity>,
      vendors: data['vendors'] as List<VendorEntity>,
    );
  }
}
