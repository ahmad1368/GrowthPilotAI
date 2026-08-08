import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// Monthly CAD price per tier (Issue #150) — Starter stays free so a
/// new business always has a usable account before ever paying.
class MonthlyPriceForTier {
  static double call(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.starter:
        return 0.0;
      case SubscriptionTier.pro:
        return 29.99;
      case SubscriptionTier.enterprise:
        return 99.99;
    }
  }
}
