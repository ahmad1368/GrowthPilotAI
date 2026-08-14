import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

/// SKU price list for advertising packages (Issue #410, acceptance
/// criterion 2) — this app has no real payment gateway/catalog
/// service, so prices are a fixed local table instead of a live SKU
/// lookup, the same simplification [RecommendAdPackage] (#401) takes.
class ComputeAdPackagePrice {
  static const _prices = {
    AdPackageType.homepageBanner: 199.0,
    AdPackageType.featuredSlot: 49.0,
  };

  static double call(AdPackageType type) => _prices[type]!;
}
