import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

/// Default time/impression/click caps applied the instant a paid
/// campaign activates (Issue #410, acceptance criterion 4) — a
/// premium homepage banner runs longer with a higher ceiling than a
/// featured slot, mirroring the tiering already used by
/// [ComputeAdPackagePrice].
class DefaultConstraintForTier {
  static ({int days, int impressions, int clicks}) call(AdPackageType tier) {
    return switch (tier) {
      AdPackageType.homepageBanner => (days: 30, impressions: 10000, clicks: 1000),
      AdPackageType.featuredSlot => (days: 14, impressions: 3000, clicks: 300),
    };
  }
}
