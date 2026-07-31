import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/core/models/exchange_rate_impact.dart';

/// Derives each logged FX observation's landed-cost impact vs. its
/// baseline rate (Issue #371) — this app has no live currency-pair feed,
/// so impact is computed from manually-logged rate checks instead. The
/// required retail-price bump to hold margin mirrors the cost-impact
/// percent, since margin is preserved by passing the cost delta through.
class ComputeExchangeRateImpacts {
  static List<ExchangeRateImpact> call(
      List<ExchangeRateObservationEntity> observations) {
    final results = observations.map((o) {
      final landedCostBaseline = o.importCostForeign * o.baselineRate;
      final landedCostCurrent = o.importCostForeign * o.currentRate;
      final costImpact = landedCostCurrent - landedCostBaseline;
      final costImpactPercent =
          landedCostBaseline == 0 ? 0.0 : (costImpact / landedCostBaseline) * 100;

      return ExchangeRateImpact(
        currencyPair: o.currencyPair,
        productName: o.productName,
        baselineRate: o.baselineRate,
        currentRate: o.currentRate,
        landedCostBaseline: landedCostBaseline,
        landedCostCurrent: landedCostCurrent,
        costImpact: costImpact,
        costImpactPercent: costImpactPercent,
        observedAt: o.observedAt,
      );
    }).toList();

    results.sort((a, b) => b.costImpactPercent.compareTo(a.costImpactPercent));
    return results;
  }
}
