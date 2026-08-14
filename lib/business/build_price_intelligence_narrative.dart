import 'package:growth_pilot_ai/core/enum/price_deal_tier.dart';

/// One-sentence read summarizing a Fair Price Index query result
/// (Issue #416), mirroring [BuildEscrowNarrative]'s summary pattern.
class BuildPriceIntelligenceNarrative {
  static String call(int sampleCount, double fairPriceIndex, PriceDealTier tier) {
    if (sampleCount == 0) {
      return 'No regional price telemetry logged for this item yet.';
    }
    final percent = ((fairPriceIndex - 1) * 100).toStringAsFixed(0);
    final direction = fairPriceIndex >= 1 ? 'below' : 'above';
    return 'Based on $sampleCount observation(s): this listing is '
        '${percent.replaceFirst('-', '')}% $direction the regional baseline — ${tier.name}.';
  }
}
