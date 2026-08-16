import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_confidence_score.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

void main() {
  group('ComputeConfidenceScore', () {
    test('exact match scores 1.0', () {
      expect(ComputeConfidenceScore.call(MatchConfidence.exact), 1.0);
    });

    test('fuzzy match scores 0.5', () {
      expect(ComputeConfidenceScore.call(MatchConfidence.fuzzy), 0.5);
    });

    test('mismatch scores 0.0', () {
      expect(ComputeConfidenceScore.call(MatchConfidence.mismatch), 0.0);
    });
  });
}
