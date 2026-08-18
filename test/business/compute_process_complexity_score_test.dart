import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_process_complexity_score.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('ComputeProcessComplexityScore', () {
    test('an empty graph scores zero', () {
      final graph = ProcessGraph(nodes: const [], edges: const []);

      expect(ComputeProcessComplexityScore.call(graph), 0);
    });

    test('more nodes, edges, and branching increase the score', () {
      final simple = ProcessGraph(
        nodes: const [ProcessNode(id: 'a', label: 'A'), ProcessNode(id: 'b', label: 'B')],
        edges: const [ProcessEdge(sourceId: 'a', targetId: 'b')],
      );
      final complex = ProcessGraph(
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

      expect(ComputeProcessComplexityScore.call(complex),
          greaterThan(ComputeProcessComplexityScore.call(simple)));
    });
  });
}
