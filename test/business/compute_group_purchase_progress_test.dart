import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_group_purchase_progress.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';

void main() {
  final purchase = GroupPurchaseEntity(
    id: 1,
    organizerName: 'Organizer',
    itemName: 'Takeout Boxes',
    itemDescription: '',
    unitPrice: 2.0,
    minQuantityThreshold: 100,
    deadline: DateTime(2026, 3, 1),
    createdAt: DateTime(2026, 1, 1),
  );

  test('progress below threshold reports partial percent and not met', () {
    final contributions = [
      GroupPurchaseContributionEntity(
          id: 1, groupPurchaseId: 1, merchantName: 'A', quantity: 30, contributedAt: DateTime(2026, 1, 2)),
      GroupPurchaseContributionEntity(
          id: 2, groupPurchaseId: 1, merchantName: 'B', quantity: 20, contributedAt: DateTime(2026, 1, 3)),
    ];

    final result = ComputeGroupPurchaseProgress.call(purchase, contributions);

    expect(result.totalQuantity, 50);
    expect(result.percent, 0.5);
    expect(result.thresholdMet, false);
  });

  test('contributions at or above the threshold report met and clamp percent to 1', () {
    final contributions = [
      GroupPurchaseContributionEntity(
          id: 1, groupPurchaseId: 1, merchantName: 'A', quantity: 80, contributedAt: DateTime(2026, 1, 2)),
      GroupPurchaseContributionEntity(
          id: 2, groupPurchaseId: 1, merchantName: 'B', quantity: 40, contributedAt: DateTime(2026, 1, 3)),
    ];

    final result = ComputeGroupPurchaseProgress.call(purchase, contributions);

    expect(result.totalQuantity, 120);
    expect(result.percent, 1.0);
    expect(result.thresholdMet, true);
  });
}
