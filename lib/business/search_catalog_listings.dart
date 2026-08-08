import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/business/fuzzy_match_listing.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

typedef ScoredListing = ({CatalogListingEntity listing, double score, double? distanceKm});

/// Multi-criteria business discovery search (Issue #121) — combines
/// fuzzy text relevance with an optional geospatial radius filter,
/// ranked the same way the issue's own aggregation pipeline sorts:
/// searchScore descending, then distance ascending. No "Private"
/// metadata exists on [CatalogListingEntity] to accidentally index
/// (owner contact was excluded entirely back in #138).
class SearchCatalogListings {
  static const _minScore = 0.15;

  static List<ScoredListing> call(
    List<CatalogListingEntity> listings,
    String term, {
    double? centerLat,
    double? centerLng,
    double? radiusKm,
  }) {
    final results = <ScoredListing>[];
    for (final listing in listings) {
      final score = FuzzyMatchListing.call(listing, term);
      if (score < _minScore) continue;
      double? distanceKm;
      if (centerLat != null && centerLng != null) {
        distanceKm =
            ComputeDistanceKm.call(centerLat, centerLng, listing.locationLat, listing.locationLng);
        if (radiusKm != null && distanceKm > radiusKm) continue;
      }
      results.add((listing: listing, score: score, distanceKm: distanceKm));
    }
    results.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return (a.distanceKm ?? 0).compareTo(b.distanceKm ?? 0);
    });
    return results;
  }
}
