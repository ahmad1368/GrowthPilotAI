import 'package:growth_pilot_ai/business/validate_catalog_listing.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';
import 'package:growth_pilot_ai/core/models/catalog_listing_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_catalog_summaries.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/save_catalog_listing.dart';

/// Validates and creates listings, and loads display summaries (Issue
/// #138, acceptance criteria 1-4) — split out of [CatalogBody].
class CatalogActions {
  final CatalogRepos repos;

  CatalogActions(this.repos);

  List<String> createListing({
    required String ownerId,
    required String title,
    required String industry,
    required String category,
    required CatalogListingType type,
    required double fixedPrice,
    required double lat,
    required double lng,
    Map<String, String> attributes = const {},
  }) {
    final errors = ValidateCatalogListing.call(
        type: type, category: category, pricingMode: CatalogPricingMode.fixedPrice, fixedPrice: fixedPrice);
    if (errors.isNotEmpty) return errors;

    saveCatalogListing(
      repos,
      ownerId: ownerId,
      title: title,
      industry: industry,
      category: category,
      type: type,
      fixedPrice: fixedPrice,
      lat: lat,
      lng: lng,
      attributes: attributes,
    );
    return [];
  }

  List<CatalogListingSummary> loadSummaries() => buildCatalogSummaries(repos);
}
