import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/models/price_trend_point.dart';

/// Builds the chronological price trend for a SKU's price trend
/// chart (Issue #416, acceptance criterion 4).
class BuildPriceTrendPoints {
  static List<PriceTrendPoint> call(
      String productName, List<CompetitorPriceObservationEntity> observations) {
    final matches = observations
        .where((o) => o.productName.toLowerCase() == productName.toLowerCase())
        .toList()
      ..sort((a, b) => a.observedAt.compareTo(b.observedAt));
    return [
      for (final o in matches) PriceTrendPoint(observedAt: o.observedAt, price: o.competitorPrice),
    ];
  }
}
