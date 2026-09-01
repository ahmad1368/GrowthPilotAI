import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_requirement_graph.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

void main() {
  group('BuildRequirementGraph', () {
    test('builds a node per requirement and an edge per parent link', () {
      final graph = BuildRequirementGraph.call([
        const RequirementNode(id: 'root', label: 'Root'),
        const RequirementNode(id: 'a', label: 'A', parentId: 'root'),
        const RequirementNode(id: 'b', label: 'B', parentId: 'root'),
      ]);

      expect(graph, isNotNull);
      expect(graph!.nodeCount(), 3);
      expect(graph.edges.length, 2);
    });

    test('returns null for a cyclic structure instead of building it', () {
      final graph = BuildRequirementGraph.call([
        const RequirementNode(id: 'a', label: 'A', parentId: 'b'),
        const RequirementNode(id: 'b', label: 'B', parentId: 'a'),
      ]);

      expect(graph, isNull);
    });
  });
}
