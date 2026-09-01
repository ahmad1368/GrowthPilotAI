import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/business/format_listing_price.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/models/catalog_listing_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_repos.dart';

const surreyLat = 49.1913;
const surreyLng = -122.8490;

/// Builds display-ready summaries for every listing (Issue #138) —
/// split out of [CatalogActions] to stay under the file line cap.
List<CatalogListingSummary> buildCatalogSummaries(CatalogRepos repos) {
  return repos.listings.getAll().map((listing) {
    final priceDisplay = switch (listing.listingType) {
      CatalogListingType.product => _productPrice(repos, listing.id),
      CatalogListingType.service => _servicePrice(repos, listing.id),
    };
    return CatalogListingSummary(
      listing: listing,
      priceDisplay: priceDisplay,
      distanceFromSurreyKm:
          ComputeDistanceKm.call(surreyLat, surreyLng, listing.locationLat, listing.locationLng),
    );
  }).toList();
}

String _productPrice(CatalogRepos repos, int listingId) {
  final details = repos.productDetails.forListing(listingId);
  if (details == null) return '—';
  return FormatListingPrice.call(
      details.pricingMode, details.fixedPrice, details.priceRangeMin, details.priceRangeMax);
}

String _servicePrice(CatalogRepos repos, int listingId) {
  final details = repos.serviceDetails.forListing(listingId);
  if (details == null) return '—';
  return FormatListingPrice.call(
      details.pricingMode, details.fixedPrice, details.priceRangeMin, details.priceRangeMax);
}
