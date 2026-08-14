import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

/// Maps a dependency score to its classification band (Issue #424,
/// acceptance criterion 3) — [MerchantDependencyTier.highDependency]
/// is the state that unlocks advanced billing tiers.
class ClassifyMerchantDependencyTier {
  static const highDependencyThreshold = 75;
  static const engagedThreshold = 40;

  static MerchantDependencyTier call(int score) {
    if (score >= highDependencyThreshold) return MerchantDependencyTier.highDependency;
    if (score >= engagedThreshold) return MerchantDependencyTier.engaged;
    return MerchantDependencyTier.standard;
  }
}
