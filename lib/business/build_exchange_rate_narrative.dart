import 'package:growth_pilot_ai/core/models/exchange_rate_impact.dart';

/// One-sentence read naming the biggest logged currency cost risk and the
/// recommended price adjustment to hold margin (Issue #371).
class BuildExchangeRateNarrative {
  static String call(List<ExchangeRateImpact> results) {
    if (results.isEmpty) {
      return 'No exchange rate checks logged yet — add one to start tracking landed-cost impact.';
    }
    final worst = results.first;
    if (results.length == 1) {
      return worst.costIncreased
          ? '${worst.productName} landed cost rose ${worst.costImpactPercent.toStringAsFixed(1)}% on ${worst.currencyPair} — '
              'consider a matching retail price bump to hold margin.'
          : '${worst.productName} landed cost fell ${worst.costImpactPercent.abs().toStringAsFixed(1)}% on ${worst.currencyPair}.';
    }
    final best = results.last;
    return '${worst.productName} carries the biggest currency risk on ${worst.currencyPair} at '
        '${worst.costImpactPercent.toStringAsFixed(1)}% landed-cost impact — '
        '${best.productName} is the safest at ${best.costImpactPercent.toStringAsFixed(1)}%.';
  }
}
