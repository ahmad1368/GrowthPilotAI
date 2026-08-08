import 'package:growth_pilot_ai/core/data/entities/product_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

/// Updates the existing discriminator-details row for a listing if
/// one exists, instead of inserting a duplicate (Issue #140,
/// acceptance criterion "Data Integrity") — split out of
/// [submitProductForm].
void saveProductFormDetails(
  ProductFormRepos repos, {
  required int listingId,
  required CatalogListingType type,
  required double price,
}) {
  const mode = CatalogPricingMode.fixedPrice;
  if (type == CatalogListingType.product) {
    final details = repos.productDetails.forListing(listingId) ??
        ProductListingDetailsEntity(listingId: listingId, fixedPrice: price);
    repos.productDetails.save(details
      ..fixedPrice = price
      ..pricingMode = mode);
  } else {
    final details = repos.serviceDetails.forListing(listingId) ??
        ServiceListingDetailsEntity(listingId: listingId, fixedPrice: price);
    repos.serviceDetails.save(details
      ..fixedPrice = price
      ..pricingMode = mode);
  }
}
