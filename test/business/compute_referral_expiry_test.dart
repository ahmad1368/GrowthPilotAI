import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_referral_expiry.dart';

void main() {
  test('expires 7 days after issuance', () {
    final issuedAt = DateTime(2026, 1, 1);
    expect(ComputeReferralExpiry.call(issuedAt), DateTime(2026, 1, 8));
  });
}
