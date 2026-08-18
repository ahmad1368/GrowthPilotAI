import 'package:growth_pilot_ai/business/find_bottleneck_nodes.dart';
import 'package:growth_pilot_ai/business/find_dead_end_nodes.dart';
import 'package:growth_pilot_ai/business/find_orphan_nodes.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// Combines the individual detection rules into the issue's own
/// "Insight Payload" shape (Issue #223).
class BuildBottleneckInsights {
  static List<BottleneckInsight> call(ProcessGraph graph) {
    final insights = <BottleneckInsight>[];

    for (final node in FindBottleneckNodes.call(graph)) {
      insights.add(BottleneckInsight(
        nodeId: node.id,
        issueLabel: 'Bottleneck Detected',
        severity: BottleneckSeverity.high,
        reason:
            'Single point of failure with ${graph.inDegree(node.id)} incoming edges and only '
            '${graph.outDegree(node.id)} outgoing path.',
        suggestion: 'Consider adding an automated gateway or parallel processing.',
      ));
    }
    for (final node in FindDeadEndNodes.call(graph)) {
      insights.add(BottleneckInsight(
        nodeId: node.id,
        issueLabel: 'Dead End',
        severity: BottleneckSeverity.medium,
        reason: 'This step is reached but has no path forward.',
        suggestion: 'Add a next step or mark this explicitly as a process end.',
      ));
    }
    for (final node in FindOrphanNodes.call(graph)) {
      insights.add(BottleneckInsight(
        nodeId: node.id,
        issueLabel: 'Orphan Step',
        severity: BottleneckSeverity.low,
        reason: 'This step is not connected to the rest of the process.',
        suggestion: 'Connect it to the process or remove it.',
      ));
    }
    return insights;
  }
}
