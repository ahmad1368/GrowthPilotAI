import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

/// Validates a listing before it can be saved (Issue #138, acceptance
/// criterion "Validation" — products must carry price info, services
/// must carry a category).
class ValidateCatalogListing {
  static List<String> call({
    required CatalogListingType type,
    required String category,
    required CatalogPricingMode pricingMode,
    required double fixedPrice,
  }) {
    final errors = <String>[];
    if (type == CatalogListingType.product &&
        pricingMode == CatalogPricingMode.fixedPrice &&
        fixedPrice <= 0) {
      errors.add('Products require a price.');
    }
    if (type == CatalogListingType.service && category.trim().isEmpty) {
      errors.add('Services require a category.');
    }
    return errors;
  }
}
