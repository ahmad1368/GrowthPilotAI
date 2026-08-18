import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// The local, in-memory equivalent of `canvas_state` (Issue #223) — a
/// directed graph plus precomputed incoming/outgoing edge lookups, so
/// every analysis rule can share one pass over the edge list.
class ProcessGraph {
  final List<ProcessNode> nodes;
  final List<ProcessEdge> edges;
  final Map<String, List<ProcessEdge>> outgoing = {};
  final Map<String, List<ProcessEdge>> incoming = {};

  ProcessGraph({required this.nodes, required this.edges}) {
    for (final node in nodes) {
      outgoing[node.id] = [];
      incoming[node.id] = [];
    }
    for (final edge in edges) {
      outgoing[edge.sourceId]?.add(edge);
      incoming[edge.targetId]?.add(edge);
    }
  }

  int outDegree(String nodeId) => outgoing[nodeId]?.length ?? 0;
  int inDegree(String nodeId) => incoming[nodeId]?.length ?? 0;
}
