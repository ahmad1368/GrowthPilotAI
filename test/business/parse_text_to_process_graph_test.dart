import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_text_to_process_graph.dart';

void main() {
  group('ParseTextToProcessGraph', () {
    test('plain lines become a sequential chain', () {
      final graph = ParseTextToProcessGraph.call('Submit request\nManager review\nApprove');

      expect(graph.nodes.map((n) => n.label), ['Submit request', 'Manager review', 'Approve']);
      expect(graph.edges.length, 2);
      expect(graph.outDegree(graph.nodes[0].id), 1);
      expect(graph.outDegree(graph.nodes.last.id), 0);
    });

    test('arrow syntax builds explicit branching edges', () {
      final graph = ParseTextToProcessGraph.call(
          'Review -> Approve\nReview -> Reject');

      expect(graph.nodes.length, 3);
      final review = graph.nodes.firstWhere((n) => n.label == 'Review');
      expect(graph.outDegree(review.id), 2);
    });

    test('blank lines are ignored', () {
      final graph = ParseTextToProcessGraph.call('A\n\nB\n   \nC');

      expect(graph.nodes.length, 3);
    });

    test('same label reused across arrow lines maps to one node', () {
      final graph = ParseTextToProcessGraph.call('A -> B\nA -> C');

      expect(graph.nodes.where((n) => n.label == 'A').length, 1);
    });
  });
}
