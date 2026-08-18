import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// "Critical Path" (Issue #223, section 1) — the longest chain of steps
/// through the process, found via Kahn's topological sort + a longest-
/// path DP over node count. No time/cost node attributes exist yet
/// (#223's own "if the user provides time/cost attributes" caveat), so
/// path length is the proxy metric — a documented simplification, not
/// the issue's full cycle-time calculation (see PR notes). Returns an
/// empty list if the graph is cyclic, since a critical path is
/// undefined there.
class FindCriticalPath {
  static List<String> call(ProcessGraph graph) {
    final inDegree = {for (final n in graph.nodes) n.id: graph.inDegree(n.id)};
    final queue = [for (final n in graph.nodes) if (inDegree[n.id] == 0) n.id];
    final order = <String>[];

    while (queue.isNotEmpty) {
      final id = queue.removeAt(0);
      order.add(id);
      for (final edge in graph.outgoing[id] ?? []) {
        inDegree[edge.targetId] = inDegree[edge.targetId]! - 1;
        if (inDegree[edge.targetId] == 0) queue.add(edge.targetId);
      }
    }
    if (order.length != graph.nodes.length) return const [];

    final length = {for (final id in order) id: 1};
    final predecessor = <String, String>{};
    for (final id in order) {
      for (final edge in graph.outgoing[id] ?? []) {
        if (length[id]! + 1 > length[edge.targetId]!) {
          length[edge.targetId] = length[id]! + 1;
          predecessor[edge.targetId] = id;
        }
      }
    }

    if (length.isEmpty) return const [];
    var endId = length.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    final path = [endId];
    while (predecessor.containsKey(endId)) {
      endId = predecessor[endId]!;
      path.insert(0, endId);
    }
    return path;
  }
}
