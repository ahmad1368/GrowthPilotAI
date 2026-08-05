import 'package:growth_pilot_ai/business/accept_asset_bid.dart';
import 'package:growth_pilot_ai/business/confirm_asset_pickup.dart';
import 'package:growth_pilot_ai/business/submit_asset_bid.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_repos.dart';

/// Bid submission, acceptance, and pickup confirmation (Issue #412,
/// acceptance criteria 3 and 5) — split out of [AssetBody].
class AssetBidActions {
  final AssetRepos repos;

  AssetBidActions(this.repos);

  void submitBid(int listingId, String bidderName, double amount) {
    repos.bids.save(SubmitAssetBid.call(listingId, bidderName, amount, DateTime.now()));
  }

  ({AssetListingEntity listing, AssetBidEntity bid}) acceptBid(
      AssetListingEntity listing, AssetBidEntity bid) {
    final result = AcceptAssetBid.call(listing, bid);
    repos.listings.save(result.listing);
    repos.bids.save(result.bid);
    return result;
  }

  AssetListingEntity confirmPickup(AssetListingEntity listing) {
    final updated = ConfirmAssetPickup.call(listing);
    repos.listings.save(updated);
    return updated;
  }
}
