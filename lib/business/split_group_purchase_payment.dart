import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';

/// Splits the discounted bulk-order cost proportionally across
/// contributors by quantity share (Issue #414, acceptance criterion
/// 4) — this app has no payment-processing backend, so "securely
/// processes" means computing each merchant's owed amount for
/// display/audit rather than moving real funds.
class SplitGroupPurchasePayment {
  static Map<String, double> call(
    List<GroupPurchaseContributionEntity> contributions,
    double unitPrice,
    double discountRate,
  ) {
    final discountedUnitPrice = unitPrice * (1 - discountRate);
    final owed = <String, double>{};
    for (final c in contributions) {
      owed[c.merchantName] = (owed[c.merchantName] ?? 0) + c.quantity * discountedUnitPrice;
    }
    return owed;
  }
}
