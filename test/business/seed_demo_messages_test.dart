import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_demo_messages.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

void main() {
  test('Home Depot thread ends with a pending ACTION_CARD message', () {
    final messages = SeedDemoMessages.forConversation(1, 0);

    expect(messages.length, 2);
    expect(messages.every((m) => m.conversationId == 1), isTrue);
    expect(messages.last.contentType, MessageContentType.actionCard);
    expect(messages.last.dbActionCardStatus, ActionCardStatus.pending.index);
    expect(messages.last.actionCardAmount, 450.0);
  });

  test('BC Hydro thread has a single plain text message', () {
    final messages = SeedDemoMessages.forConversation(2, 1);

    expect(messages.length, 1);
    expect(messages.single.contentType, MessageContentType.text);
    expect(messages.single.conversationId, 2);
  });

  test('Zenith thread has a single pending anomaly ACTION_CARD', () {
    final messages = SeedDemoMessages.forConversation(3, 2);

    expect(messages.single.contentType, MessageContentType.actionCard);
    expect(messages.single.dbActionCardStatus, ActionCardStatus.pending.index);
    expect(messages.single.conversationId, 3);
  });

  test('recommendation thread has a single pending Smart Recommendation ACTION_CARD',
      () {
    final messages = SeedDemoMessages.forConversation(4, 3);

    expect(messages.single.contentType, MessageContentType.actionCard);
    expect(messages.single.dbActionCardStatus, ActionCardStatus.pending.index);
    expect(messages.single.conversationId, 4);
  });
}
