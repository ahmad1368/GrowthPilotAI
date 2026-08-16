import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_ai_response.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

void main() {
  group('VerifyAiResponse', () {
    test('no currency mentioned is trivially verified', () {
      final result = VerifyAiResponse.call('Here is a summary.', [450.0]);
      expect(result.overallConfidence, MatchConfidence.exact);
      expect(result.extractedAmounts, isEmpty);
    });

    test('a line-item amount that matches a context record is exact', () {
      final result = VerifyAiResponse.call('You spent \$450 at Costco.', [450.0, 200.0]);
      expect(result.overallConfidence, MatchConfidence.exact);
      expect(result.unmatchedAmounts, isEmpty);
    });

    test('a stated total matching the sum of context records is exact', () {
      final result = VerifyAiResponse.call('Your total is \$600.', [200.0, 200.0, 200.0]);
      expect(result.overallConfidence, MatchConfidence.exact);
    });

    test('a figure with zero correlation is flagged as a mismatch (Hallucination)', () {
      final result = VerifyAiResponse.call('You spent \$5000 at Costco.', [450.0, 200.0]);
      expect(result.overallConfidence, MatchConfidence.mismatch);
      expect(result.unmatchedAmounts, [5000.0]);
    });

    test('one hallucinated figure makes the whole response mismatch, not just fuzzy', () {
      final result = VerifyAiResponse.call('\$450 at Costco and \$9999 at Nowhere.', [450.0]);
      expect(result.overallConfidence, MatchConfidence.mismatch);
    });
  });
}
