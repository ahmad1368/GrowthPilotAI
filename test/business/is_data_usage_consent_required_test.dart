import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_data_usage_consent_required.dart';

void main() {
  group('IsDataUsageConsentRequired', () {
    test('mandatory for the free tier', () {
      expect(IsDataUsageConsentRequired.call(false), isTrue);
    });

    test('optional once premium', () {
      expect(IsDataUsageConsentRequired.call(true), isFalse);
    });
  });
}
