import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

/// The advertising needs-assessment heuristic (Issue #401) — this app
/// has no customer-demographics feed, so the recommendation is a
/// category-based rule of thumb: high-foot-traffic categories like
/// grocery/retail get the highest-visibility homepage banner, other
/// categories get a lower-cost featured slot.
class RecommendAdPackage {
  static const _highTrafficCategories = {'grocery', 'retail', 'bakery', 'pharmacy'};

  static AdPackageType call(String category) {
    return _highTrafficCategories.contains(category.trim().toLowerCase())
        ? AdPackageType.homepageBanner
        : AdPackageType.featuredSlot;
  }
}
