import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_helpfulness_score.dart';

void main() {
  group('ComputeHelpfulnessScore', () {
    test('0 when there is no feedback yet, not a division-by-zero crash', () {
      expect(ComputeHelpfulnessScore.call(const []), 0);
    });

    test('100 when every vote is helpful', () {
      expect(ComputeHelpfulnessScore.call([true, true, true]), 100);
    });

    test('0 when every vote is unhelpful', () {
      expect(ComputeHelpfulnessScore.call([false, false]), 0);
    });

    test('computes the percentage for a mixed set of votes', () {
      expect(ComputeHelpfulnessScore.call([true, true, false, false]), 50);
    });
  });
}
