import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';

/// Click-through rate of a sponsored card among its recorded impressions
/// (Issue #402, acceptance criterion 4).
class ComputePromoEngagementRate {
  static double call(PromoCardMetricsEntity? metrics) {
    if (metrics == null || metrics.impressionCount == 0) return 0;
    return double.parse(
        ((metrics.clickCount / metrics.impressionCount) * 100).toStringAsFixed(2));
  }
}
