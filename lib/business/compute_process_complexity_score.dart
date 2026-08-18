import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// "Risk Scoring... weighted algorithm to score Process Complexity"
/// (Issue #223, section 1) — a documented, simple heuristic (node count
/// + edge count + the busiest node's fan-out, each weighted), not a
/// peer-reviewed complexity metric. Higher scores mean more paths to
/// reason about and more places a single change can ripple.
class ComputeProcessComplexityScore {
  static double call(ProcessGraph graph) {
    final maxOutDegree = graph.nodes.isEmpty
        ? 0
        : graph.nodes.map((n) => graph.outDegree(n.id)).reduce((a, b) => a > b ? a : b);

    return graph.nodes.length * 1.0 + graph.edges.length * 1.5 + maxOutDegree * 2.0;
  }
}
