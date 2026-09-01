import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

/// Filters listings to those within a radius of a center point (Issue
/// #138, acceptance criterion "Geospatial Accuracy" — a 50km radius
/// of Surrey/Coquitlam is the referenced test scenario).
class FilterListingsWithinRadius {
  static List<CatalogListingEntity> call(
    List<CatalogListingEntity> listings,
    double centerLat,
    double centerLng,
    double radiusKm,
  ) {
    return listings
        .where((l) => ComputeDistanceKm.call(centerLat, centerLng, l.locationLat, l.locationLng) <=
            radiusKm)
        .toList();
  }
}
