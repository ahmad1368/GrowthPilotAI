import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_chat_message_notification.dart';

void main() {
  test('builds a generic, PII-free chat notification with a deep-link target', () {
    final notification = BuildChatMessageNotification.call(
        senderId: 'vendor-1', roomId: 5, now: DateTime(2026, 1, 1));

    expect(notification.metadataRefType, 'ChatRoom');
    expect(notification.metadataRefId, '5');
    expect(notification.body, isNot(contains('\$')));
  });
}
