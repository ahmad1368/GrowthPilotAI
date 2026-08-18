import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_bottleneck_risk_score.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';

BottleneckInsight _insight(BottleneckSeverity severity) => BottleneckInsight(
      nodeId: 'n1',
      issueLabel: 'Convergence bottleneck',
      severity: severity,
      reason: 'test',
      suggestion: 'test',
    );

void main() {
  group('ComputeBottleneckRiskScore', () {
    test('returns 0 for an empty list', () {
      expect(ComputeBottleneckRiskScore.call(const []), 0);
    });

    test('averages the severity weights', () {
      final score = ComputeBottleneckRiskScore.call([
        _insight(BottleneckSeverity.low),
        _insight(BottleneckSeverity.high),
      ]);

      expect(score, 45);
    });
  });
}
