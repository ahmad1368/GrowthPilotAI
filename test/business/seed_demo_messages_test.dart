import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_demo_messages.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

void main() {
  test('Home Depot thread ends with a system event message', () {
    final messages = SeedDemoMessages.forConversation(1, 0);

    expect(messages.length, 2);
    expect(messages.every((m) => m.conversationId == 1), isTrue);
    expect(messages.last.contentType, MessageContentType.systemEvent);
  });

  test('BC Hydro thread has a single plain text message', () {
    final messages = SeedDemoMessages.forConversation(2, 1);

    expect(messages.length, 1);
    expect(messages.single.contentType, MessageContentType.text);
    expect(messages.single.conversationId, 2);
  });
}
