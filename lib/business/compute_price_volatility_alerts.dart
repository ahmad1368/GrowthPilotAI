import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';

/// Derives each product's most recent price swing from its logged price
/// observations (Issue #340) — this app has no price-ingestion backend,
/// so [CompetitorPriceObservationEntity.ourPrice] readings logged over
/// time double as our own price history. A product needs at least two
/// readings to have a measurable swing.
class ComputePriceVolatilityAlerts {
  static List<PriceVolatilityAlert> call(
      List<CompetitorPriceObservationEntity> observations,
      double thresholdPercent) {
    final byProduct = <String, List<CompetitorPriceObservationEntity>>{};
    for (final o in observations) {
      (byProduct[o.productName] ??= []).add(o);
    }

    final results = <PriceVolatilityAlert>[];
    for (final readings in byProduct.values) {
      readings.sort((a, b) => a.observedAt.compareTo(b.observedAt));
      if (readings.length < 2) continue;
      final previous = readings[readings.length - 2];
      final current = readings.last;
      if (previous.ourPrice == 0) continue;

      final changePercent =
          ((current.ourPrice - previous.ourPrice) / previous.ourPrice) * 100;
      results.add(PriceVolatilityAlert(
        productName: current.productName,
        previousPrice: previous.ourPrice,
        currentPrice: current.ourPrice,
        changePercent: double.parse(changePercent.toStringAsFixed(2)),
        isBreached: changePercent.abs() >= thresholdPercent,
        observedAt: current.observedAt,
      ));
    }

    results.sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));
    return results;
  }
}
