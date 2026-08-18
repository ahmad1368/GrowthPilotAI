import 'package:growth_pilot_ai/core/models/positioned_process_node.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// Local "Auto-Layout" (Issue #224) — a layered/Sugiyama-style
/// placement computed on-device via longest-distance-from-a-source
/// levels, not a Node.js `dagre`/`d3-hierarchy` call (see PR notes:
/// no backend exists in this repo to run one).
class ComputeLayeredLayout {
  static const levelSpacing = 160.0;
  static const nodeSpacing = 90.0;

  static List<PositionedProcessNode> call(ProcessGraph graph) {
    final level = {for (final n in graph.nodes) n.id: 0};
    final queue = [for (final n in graph.nodes) if (graph.inDegree(n.id) == 0) n.id];
    final visited = <String>{...queue};

    while (queue.isNotEmpty) {
      final id = queue.removeAt(0);
      for (final edge in graph.outgoing[id] ?? const []) {
        final candidate = level[id]! + 1;
        if (candidate > level[edge.targetId]!) level[edge.targetId] = candidate;
        if (visited.add(edge.targetId)) queue.add(edge.targetId);
      }
    }

    final countPerLevel = <int, int>{};
    final positioned = <PositionedProcessNode>[];
    for (final node in graph.nodes) {
      final lvl = level[node.id]!;
      final index = countPerLevel[lvl] = (countPerLevel[lvl] ?? 0) + 1;
      positioned.add(PositionedProcessNode(
          node: node, x: lvl * levelSpacing, y: (index - 1) * nodeSpacing));
    }
    return positioned;
  }
}
