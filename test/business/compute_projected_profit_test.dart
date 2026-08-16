import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_projected_profit.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

ActionImpactItem _item(double profit, ActionImpactStatus status) => ActionImpactItem(
      id: 1,
      title: 't',
      estimatedProfit: profit,
      dailyOpportunityCost: 1,
      status: status,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('ComputeProjectedProfit', () {
    test('sums estimated profit for todo and doing items only', () {
      final items = [
        _item(100, ActionImpactStatus.todo),
        _item(200, ActionImpactStatus.doing),
        _item(300, ActionImpactStatus.done),
      ];

      expect(ComputeProjectedProfit.call(items), 300);
    });

    test('empty list projects zero', () {
      expect(ComputeProjectedProfit.call([]), 0);
    });
  });
}
