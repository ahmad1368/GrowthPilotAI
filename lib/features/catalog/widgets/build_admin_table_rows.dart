import 'package:growth_pilot_ai/business/is_low_stock.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';

typedef AdminRow = ({
  int id,
  String title,
  String category,
  String availability,
  double price,
  int stockLevel,
  bool isLowStock,
});

/// Builds one admin-table row per listing (Issue #143). Services have
/// no stock concept, so their stock/low-stock fields are always 0/false.
List<AdminRow> buildAdminTableRows(AdminTableRepos repos) {
  return repos.listings.getAll().map((listing) {
    final isProduct = listing.listingType == CatalogListingType.product;
    final stockLevel = isProduct ? repos.productDetails.forListing(listing.id)?.stockLevel ?? 0 : 0;
    final price = isProduct
        ? repos.productDetails.forListing(listing.id)?.fixedPrice ?? 0
        : repos.serviceDetails.forListing(listing.id)?.fixedPrice ?? 0;
    return (
      id: listing.id,
      title: listing.title,
      category: listing.category,
      availability: listing.availability.name,
      price: price,
      stockLevel: stockLevel,
      isLowStock: isProduct && IsLowStock.call(stockLevel),
    );
  }).toList();
}
