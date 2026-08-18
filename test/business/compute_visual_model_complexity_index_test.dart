import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_visual_model_complexity_index.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

void main() {
  group('ComputeVisualModelComplexityIndex', () {
    test('returns 0 for an empty node list', () {
      expect(ComputeVisualModelComplexityIndex.call(const []), 0);
    });

    test('sums node count and parent-linked edge count', () {
      final index = ComputeVisualModelComplexityIndex.call(const [
        RequirementNode(id: 'root', label: 'Root'),
        RequirementNode(id: 'child', label: 'Child', parentId: 'root'),
      ]);

      expect(index, 3);
    });
  });
}
