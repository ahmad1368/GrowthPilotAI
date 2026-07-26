import 'package:growth_pilot_ai/core/models/regional_affordability_result.dart';

/// Turns a [RegionalAffordabilityResult] into one human-readable pricing
/// recommendation sentence (Issue #397's `REGIONAL_AFFORDABILITY` widget).
class BuildAffordabilityRecommendation {
  static String call(RegionalAffordabilityResult result) {
    switch (result.tier) {
      case AffordabilityTier.underpriced:
        return 'Your average basket is well below regional purchasing power - '
            'there may be room to raise prices without pricing out local customers.';
      case AffordabilityTier.aligned:
        return 'Your average basket is well-aligned with regional purchasing power.';
      case AffordabilityTier.overpriced:
        return 'Your average basket is high relative to regional purchasing power - '
            'consider tiered pricing or smaller offerings to stay accessible.';
    }
  }
}
