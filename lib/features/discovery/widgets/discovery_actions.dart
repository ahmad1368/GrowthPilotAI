import 'package:growth_pilot_ai/business/build_category_facets.dart';
import 'package:growth_pilot_ai/business/search_catalog_listings.dart';
import 'package:growth_pilot_ai/features/discovery/widgets/discovery_repos.dart';

/// Orchestrates the discovery search + facet counts (Issue #121).
class DiscoveryActions {
  final DiscoveryRepos repos;
  DiscoveryActions(this.repos);

  static const _radiusKm = 50.0;

  List<ScoredListing> search(String term) {
    final listings = repos.listings.getAll();
    final loc = repos.location.get();
    return SearchCatalogListings.call(
      listings,
      term,
      centerLat: loc?.lat,
      centerLng: loc?.lng,
      radiusKm: loc != null ? _radiusKm : null,
    );
  }

  Map<String, int> facets() => BuildCategoryFacets.call(repos.listings.getAll());
}
