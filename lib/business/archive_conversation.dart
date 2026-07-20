import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';

/// Marks a conversation ARCHIVED in place (Issue #76 "Swipe-to-Archive").
/// No-op, returning false, if it's already archived — mirrors
/// [DismissRecommendation]'s idempotent-guard pattern.
class ArchiveConversation {
  static bool call(ConversationEntity conversation) {
    if (conversation.isArchived) return false;
    conversation.dbStatus = ConversationStatus.archived.index;
    return true;
  }
}
