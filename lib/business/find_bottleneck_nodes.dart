import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// "Bottleneck Detection" (Issue #223's own example: "a single point of
/// failure with 4 incoming edges and only 1 outgoing manual task") —
/// nodes where many paths converge but throughput narrows back down to
/// (at most) one path forward.
class FindBottleneckNodes {
  static const defaultMinIncoming = 3;
  static const defaultMaxOutgoing = 1;

  static List<ProcessNode> call(
    ProcessGraph graph, {
    int minIncoming = defaultMinIncoming,
    int maxOutgoing = defaultMaxOutgoing,
  }) {
    return graph.nodes
        .where((n) => graph.inDegree(n.id) >= minIncoming && graph.outDegree(n.id) <= maxOutgoing)
        .toList();
  }
}
