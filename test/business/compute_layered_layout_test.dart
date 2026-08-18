import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_layered_layout.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('ComputeLayeredLayout', () {
    test('assigns increasing x per level along a chain', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'c', label: 'C'),
        ],
        edges: const [
          ProcessEdge(sourceId: 'a', targetId: 'b'),
          ProcessEdge(sourceId: 'b', targetId: 'c'),
        ],
      );

      final positions = ComputeLayeredLayout.call(graph);
      final byId = {for (final p in positions) p.node.id: p};

      expect(byId['a']!.x, 0);
      expect(byId['b']!.x, ComputeLayeredLayout.levelSpacing);
      expect(byId['c']!.x, ComputeLayeredLayout.levelSpacing * 2);
    });

    test('sibling nodes at the same level get different y', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'c', label: 'C'),
        ],
        edges: const [
          ProcessEdge(sourceId: 'a', targetId: 'b'),
          ProcessEdge(sourceId: 'a', targetId: 'c'),
        ],
      );

      final positions = ComputeLayeredLayout.call(graph);
      final byId = {for (final p in positions) p.node.id: p};

      expect(byId['b']!.x, byId['c']!.x);
      expect(byId['b']!.y, isNot(byId['c']!.y));
    });
  });
}
