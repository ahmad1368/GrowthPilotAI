import 'package:growth_pilot_ai/core/enum/price_deal_tier.dart';

/// Buckets a Fair Price Index into the visual badge tier (Issue
/// #416, acceptance criterion 3) — mirrors [DefaultConstraintForTier]'s
/// switch-on-value style.
class ClassifyPriceDeal {
  static PriceDealTier call(double fairPriceIndex) {
    return switch (fairPriceIndex) {
      >= 1.15 => PriceDealTier.greatDeal,
      <= 0.85 => PriceDealTier.overpriced,
      _ => PriceDealTier.fairPrice,
    };
  }
}
