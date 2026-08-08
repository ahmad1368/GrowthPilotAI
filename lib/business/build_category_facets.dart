import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

/// Aggregated counts per category, for the Faceted Navigation /
/// side-panel filters (Issue #121, referencing #115).
class BuildCategoryFacets {
  static Map<String, int> call(List<CatalogListingEntity> listings) {
    final counts = <String, int>{};
    for (final listing in listings) {
      final key = listing.category.isEmpty ? 'Uncategorized' : listing.category;
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts;
  }
}
