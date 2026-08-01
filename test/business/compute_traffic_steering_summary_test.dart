import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_traffic_steering_narrative.dart';
import 'package:growth_pilot_ai/business/compute_traffic_steering_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';

TrafficSteeringDirectiveEntity _directive({
  String targetName = 'Merchant A',
  String destinationLabel = 'Featured Category',
  required int redirectCount,
  DateTime? createdAt,
}) =>
    TrafficSteeringDirectiveEntity(
      targetName: targetName,
      destinationLabel: destinationLabel,
      redirectCount: redirectCount,
      createdAt: createdAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeTrafficSteeringSummary', () {
    test('returns empty list when no directives are logged', () {
      expect(ComputeTrafficSteeringSummary.call(const []), isEmpty);
    });

    test('computes each directive share of total redirects', () {
      final results = ComputeTrafficSteeringSummary.call([
        _directive(targetName: 'A', redirectCount: 75),
        _directive(targetName: 'B', redirectCount: 25),
      ]);

      final a = results.firstWhere((r) => r.targetName == 'A');
      final b = results.firstWhere((r) => r.targetName == 'B');
      expect(a.deviationSharePercent, closeTo(75.0, 1e-9));
      expect(b.deviationSharePercent, closeTo(25.0, 1e-9));
    });

    test('avoids division by zero when total redirects are zero', () {
      final result = ComputeTrafficSteeringSummary.call(
          [_directive(redirectCount: 0)]).single;
      expect(result.deviationSharePercent, 0);
    });

    test('sorts directives by redirect count descending', () {
      final results = ComputeTrafficSteeringSummary.call([
        _directive(targetName: 'Small', redirectCount: 5),
        _directive(targetName: 'Big', redirectCount: 500),
      ]);

      expect(results.first.targetName, 'Big');
      expect(results.last.targetName, 'Small');
    });
  });

  group('BuildTrafficSteeringNarrative', () {
    test('falls back when no directives are logged', () {
      expect(BuildTrafficSteeringNarrative.call(const []),
          contains('No steering directives logged'));
    });

    test('names the most-redirected target and destination', () {
      final results = ComputeTrafficSteeringSummary.call([
        _directive(
            targetName: 'TopMerchant',
            destinationLabel: 'External Marketplace',
            redirectCount: 500),
      ]);

      final narrative = BuildTrafficSteeringNarrative.call(results);
      expect(narrative, contains('TopMerchant'));
      expect(narrative, contains('External Marketplace'));
    });
  });
}
