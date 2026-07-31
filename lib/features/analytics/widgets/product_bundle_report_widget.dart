import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_product_bundle_recommendations.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/product_bundle_recommendation_view.dart';

/// Registers the Smart Product Bundling Recommendation Tool (Issue #378)
/// as a pluggable report widget under id `PRODUCT_BUNDLING` (#111).
class ProductBundleReportWidget extends BaseReportWidget {
  const ProductBundleReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final recommendations = ComputeProductBundleRecommendations.call(
      data['movements'] as List<StockMovementEntity>,
      data['items'] as List<InventoryItemEntity>,
    );
    return ProductBundleRecommendationView(recommendations: recommendations);
  }
}
