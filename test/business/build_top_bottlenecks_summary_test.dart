import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_top_bottlenecks_summary.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';

BottleneckInsight _insight(String id, BottleneckSeverity severity) => BottleneckInsight(
      nodeId: id,
      issueLabel: 'x',
      severity: severity,
      reason: 'x',
      suggestion: 'x',
    );

void main() {
  group('BuildTopBottlenecksSummary', () {
    test('sorts most severe first and caps at 3', () {
      final insights = [
        _insight('a', BottleneckSeverity.low),
        _insight('b', BottleneckSeverity.high),
        _insight('c', BottleneckSeverity.medium),
        _insight('d', BottleneckSeverity.high),
        _insight('e', BottleneckSeverity.low),
      ];

      final result = BuildTopBottlenecksSummary.call(insights);

      expect(result.length, 3);
      expect(result[0].severity, BottleneckSeverity.high);
      expect(result[1].severity, BottleneckSeverity.high);
      expect(result[2].severity, BottleneckSeverity.medium);
    });
  });
}
