import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_total_growth_score.dart';
import 'package:growth_pilot_ai/core/data/entities/pulse_event_entity.dart';

PulseEventEntity _event(String reporterId, int score) => PulseEventEntity(
      reporterId: reporterId,
      dbCategory: 0,
      title: 't',
      description: 'd',
      region: 'ON',
      estimatedImpactCad: 100,
      growthScoreEarned: score,
      reportedAt: DateTime(2026, 1, 1),
    );

void main() {
  group('ComputeTotalGrowthScore', () {
    test('sums only the given reporter\'s events (Issue #267/#268)', () {
      final events = [_event('user-a', 5), _event('user-b', 50), _event('user-a', 20)];

      expect(ComputeTotalGrowthScore.call(events, 'user-a'), 25);
    });

    test('returns 0 for a reporter with no reports', () {
      expect(ComputeTotalGrowthScore.call([_event('user-a', 5)], 'user-x'), 0);
    });

    test('returns 0 for an empty feed', () {
      expect(ComputeTotalGrowthScore.call([], 'user-a'), 0);
    });
  });
}
