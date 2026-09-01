import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';

/// Aggregates contributed quantity against the campaign's threshold
/// for the dynamic progress indicator (Issue #414, acceptance
/// criterion 2).
class ComputeGroupPurchaseProgress {
  static ({int totalQuantity, double percent, bool thresholdMet}) call(
      GroupPurchaseEntity purchase, List<GroupPurchaseContributionEntity> contributions) {
    final totalQuantity = contributions.fold<int>(0, (sum, c) => sum + c.quantity);
    final percent = purchase.minQuantityThreshold <= 0
        ? 0.0
        : (totalQuantity / purchase.minQuantityThreshold).clamp(0, 1).toDouble();
    return (
      totalQuantity: totalQuantity,
      percent: percent,
      thresholdMet: totalQuantity >= purchase.minQuantityThreshold,
    );
  }
}
