import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';

/// Audience segmentation heuristic for the campaign composer (Issue
/// #407, acceptance criterion 2) — this app has no merchant directory
/// backend, so the reachable audience is estimated from a category
/// base pool narrowed by region, payment-reliability, and required ad
/// tier, mirroring [RecommendAdPackage]'s category lookup heuristic.
class EstimateAudienceSegmentSize {
  static const _highTrafficCategories = {'grocery', 'retail', 'bakery', 'pharmacy'};

  static int call({
    required String category,
    required String region,
    required int minPaymentReliability,
    required AdPackageType requiredTier,
  }) {
    final basePool = _highTrafficCategories.contains(category.trim().toLowerCase())
        ? 500
        : 200;
    final regionFactor = region.trim().isEmpty ? 1.0 : 0.4;
    final reliabilityFactor =
        (1 - minPaymentReliability.clamp(0, 100) / 100).clamp(0.05, 1.0);
    final tierFactor =
        requiredTier == AdPackageType.homepageBanner ? 0.5 : 0.8;

    return (basePool * regionFactor * reliabilityFactor * tierFactor).round();
  }
}
