import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

/// Releases the simulated escrow and completes the sale once the
/// buyer confirms pickup (Issue #412, acceptance criterion 5) — this
/// app has no payment-holding backend, so "escrow" is represented by
/// the [AssetListingStatus.sold] state until this transition.
class ConfirmAssetPickup {
  static AssetListingEntity call(AssetListingEntity listing) {
    return AssetListingEntity(
      id: listing.id,
      sellerName: listing.sellerName,
      assetName: listing.assetName,
      conditionDescription: listing.conditionDescription,
      marketValue: listing.marketValue,
      askingPrice: listing.askingPrice,
      commercialZone: listing.commercialZone,
      dbStatus: AssetListingStatus.completed.index,
      pickupDeadline: listing.pickupDeadline,
      listedAt: listing.listedAt,
    );
  }
}
