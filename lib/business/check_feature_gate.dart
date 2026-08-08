import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// "SubscriptionGuard/FeatureGateGuard" tier comparison (Issue #150) —
/// mirrors the issue's own `tierWeights` spec
/// (`{STARTER:1, PRO:2, ENTERPRISE:3}`) so a premium feature (e.g. the
/// Market Trends dashboard from #148) is unlocked at its required tier
/// or above.
class CheckFeatureGate {
  static const _weights = {
    SubscriptionTier.starter: 1,
    SubscriptionTier.pro: 2,
    SubscriptionTier.enterprise: 3,
  };

  static bool call({required SubscriptionTier currentTier, required SubscriptionTier requiredTier}) {
    return _weights[currentTier]! >= _weights[requiredTier]!;
  }
}
