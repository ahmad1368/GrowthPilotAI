import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';

/// One-sentence read summarizing the barter pipeline (Issue #413),
/// mirroring [BuildAssetListingNarrative]'s summary pattern.
class BuildBarterListingNarrative {
  static String call(List<BarterListingEntity> listings) {
    if (listings.isEmpty) {
      return 'No barter listings yet.';
    }
    final active = listings.where((l) => l.status == BarterListingStatus.active).length;
    final completed = listings.where((l) => l.status == BarterListingStatus.completed).length;
    return '${listings.length} listing(s): $active open for trade, '
        '$completed trade(s) completed.';
  }
}
