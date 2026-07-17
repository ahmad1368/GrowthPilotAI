import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Builds one Inbox row's display data (Issue #72) from a conversation and
/// its messages. [linkedTransactionAmount] is looked up by the caller via
/// [ConversationEntity.contextRefId] against the UnifiedTransaction store
/// (Issue #69).
class BuildConversationSummary {
  static ConversationSummary call(
    ConversationEntity conversation,
    List<MessageEntity> messages,
    double? linkedTransactionAmount,
  ) {
    final sorted = [...messages]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final latest = sorted.isEmpty ? null : sorted.first;

    return ConversationSummary(
      conversationId: conversation.id,
      subject: conversation.subject,
      lastMessagePreview: latest?.body ?? 'No messages yet',
      lastMessageAt: latest?.createdAt ?? conversation.lastMessageAt,
      unreadCount: messages.where((m) => !m.isRead).length,
      linkedTransactionAmount:
          conversation.hasContext ? linkedTransactionAmount : null,
    );
  }
}
