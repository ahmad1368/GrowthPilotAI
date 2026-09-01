import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_bottleneck_severity_distribution.dart';
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
  group('ComputeBottleneckSeverityDistribution', () {
    test('includes every severity with zero for an empty list', () {
      final counts = ComputeBottleneckSeverityDistribution.call(const []);

      expect(counts.length, BottleneckSeverity.values.length);
      expect(counts.values.every((c) => c == 0), isTrue);
    });

    test('tallies each bottleneck by its severity', () {
      final counts = ComputeBottleneckSeverityDistribution.call([
        _insight(BottleneckSeverity.high),
        _insight(BottleneckSeverity.high),
        _insight(BottleneckSeverity.low),
      ]);

      expect(counts[BottleneckSeverity.high], 2);
      expect(counts[BottleneckSeverity.low], 1);
      expect(counts[BottleneckSeverity.medium], 0);
    });
  });
}
