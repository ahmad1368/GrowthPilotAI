import 'dart:typed_data';
import 'package:growth_pilot_ai/business/resolve_listing_thumbnail.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_catalog_summaries.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_grid_repos.dart';

typedef CatalogCard = ({String title, String category, String priceDisplay, Uint8List? thumbnail});

/// Builds the grid card view-models for every listing (Issue #142),
/// reusing #138's [buildCatalogSummaries] for pricing instead of
/// duplicating the price-formatting logic.
List<CatalogCard> buildCatalogGridCards(CatalogGridRepos repos) {
  final thumbnailsById = {for (final v in repos.images.getAll()) v.id: v.thumbnailBytes};
  return buildCatalogSummaries(repos.catalog).map((summary) {
    return (
      title: summary.listing.title,
      category: summary.listing.category,
      priceDisplay: summary.priceDisplay,
      thumbnail: ResolveListingThumbnail.call(summary.listing.imageVariantIdsCsv, thumbnailsById),
    );
  }).toList();
}
