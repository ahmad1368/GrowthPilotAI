import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_body.dart';

/// Registers the AI-Driven Missing Inventory Recommendation Engine
/// (Issue #418) as a pluggable report widget under id
/// `INVENTORY_RECOMMENDATION_ENGINE` (#111).
class InventoryRecommendationReportWidget extends BaseReportWidget {
  const InventoryRecommendationReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return InventoryRecommendationBody(
      items: data['items'] as List<InventoryItemEntity>,
      movements: data['movements'] as List<StockMovementEntity>,
      budgetLimits: data['budgetLimits'] as List<BudgetLimitEntity>,
    );
  }
}
