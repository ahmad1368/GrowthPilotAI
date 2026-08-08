import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';

/// A display-ready readout of one listing (Issue #138) — combines the
/// base entity with its discriminator's formatted price and distance
/// from the Surrey/Coquitlam reference point used in the acceptance
/// criteria's geospatial test scenario.
class CatalogListingSummary {
  final CatalogListingEntity listing;
  final String priceDisplay;
  final double distanceFromSurreyKm;

  const CatalogListingSummary({
    required this.listing,
    required this.priceDisplay,
    required this.distanceFromSurreyKm,
  });
}
