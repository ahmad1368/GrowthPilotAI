import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_amount_against_context.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

void main() {
  group('VerifyAmountAgainstContext', () {
    test('exact match when the amount is in the context list', () {
      expect(VerifyAmountAgainstContext.call(450.0, [450.0, 200.0]), MatchConfidence.exact);
    });

    test('fuzzy match within the rounding tolerance', () {
      expect(VerifyAmountAgainstContext.call(450.0, [452.80]), MatchConfidence.fuzzy);
    });

    test('mismatch when there is no correlation at all', () {
      expect(VerifyAmountAgainstContext.call(1000.0, [200.0, 50.0]), MatchConfidence.mismatch);
    });

    test('mismatch against an empty context', () {
      expect(VerifyAmountAgainstContext.call(450.0, const []), MatchConfidence.mismatch);
    });
  });
}
