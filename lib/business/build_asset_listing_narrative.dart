import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

/// One-sentence read summarizing the liquidation pipeline (Issue
/// #412), mirroring [BuildAdRequestNarrative]'s summary pattern.
class BuildAssetListingNarrative {
  static String call(List<AssetListingEntity> listings) {
    if (listings.isEmpty) {
      return 'No asset listings yet.';
    }
    final pendingReview =
        listings.where((l) => l.status == AssetListingStatus.pendingReview).length;
    final completed = listings.where((l) => l.status == AssetListingStatus.completed).length;
    return '${listings.length} listing(s): $pendingReview awaiting screening, '
        '$completed sale(s) completed.';
  }
}
