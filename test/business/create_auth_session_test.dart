import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/create_auth_session.dart';
import 'package:growth_pilot_ai/business/verify_refresh_token.dart';

void main() {
  test('issues a session whose stored hash matches the raw refresh token', () {
    final now = DateTime(2026, 1, 1);
    final result = CreateAuthSession.call('This Device', now);
    expect(VerifyRefreshToken.call(result.rawRefreshToken, result.session.refreshTokenHash), true);
    expect(result.session.isRevoked, false);
    expect(result.session.deviceLabel, 'This Device');
  });
}
