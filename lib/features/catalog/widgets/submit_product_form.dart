import 'package:growth_pilot_ai/business/validate_catalog_listing.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/save_product_form_details.dart';

/// Creates a new listing or updates an existing one in place (Issue
/// #140, acceptance criterion "Data Integrity").
List<String> submitProductForm(
  ProductFormRepos repos, {
  required int editingListingId,
  required String ownerId,
  required String title,
  required String industry,
  required String category,
  required CatalogListingType type,
  required double price,
  required List<int> imageVariantIds,
  required double lat,
  required double lng,
}) {
  final errors = ValidateCatalogListing.call(
      type: type, category: category, pricingMode: CatalogPricingMode.fixedPrice, fixedPrice: price);
  if (errors.isNotEmpty) return errors;

  final existing = editingListingId == 0
      ? null
      : repos.listings.getAll().where((l) => l.id == editingListingId).firstOrNull;
  final listing = existing ??
      CatalogListingEntity(ownerId: ownerId, title: title, industry: industry, createdAt: DateTime.now());
  listing
    ..title = title
    ..industry = industry
    ..category = category
    ..listingType = type
    ..locationLat = lat
    ..locationLng = lng
    ..imageVariantIdsCsv = imageVariantIds.join(',');
  listing.id = repos.listings.save(listing);

  saveProductFormDetails(repos, listingId: listing.id, type: type, price: price);
  return [];
}
