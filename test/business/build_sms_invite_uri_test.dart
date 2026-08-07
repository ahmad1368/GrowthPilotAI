import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_sms_invite_uri.dart';

void main() {
  test('builds an sms: URI with the message as the body', () {
    final uri = BuildSmsInviteUri.call('+16045550101', 'Join me!');
    expect(uri.scheme, 'sms');
    expect(uri.path, '+16045550101');
    expect(uri.queryParameters['body'], 'Join me!');
  });
}
