import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';

/// Restores an ARCHIVED conversation to ACTIVE in place (Issue #76's
/// "Undo" action on a batch/single archive). No-op, returning false, if it
/// isn't currently archived.
class UnarchiveConversation {
  static bool call(ConversationEntity conversation) {
    if (!conversation.isArchived) return false;
    conversation.dbStatus = ConversationStatus.active.index;
    return true;
  }
}
