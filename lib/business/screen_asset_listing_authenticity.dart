import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';

/// Fraud-screening heuristic for a new asset listing (Issue #412,
/// acceptance criterion 4) — this app has no identity-verification
/// backend, so authenticity is approximated by price sanity: a
/// discounted asking price that's still positive and at or below the
/// declared market value; anything else is flagged for closer admin
/// review before approval.
class ScreenAssetListingAuthenticity {
  static bool call(AssetListingEntity listing) {
    return listing.marketValue > 0 &&
        listing.askingPrice > 0 &&
        listing.askingPrice <= listing.marketValue;
  }
}
