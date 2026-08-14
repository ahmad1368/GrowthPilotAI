import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_bid_status.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

/// Accepts one binding bid, marking the listing sold pending pickup
/// (Issue #412, acceptance criterion 3) — other outstanding bids on
/// the same listing are left as-is since the UI stops offering them
/// once the listing is no longer active.
class AcceptAssetBid {
  static ({AssetListingEntity listing, AssetBidEntity bid}) call(
      AssetListingEntity listing, AssetBidEntity bid) {
    final updatedListing = AssetListingEntity(
      id: listing.id,
      sellerName: listing.sellerName,
      assetName: listing.assetName,
      conditionDescription: listing.conditionDescription,
      marketValue: listing.marketValue,
      askingPrice: listing.askingPrice,
      commercialZone: listing.commercialZone,
      dbStatus: AssetListingStatus.sold.index,
      pickupDeadline: listing.pickupDeadline,
      listedAt: listing.listedAt,
    );
    final updatedBid = AssetBidEntity(
      id: bid.id,
      listingId: bid.listingId,
      bidderName: bid.bidderName,
      bidAmount: bid.bidAmount,
      dbStatus: AssetBidStatus.accepted.index,
      submittedAt: bid.submittedAt,
    );
    return (listing: updatedListing, bid: updatedBid);
  }
}
