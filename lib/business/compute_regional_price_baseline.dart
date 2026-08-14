import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';

/// Cross-references a SKU against logged regional market telemetry to
/// compute a baseline price (Issue #416, acceptance criteria 1-2) —
/// this app has no live supplier-catalog feed, so the baseline is the
/// average of this device's own [CompetitorPriceObservationEntity]
/// log for matching product names, mirroring the simplification
/// [BuildCompetitorPriceNarrative] already uses for that same data.
class ComputeRegionalPriceBaseline {
  static ({double averagePrice, int sampleCount}) call(
      String productName, List<CompetitorPriceObservationEntity> observations) {
    final matches = observations
        .where((o) => o.productName.toLowerCase() == productName.toLowerCase())
        .toList();
    if (matches.isEmpty) return (averagePrice: 0, sampleCount: 0);
    final total = matches.fold<double>(0, (sum, o) => sum + o.competitorPrice);
    return (averagePrice: total / matches.length, sampleCount: matches.length);
  }
}
