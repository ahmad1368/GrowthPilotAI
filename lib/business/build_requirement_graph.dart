import 'package:graphview/GraphView.dart';
import 'package:growth_pilot_ai/business/is_valid_dag.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Maps [RequirementNode]s into a `graphview` [Graph] (Issue #219's
/// "Data Mapper") — returns null when [IsValidDag] fails, so the caller
/// never hands `graphview` a cyclic structure that would render
/// infinitely (AC: "Data Integrity").
class BuildRequirementGraph {
  static Graph? call(List<RequirementNode> nodes) {
    if (!IsValidDag.call(nodes)) return null;

    final graph = Graph();
    final byId = {for (final n in nodes) n.id: Node.Id(n.id)};
    for (final node in byId.values) {
      graph.addNode(node);
    }
    for (final n in nodes) {
      final parentNode = n.parentId == null ? null : byId[n.parentId];
      if (parentNode != null) {
        graph.addEdge(parentNode, byId[n.id]!);
      }
    }
    return graph;
  }
}
