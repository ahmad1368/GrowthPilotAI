import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/business/filter_listings_within_radius.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

/// One listing paired with its distance from the search center.
typedef NearbyListing = ({CatalogListingEntity listing, double distanceKm});

/// Finds listings within a radius, sorted nearest-first and capped to
/// [maxResults] (Issue #213, acceptance criterion "Performance" — a
/// stand-in for map-marker clustering/virtualization since this app
/// has no interactive map).
class FindNearbyListings {
  static List<NearbyListing> call(
    List<CatalogListingEntity> listings,
    double centerLat,
    double centerLng,
    double radiusKm, {
    int maxResults = 100,
  }) {
    final within = FilterListingsWithinRadius.call(listings, centerLat, centerLng, radiusKm);
    final withDistance = within
        .map((l) => (
              listing: l,
              distanceKm: ComputeDistanceKm.call(centerLat, centerLng, l.locationLat, l.locationLng)
            ))
        .toList()
      ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return withDistance.take(maxResults).toList();
  }
}
