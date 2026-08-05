import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';

/// Builds a new binding bid on an asset listing (Issue #412,
/// acceptance criterion 3) — pure construction, the caller persists it.
class SubmitAssetBid {
  static AssetBidEntity call(int listingId, String bidderName, double bidAmount, DateTime now) {
    return AssetBidEntity(
      listingId: listingId,
      bidderName: bidderName,
      bidAmount: bidAmount,
      submittedAt: now,
    );
  }
}
