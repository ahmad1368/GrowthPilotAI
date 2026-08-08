import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_access_token_expiry.dart';

void main() {
  test('expires 15 minutes after issuance', () {
    final issuedAt = DateTime(2026, 1, 1, 12, 0);
    expect(ComputeAccessTokenExpiry.call(issuedAt), DateTime(2026, 1, 1, 12, 15));
  });
}
