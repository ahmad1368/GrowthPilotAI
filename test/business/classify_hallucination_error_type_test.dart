import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_hallucination_error_type.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

void main() {
  group('ClassifyHallucinationErrorType', () {
    test('null when the response was exactly verified (nothing to report)', () {
      expect(ClassifyHallucinationErrorType.call(MatchConfidence.exact), isNull);
    });

    test('Numeric_Mismatch for a fuzzy match', () {
      expect(ClassifyHallucinationErrorType.call(MatchConfidence.fuzzy), 'Numeric_Mismatch');
    });

    test('Numeric_Mismatch for a full mismatch', () {
      expect(ClassifyHallucinationErrorType.call(MatchConfidence.mismatch), 'Numeric_Mismatch');
    });
  });
}
