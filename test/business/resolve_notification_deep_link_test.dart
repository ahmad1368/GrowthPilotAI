import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_notification_deep_link.dart';

void main() {
  test('resolves a ChatRoom notification to the chat route', () {
    final link = ResolveNotificationDeepLink.call('ChatRoom', '5');
    expect(link, isNotNull);
    expect(link!.routeName, '/chat');
    expect(link.args, {'roomId': '5'});
  });

  test('returns null for an unhandled metadata type', () {
    expect(ResolveNotificationDeepLink.call('Conversation', '1'), isNull);
  });

  test('returns null when the ref id is missing', () {
    expect(ResolveNotificationDeepLink.call('ChatRoom', null), isNull);
  });
}
