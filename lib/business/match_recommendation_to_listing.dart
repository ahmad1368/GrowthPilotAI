import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';

/// Pairs a critically-low item with an active marketplace listing for
/// the same product (Issue #418, acceptance criterion 2) — this app
/// has no live wholesale-supplier catalog feed, so the match pool is
/// this device's own [WholesaleListingEntity] log (#411).
class MatchRecommendationToListing {
  static WholesaleListingEntity? call(String itemName, List<WholesaleListingEntity> listings) {
    for (final listing in listings) {
      if (listing.status == WholesaleListingStatus.active &&
          listing.itemName.toLowerCase() == itemName.toLowerCase()) {
        return listing;
      }
    }
    return null;
  }
}
