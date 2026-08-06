import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';

/// Builds a new merchant contribution toward a group-buying campaign
/// (Issue #414, acceptance criterion 1) — pure construction, the
/// caller persists it.
class ContributeToGroupPurchase {
  static GroupPurchaseContributionEntity call(
      int groupPurchaseId, String merchantName, int quantity, DateTime now) {
    return GroupPurchaseContributionEntity(
      groupPurchaseId: groupPurchaseId,
      merchantName: merchantName,
      quantity: quantity,
      contributedAt: now,
    );
  }
}
