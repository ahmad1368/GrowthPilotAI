import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_quick_invite_message.dart';

void main() {
  test('includes the app name and an invite link', () {
    final message = BuildQuickInviteMessage.call('GrowthPilot AI');
    expect(message, contains('GrowthPilot AI'));
    expect(message, contains('https://'));
  });
}
