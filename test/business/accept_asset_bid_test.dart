import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/accept_asset_bid.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_bid_status.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

void main() {
  test('accepting a bid marks the listing sold and the bid accepted', () {
    final listing = AssetListingEntity(
      id: 3,
      sellerName: 'Seller',
      assetName: 'Fridge',
      conditionDescription: 'Good',
      marketValue: 1000,
      askingPrice: 500,
      commercialZone: 'Downtown',
      dbStatus: AssetListingStatus.active.index,
      pickupDeadline: DateTime(2026, 2, 1),
      listedAt: DateTime(2026, 1, 1),
    );
    final bid = AssetBidEntity(
      id: 9,
      listingId: 3,
      bidderName: 'Buyer',
      bidAmount: 480,
      submittedAt: DateTime(2026, 1, 2),
    );

    final result = AcceptAssetBid.call(listing, bid);

    expect(result.listing.status, AssetListingStatus.sold);
    expect(result.listing.id, 3);
    expect(result.bid.status, AssetBidStatus.accepted);
    expect(result.bid.id, 9);
  });
}
