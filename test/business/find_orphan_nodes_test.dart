import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_orphan_nodes.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('FindOrphanNodes', () {
    test('flags a fully isolated node', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'c', label: 'C'),
        ],
        edges: const [ProcessEdge(sourceId: 'a', targetId: 'b')],
      );

      final result = FindOrphanNodes.call(graph);

      expect(result.map((n) => n.id), ['c']);
    });
  });
}
