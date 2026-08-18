import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_diagram_from_text.dart';

void main() {
  group('GenerateDiagramFromText', () {
    test('combines parsing, layout, and bottleneck insights', () {
      final diagram = GenerateDiagramFromText.call('Submit\nReview\nApprove');

      expect(diagram.graph.nodes.length, 3);
      expect(diagram.positions.length, 3);
      expect(diagram.insights, isEmpty);
    });

    test('flags an orphan step disconnected from the rest of the process', () {
      final diagram = GenerateDiagramFromText.call('A -> B\nUnrelated note');

      expect(diagram.insights, isNotEmpty);
      expect(diagram.insights.first.issueLabel, 'Orphan Step');
    });
  });
}
