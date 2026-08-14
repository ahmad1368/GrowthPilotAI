import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_referral_invite_message.dart';

void main() {
  test('includes the code, expiry date, and app name', () {
    final message =
        BuildReferralInviteMessage.call('GrowthPilot AI', 'ABC12345', DateTime(2026, 1, 8));
    expect(message, contains('GrowthPilot AI'));
    expect(message, contains('ABC12345'));
    expect(message, contains('2026-01-08'));
  });
}
