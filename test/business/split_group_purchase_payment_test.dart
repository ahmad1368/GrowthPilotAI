import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/split_group_purchase_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';

void main() {
  test('splits the discounted cost proportionally by quantity', () {
    final contributions = [
      GroupPurchaseContributionEntity(
          id: 1, groupPurchaseId: 1, merchantName: 'A', quantity: 60, contributedAt: DateTime(2026, 1, 2)),
      GroupPurchaseContributionEntity(
          id: 2, groupPurchaseId: 1, merchantName: 'B', quantity: 40, contributedAt: DateTime(2026, 1, 3)),
    ];

    final owed = SplitGroupPurchasePayment.call(contributions, 10.0, 0.10);

    expect(owed['A'], closeTo(540.0, 0.001)); // 60 * 10 * 0.9
    expect(owed['B'], closeTo(360.0, 0.001)); // 40 * 10 * 0.9
  });

  test('merges multiple contributions from the same merchant', () {
    final contributions = [
      GroupPurchaseContributionEntity(
          id: 1, groupPurchaseId: 1, merchantName: 'A', quantity: 30, contributedAt: DateTime(2026, 1, 2)),
      GroupPurchaseContributionEntity(
          id: 2, groupPurchaseId: 1, merchantName: 'A', quantity: 20, contributedAt: DateTime(2026, 1, 3)),
    ];

    final owed = SplitGroupPurchasePayment.call(contributions, 10.0, 0);

    expect(owed['A'], closeTo(500.0, 0.001)); // (30+20) * 10
    expect(owed.length, 1);
  });
}
