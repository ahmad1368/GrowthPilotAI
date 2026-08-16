import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/update_action_impact_status.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

void main() {
  group('UpdateActionImpactStatus', () {
    final base = ActionImpactItem(
      id: 1,
      title: 'Renegotiate lease',
      estimatedProfit: 400,
      dailyOpportunityCost: 15,
      status: ActionImpactStatus.todo,
      createdAt: DateTime(2026, 1, 1),
    );

    test('stamps completedAt when moving to done', () {
      final now = DateTime(2026, 1, 10);
      final updated = UpdateActionImpactStatus.call(base, ActionImpactStatus.done, now);

      expect(updated.status, ActionImpactStatus.done);
      expect(updated.completedAt, now);
    });

    test('clears completedAt when reopened from done', () {
      final done = UpdateActionImpactStatus.call(base, ActionImpactStatus.done, DateTime(2026, 1, 10));
      final reopened = UpdateActionImpactStatus.call(done, ActionImpactStatus.doing, DateTime(2026, 1, 12));

      expect(reopened.completedAt, isNull);
      expect(reopened.status, ActionImpactStatus.doing);
    });

    test('preserves id/title/profit/createdAt', () {
      final updated = UpdateActionImpactStatus.call(base, ActionImpactStatus.doing, DateTime(2026, 1, 5));

      expect(updated.id, base.id);
      expect(updated.title, base.title);
      expect(updated.estimatedProfit, base.estimatedProfit);
      expect(updated.createdAt, base.createdAt);
    });
  });
}
