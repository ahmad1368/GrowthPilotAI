import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/confirm_asset_pickup.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

void main() {
  test('confirming pickup completes a sold listing', () {
    final listing = AssetListingEntity(
      id: 4,
      sellerName: 'Seller',
      assetName: 'Shelving Unit',
      conditionDescription: 'Like new',
      marketValue: 300,
      askingPrice: 150,
      commercialZone: 'Downtown',
      dbStatus: AssetListingStatus.sold.index,
      pickupDeadline: DateTime(2026, 2, 1),
      listedAt: DateTime(2026, 1, 1),
    );

    final result = ConfirmAssetPickup.call(listing);

    expect(result.status, AssetListingStatus.completed);
    expect(result.id, 4);
    expect(result.assetName, 'Shelving Unit');
  });
}
