import 'package:growth_pilot_ai/core/models/inventory_recommendation.dart';

/// One-sentence read summarizing the restocking recommendation feed
/// (Issue #418), mirroring [BuildSeasonalCatalogNarrative]'s summary
/// pattern.
class BuildInventoryRecommendationNarrative {
  static String call(List<InventoryRecommendation> recommendations) {
    if (recommendations.isEmpty) {
      return 'No critical inventory gaps detected right now.';
    }
    final matched = recommendations.where((r) => r.matchedListing != null).length;
    return '${recommendations.length} item(s) running low: $matched with a marketplace match available.';
  }
}
