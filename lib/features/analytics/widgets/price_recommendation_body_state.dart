import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_price_recommendations.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_recommendation_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_recommendation_view.dart';

/// State for [PriceRecommendationBody] (Issue #356): recomputes price
/// recommendations for the selected period.
class PriceRecommendationBodyState extends State<PriceRecommendationBody> {
  TurnoverPeriod _period = TurnoverPeriod.last90;

  @override
  Widget build(BuildContext context) {
    final recommendations = ComputePriceRecommendations.call(
      widget.items,
      widget.movements,
      widget.layers,
      DateTime.now(),
      _period.duration,
    );

    return PriceRecommendationView(
      period: _period,
      onPeriodChanged: (p) => setState(() => _period = p ?? _period),
      recommendations: recommendations,
    );
  }
}
