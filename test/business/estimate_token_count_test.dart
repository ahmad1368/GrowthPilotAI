import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/estimate_token_count.dart';

void main() {
  group('EstimateTokenCount', () {
    test('rounds up to a whole token', () {
      expect(EstimateTokenCount.call('abcde'), 2); // 5 chars / 4 -> 1.25 -> 2
    });

    test('an empty string is zero tokens', () {
      expect(EstimateTokenCount.call(''), 0);
    });

    test('exactly divisible length has no rounding artifact', () {
      expect(EstimateTokenCount.call('abcdefgh'), 2); // 8 chars / 4 -> 2
    });
  });
}
