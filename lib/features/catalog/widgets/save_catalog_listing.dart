import 'dart:convert';
import 'package:growth_pilot_ai/business/cap_attribute_keys.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_repos.dart';

/// Persists a validated listing plus its discriminator details (Issue
/// #138, acceptance criterion 2) — split out of [CatalogActions].
void saveCatalogListing(
  CatalogRepos repos, {
  required String ownerId,
  required String title,
  required String industry,
  required String category,
  required CatalogListingType type,
  required double fixedPrice,
  required double lat,
  required double lng,
  required Map<String, String> attributes,
}) {
  const mode = CatalogPricingMode.fixedPrice;
  final listing = CatalogListingEntity(
    ownerId: ownerId,
    title: title,
    industry: industry,
    category: category,
    locationLat: lat,
    locationLng: lng,
    attributesJson: jsonEncode(CapAttributeKeys.call(attributes)),
    createdAt: DateTime.now(),
  )..listingType = type;
  listing.id = repos.listings.save(listing);

  if (type == CatalogListingType.product) {
    repos.productDetails
        .save(ProductListingDetailsEntity(listingId: listing.id, fixedPrice: fixedPrice)..pricingMode = mode);
  } else {
    repos.serviceDetails
        .save(ServiceListingDetailsEntity(listingId: listing.id, fixedPrice: fixedPrice)..pricingMode = mode);
  }
}
