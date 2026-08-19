import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_text_overlap_score.dart';

void main() {
  group('ComputeTextOverlapScore', () {
    test('returns 0 for completely unrelated texts', () {
      final score = ComputeTextOverlapScore.call('Reduce customer wait time', 'Improve battery life');

      expect(score, 0);
    });

    test('returns a positive score for texts sharing significant words', () {
      final score = ComputeTextOverlapScore.call(
          'Reduce customer wait time and response latency',
          'The system shall reduce response latency for customer queries');

      expect(score, greaterThan(0));
    });

    test('returns 0 when either text has no significant words', () {
      expect(ComputeTextOverlapScore.call('', 'Reduce customer wait time'), 0);
    });
  });
}
