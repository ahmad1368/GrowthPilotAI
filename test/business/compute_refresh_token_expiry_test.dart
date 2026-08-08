import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_refresh_token_expiry.dart';

void main() {
  test('expires 30 days after issuance', () {
    final issuedAt = DateTime(2026, 1, 1);
    expect(ComputeRefreshTokenExpiry.call(issuedAt), DateTime(2026, 1, 31));
  });
}
