import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/format_listing_price.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

void main() {
  test('formats a fixed price', () {
    expect(FormatListingPrice.call(CatalogPricingMode.fixedPrice, 49.99, 0, 0), '\$49.99');
  });

  test('formats a price range', () {
    expect(FormatListingPrice.call(CatalogPricingMode.priceRange, 0, 10, 20), '\$10.00 - \$20.00');
  });

  test('formats request for quote', () {
    expect(FormatListingPrice.call(CatalogPricingMode.requestForQuote, 0, 0, 0), 'Request for Quote');
  });
}
