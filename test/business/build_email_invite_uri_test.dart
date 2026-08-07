import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_email_invite_uri.dart';

void main() {
  test('builds a mailto: URI with subject and body', () {
    final uri = BuildEmailInviteUri.call('beta@example.com', 'Join me', 'Here is my code');
    expect(uri.scheme, 'mailto');
    expect(uri.path, 'beta@example.com');
    expect(uri.queryParameters['subject'], 'Join me');
    expect(uri.queryParameters['body'], 'Here is my code');
  });
}
