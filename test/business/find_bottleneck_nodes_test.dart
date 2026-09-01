import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_bottleneck_nodes.dart';
import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

void main() {
  group('FindBottleneckNodes', () {
    test('flags a node with many incoming edges and one outgoing edge', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'c', label: 'C'),
          ProcessNode(id: 'd', label: 'D'),
          ProcessNode(id: 'target', label: 'Target'),
          ProcessNode(id: 'next', label: 'Next'),
        ],
        edges: const [
          ProcessEdge(sourceId: 'a', targetId: 'target'),
          ProcessEdge(sourceId: 'b', targetId: 'target'),
          ProcessEdge(sourceId: 'c', targetId: 'target'),
          ProcessEdge(sourceId: 'd', targetId: 'target'),
          ProcessEdge(sourceId: 'target', targetId: 'next'),
        ],
      );

      final result = FindBottleneckNodes.call(graph);

      expect(result.map((n) => n.id), ['target']);
    });

    test('a node with many incoming and many outgoing edges is not flagged', () {
      final graph = ProcessGraph(
        nodes: const [
          ProcessNode(id: 'a', label: 'A'),
          ProcessNode(id: 'b', label: 'B'),
          ProcessNode(id: 'c', label: 'C'),
          ProcessNode(id: 'hub', label: 'Hub'),
          ProcessNode(id: 'x', label: 'X'),
          ProcessNode(id: 'y', label: 'Y'),
        ],
        edges: const [
          ProcessEdge(sourceId: 'a', targetId: 'hub'),
          ProcessEdge(sourceId: 'b', targetId: 'hub'),
          ProcessEdge(sourceId: 'c', targetId: 'hub'),
          ProcessEdge(sourceId: 'hub', targetId: 'x'),
          ProcessEdge(sourceId: 'hub', targetId: 'y'),
        ],
      );

      expect(FindBottleneckNodes.call(graph), isEmpty);
    });
  });
}
