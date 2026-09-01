import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/models/competitor_price_gap.dart';

/// Derives each logged competitor price observation's gap vs. our own
/// price (Issue #351) — this app has no scraping/real-time competitor
/// feed, so gaps are computed from manually-logged observations instead.
class ComputeCompetitorPriceGaps {
  static List<CompetitorPriceGap> call(
      List<CompetitorPriceObservationEntity> observations) {
    final results = observations.map((o) {
      final priceGap = o.ourPrice - o.competitorPrice;
      final gapPercent =
          o.competitorPrice == 0 ? 0.0 : (priceGap / o.competitorPrice) * 100;

      return CompetitorPriceGap(
        productName: o.productName,
        competitorName: o.competitorName,
        ourPrice: o.ourPrice,
        competitorPrice: o.competitorPrice,
        priceGap: priceGap,
        gapPercent: gapPercent,
        isPricedAboveCompetitor: priceGap > 0,
      );
    }).toList();

    results.sort((a, b) => b.gapPercent.compareTo(a.gapPercent));
    return results;
  }
}
