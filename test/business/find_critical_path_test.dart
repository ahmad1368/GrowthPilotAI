import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_critical_path.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('FindCriticalPath', () {
    test('finds the longest chain, not a shorter shortcut', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'start', label: 'Start'),
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'end', label: 'End'),
        ],
        edges: const [
          ProcessEdge(sourceId: 'start', targetId: 'end'), // shortcut
          ProcessEdge(sourceId: 'start', targetId: 'a'),
          ProcessEdge(sourceId: 'a', targetId: 'b'),
          ProcessEdge(sourceId: 'b', targetId: 'end'), // longer path
        ],
      );

      expect(FindCriticalPath.call(graph), ['start', 'a', 'b', 'end']);
    });

    test('returns empty for a cyclic graph', () {
      final graph = ProcessGraph(
        nodes: const [ProcessNode(id: 'a', label: 'A'), ProcessNode(id: 'b', label: 'B')],
        edges: const [
          ProcessEdge(sourceId: 'a', targetId: 'b'),
          ProcessEdge(sourceId: 'b', targetId: 'a'),
        ],
      );

      expect(FindCriticalPath.call(graph), isEmpty);
    });

    test('a single isolated node is its own path', () {
      final graph = ProcessGraph(nodes: const [ProcessNode(id: 'a', label: 'A')], edges: const []);

      expect(FindCriticalPath.call(graph), ['a']);
    });
  });
}
