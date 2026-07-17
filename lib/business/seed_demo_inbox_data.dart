import 'package:growth_pilot_ai/business/seed_demo_conversations.dart';
import 'package:growth_pilot_ai/business/seed_demo_messages.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';

/// Seeds the two demo conversations (Issue #70) the first time the Inbox is
/// opened. Conversations must be persisted before their messages since
/// ObjectBox only assigns [ConversationEntity.id] on insert.
class SeedDemoInboxData {
  static void call(
      ConversationRepository conversations, MessageRepository messages) {
    if (conversations.getAll().isNotEmpty) return;

    final demoConversations = SeedDemoConversations.call();
    for (var i = 0; i < demoConversations.length; i++) {
      final conversation = demoConversations[i];
      conversations.upsert(conversation);
      for (final message in SeedDemoMessages.forConversation(conversation.id, i)) {
        messages.upsert(message);
      }
    }
  }
}
