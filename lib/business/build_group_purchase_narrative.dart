import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';

/// One-sentence read summarizing the group-buying pipeline (Issue
/// #414), mirroring [BuildBarterListingNarrative]'s summary pattern.
class BuildGroupPurchaseNarrative {
  static String call(List<GroupPurchaseEntity> purchases) {
    if (purchases.isEmpty) {
      return 'No group purchases yet.';
    }
    final open = purchases.where((p) => p.status == GroupPurchaseStatus.open).length;
    final finalized = purchases.where((p) => p.status == GroupPurchaseStatus.finalized).length;
    return '${purchases.length} campaign(s): $open open for contributions, '
        '$finalized finalized.';
  }
}
