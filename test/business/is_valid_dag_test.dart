import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_valid_dag.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

void main() {
  group('IsValidDag', () {
    test('true for a simple tree', () {
      final nodes = [
        const RequirementNode(id: 'root', label: 'Root'),
        const RequirementNode(id: 'a', label: 'A', parentId: 'root'),
        const RequirementNode(id: 'b', label: 'B', parentId: 'root'),
        const RequirementNode(id: 'c', label: 'C', parentId: 'a'),
      ];

      expect(IsValidDag.call(nodes), isTrue);
    });

    test('false for a direct cycle', () {
      final nodes = [
        const RequirementNode(id: 'a', label: 'A', parentId: 'b'),
        const RequirementNode(id: 'b', label: 'B', parentId: 'a'),
      ];

      expect(IsValidDag.call(nodes), isFalse);
    });

    test('false for a self-referencing node', () {
      final nodes = [const RequirementNode(id: 'a', label: 'A', parentId: 'a')];

      expect(IsValidDag.call(nodes), isFalse);
    });

    test('false for a longer indirect cycle', () {
      final nodes = [
        const RequirementNode(id: 'a', label: 'A', parentId: 'c'),
        const RequirementNode(id: 'b', label: 'B', parentId: 'a'),
        const RequirementNode(id: 'c', label: 'C', parentId: 'b'),
      ];

      expect(IsValidDag.call(nodes), isFalse);
    });
  });
}
