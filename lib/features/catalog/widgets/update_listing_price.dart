import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';

/// Applies a click-to-edit price change to a single listing (Issue
/// #143, "Inline Editing").
void updateListingPrice(AdminTableRepos repos, int listingId, double price) {
  final listing = repos.listings.getAll().where((l) => l.id == listingId).firstOrNull;
  if (listing == null) return;
  if (listing.listingType == CatalogListingType.product) {
    final details = repos.productDetails.forListing(listingId);
    if (details != null) repos.productDetails.save(details..fixedPrice = price);
  } else {
    final details = repos.serviceDetails.forListing(listingId);
    if (details != null) repos.serviceDetails.save(details..fixedPrice = price);
  }
}
