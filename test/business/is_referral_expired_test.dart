import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_referral_expired.dart';

void main() {
  test('is not expired before the expiry date', () {
    expect(IsReferralExpired.call(DateTime(2026, 1, 8), DateTime(2026, 1, 5)), false);
  });

  test('is expired after the expiry date', () {
    expect(IsReferralExpired.call(DateTime(2026, 1, 8), DateTime(2026, 1, 9)), true);
  });
}
