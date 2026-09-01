import 'package:growth_pilot_ai/business/archive_conversation.dart';
import 'package:growth_pilot_ai/business/unarchive_conversation.dart';
import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';

/// Extracted from [InboxController] (Issue #76) to keep that file within
/// the 50-line limit: applies swipe/batch archive and Undo, persisting
/// through [ConversationRepository].
class ArchiveHandler {
  final ConversationRepository _conversations;

  ArchiveHandler(this._conversations);

  ConversationEntity? archiveOne(int conversationId) {
    final entity = _conversations.getById(conversationId);
    if (entity == null || !ArchiveConversation.call(entity)) return null;
    _conversations.upsert(entity);
    return entity;
  }

  List<ConversationEntity> batchArchive(List<int> conversationIds) {
    final archived = <ConversationEntity>[];
    for (final id in conversationIds) {
      final entity = _conversations.getById(id);
      if (entity != null && ArchiveConversation.call(entity)) {
        _conversations.upsert(entity);
        archived.add(entity);
      }
    }
    return archived;
  }

  void undo(List<ConversationEntity> entities) {
    for (final entity in entities) {
      if (UnarchiveConversation.call(entity)) _conversations.upsert(entity);
    }
  }
}
