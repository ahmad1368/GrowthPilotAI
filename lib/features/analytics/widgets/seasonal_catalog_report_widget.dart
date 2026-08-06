import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_body.dart';

/// Registers the Seasonal Advance Pre-Ordering Engine (Issue #417) as
/// a pluggable report widget under id `SEASONAL_PREORDER_ENGINE`
/// (#111).
class SeasonalCatalogReportWidget extends BaseReportWidget {
  const SeasonalCatalogReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return SeasonalCatalogBody(
        catalogItems: data['catalogItems'] as List<SeasonalCatalogItemEntity>);
  }
}
