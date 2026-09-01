import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_dead_end_nodes.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('FindDeadEndNodes', () {
    test('flags a reached node with no outgoing edge', () {
      final graph = ProcessGraph(
        nodes: const [ProcessNode(id: 'a', label: 'A'), ProcessNode(id: 'b', label: 'B')],
        edges: const [ProcessEdge(sourceId: 'a', targetId: 'b')],
      );

      final result = FindDeadEndNodes.call(graph);

      expect(result.map((n) => n.id), ['b']);
    });

    test('an isolated node (no incoming edge either) is not a dead end', () {
      final graph = ProcessGraph(
        nodes: const [ProcessNode(id: 'a', label: 'A')],
        edges: const [],
      );

      expect(FindDeadEndNodes.call(graph), isEmpty);
    });
  });
}
