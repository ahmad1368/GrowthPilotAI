import 'package:growth_pilot_ai/core/models/distilled_context.dart';

/// "Insight Thresholds" (Issue #108 scope item 2): a cached item is
/// worth surfacing when it's a #103 Hidden Gem or sits in the "Top 5%
/// Value" bracket the issue's own example calls out — both signals
/// already live in the #106 encrypted cache, so no price-history
/// comparison is needed to flag them.
class IsHighValueInsight {
  static const topValuePercentile = 0.05;

  static bool call(DistilledContext context) {
    final pricePosition = context.pricePosition;
    return context.isHiddenGem || (pricePosition != null && pricePosition <= topValuePercentile);
  }
}
