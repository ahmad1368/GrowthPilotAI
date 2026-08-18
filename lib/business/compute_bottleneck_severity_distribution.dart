import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';

/// "Risk Distribution... Treemap or Stacked Bar Chart" (Issue #236) —
/// a per-severity tally of [BottleneckInsight]s. Grouped by severity
/// only: this repo has no link between a process-graph bottleneck
/// [BottleneckInsight.nodeId] and a document requirement's stakeholder/
/// business_module, so grouping by those dimensions isn't implemented
/// (see PR notes).
class ComputeBottleneckSeverityDistribution {
  static Map<BottleneckSeverity, int> call(List<BottleneckInsight> bottlenecks) {
    final counts = {for (final severity in BottleneckSeverity.values) severity: 0};
    for (final bottleneck in bottlenecks) {
      counts[bottleneck.severity] = (counts[bottleneck.severity] ?? 0) + 1;
    }
    return counts;
  }
}
