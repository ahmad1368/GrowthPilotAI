import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

/// Display text for a listing's price, per its pricing mode (Issue
/// #138, acceptance criterion 4).
class FormatListingPrice {
  static String call(CatalogPricingMode mode, double fixedPrice, double rangeMin, double rangeMax) {
    return switch (mode) {
      CatalogPricingMode.fixedPrice => '\$${fixedPrice.toStringAsFixed(2)}',
      CatalogPricingMode.priceRange =>
        '\$${rangeMin.toStringAsFixed(2)} - \$${rangeMax.toStringAsFixed(2)}',
      CatalogPricingMode.requestForQuote => 'Request for Quote',
    };
  }
}
