import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/score_requirement_confidence.dart';

void main() {
  group('ScoreRequirementConfidence', () {
    test('scores a strong modal verb higher than a weak one', () {
      final strong = ScoreRequirementConfidence.call('shall');
      final weak = ScoreRequirementConfidence.call('will');

      expect(strong, greaterThan(weak));
    });

    test('returns a value between 0 and 1 for every known indicator', () {
      for (final indicator in ['shall', 'must', 'is required to', 'should', 'will']) {
        final score = ScoreRequirementConfidence.call(indicator);
        expect(score, inInclusiveRange(0.0, 1.0));
      }
    });

    test('falls back to a neutral score for an unknown indicator', () {
      expect(ScoreRequirementConfidence.call('unknown'), 0.5);
    });
  });
}
