import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/screen_asset_listing_authenticity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';

AssetListingEntity _listing({required double marketValue, required double askingPrice}) =>
    AssetListingEntity(
      sellerName: 'Seller',
      assetName: 'Fridge',
      conditionDescription: 'Good',
      marketValue: marketValue,
      askingPrice: askingPrice,
      commercialZone: 'Downtown',
      pickupDeadline: DateTime(2026, 2, 1),
      listedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('a discounted asking price at or below market value passes screening', () {
    expect(
        ScreenAssetListingAuthenticity.call(_listing(marketValue: 1000, askingPrice: 500)), true);
  });

  test('an asking price above market value fails screening', () {
    expect(
        ScreenAssetListingAuthenticity.call(_listing(marketValue: 500, askingPrice: 1000)), false);
  });

  test('a zero or negative price fails screening', () {
    expect(ScreenAssetListingAuthenticity.call(_listing(marketValue: 1000, askingPrice: 0)), false);
    expect(ScreenAssetListingAuthenticity.call(_listing(marketValue: 0, askingPrice: 0)), false);
  });
}
