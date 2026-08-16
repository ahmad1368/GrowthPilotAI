import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_opportunity_cost.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

void main() {
  group('ComputeOpportunityCost', () {
    test('multiplies days pending by the daily opportunity cost', () {
      final item = ActionImpactItem(
        id: 1,
        title: 'Renegotiate supplier contract',
        estimatedProfit: 500,
        dailyOpportunityCost: 20,
        status: ActionImpactStatus.todo,
        createdAt: DateTime(2026, 1, 1),
      );

      expect(ComputeOpportunityCost.call(item, DateTime(2026, 1, 11)), 200);
    });

    test('stops accruing once the item is completed', () {
      final item = ActionImpactItem(
        id: 2,
        title: 'Switch payroll provider',
        estimatedProfit: 300,
        dailyOpportunityCost: 10,
        status: ActionImpactStatus.done,
        createdAt: DateTime(2026, 1, 1),
        completedAt: DateTime(2026, 1, 6),
      );

      expect(ComputeOpportunityCost.call(item, DateTime(2026, 2, 1)), 50);
    });

    test('same-day items accrue no loss yet', () {
      final item = ActionImpactItem(
        id: 3,
        title: 'Review anomaly',
        estimatedProfit: 100,
        dailyOpportunityCost: 5,
        status: ActionImpactStatus.todo,
        createdAt: DateTime(2026, 1, 1, 9),
      );

      expect(ComputeOpportunityCost.call(item, DateTime(2026, 1, 1, 15)), 0);
    });
  });
}
