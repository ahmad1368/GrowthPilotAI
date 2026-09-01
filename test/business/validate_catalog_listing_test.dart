import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_catalog_listing.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

void main() {
  test('rejects a fixed-price product with no price', () {
    final errors = ValidateCatalogListing.call(
      type: CatalogListingType.product,
      category: 'Electronics',
      pricingMode: CatalogPricingMode.fixedPrice,
      fixedPrice: 0,
    );
    expect(errors, isNotEmpty);
  });

  test('rejects a service with no category', () {
    final errors = ValidateCatalogListing.call(
      type: CatalogListingType.service,
      category: '',
      pricingMode: CatalogPricingMode.requestForQuote,
      fixedPrice: 0,
    );
    expect(errors, isNotEmpty);
  });

  test('accepts a valid product', () {
    final errors = ValidateCatalogListing.call(
      type: CatalogListingType.product,
      category: 'Electronics',
      pricingMode: CatalogPricingMode.fixedPrice,
      fixedPrice: 50,
    );
    expect(errors, isEmpty);
  });
}
