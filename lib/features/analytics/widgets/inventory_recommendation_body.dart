import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_inventory_recommendations.dart';
import 'package:growth_pilot_ai/business/compute_recommendation_confidence.dart';
import 'package:growth_pilot_ai/business/compute_stock_depletion_forecast.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_recommendation.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_view.dart';

/// Owns the recommendation feed and feedback state for the AI-driven
/// missing inventory engine (Issue #418).
class InventoryRecommendationBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;
  final List<BudgetLimitEntity> budgetLimits;

  const InventoryRecommendationBody({
    super.key,
    required this.items,
    required this.movements,
    required this.budgetLimits,
  });

  @override
  State<InventoryRecommendationBody> createState() => _InventoryRecommendationBodyState();
}

class _InventoryRecommendationBodyState extends State<InventoryRecommendationBody> {
  final _repos = InventoryRecommendationRepos();
  late final _actions = InventoryRecommendationActions(_repos);
  late List<InventoryRecommendation> _recommendations = _buildRecommendations();

  List<InventoryRecommendation> _buildRecommendations() {
    final forecasts = ComputeStockDepletionForecast.call(
        widget.items, widget.movements, DateTime.now(), const Duration(days: 30));
    return BuildInventoryRecommendations.call(forecasts, _repos.listings.getAll(), widget.budgetLimits);
  }

  double _confidenceFor(String itemName) =>
      ComputeRecommendationConfidence.call(_repos.feedback.forItem(itemName));

  void _requisition(InventoryRecommendation recommendation) {
    final listing = recommendation.matchedListing;
    if (listing == null) return;
    // This app has no auth/session system, so the buyer identity
    // defaults to the same single-merchant identity BuildAuditLogEntry
    // already hardcodes.
    _actions.requisition(listing, 'Ahmad_Salem_Pour');
    setState(() => _recommendations = _buildRecommendations());
  }

  void _dismiss(InventoryRecommendation recommendation) {
    _actions.dismiss(recommendation.forecast.item.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InventoryRecommendationView(
      recommendations: _recommendations,
      confidenceFor: _confidenceFor,
      onRequisition: _requisition,
      onDismiss: _dismiss,
    );
  }
}
