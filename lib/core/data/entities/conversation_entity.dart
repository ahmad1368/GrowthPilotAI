import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';
import 'package:growth_pilot_ai/core/enum/conversation_context_type.dart';

/// One inbox thread (Issue #70) — the Flutter-side local model for what the
/// original issue specified as a MongoDB `conversations` collection. Can be
/// linked to a Transaction/Order/Lead via [contextType]/[contextRefId] for
/// the "360-degree view" the issue calls for.
@Entity()
class ConversationEntity {
  @Id()
  int id = 0;

  String subject;
  List<String> participantIds;
  @Index()
  DateTime lastMessageAt;
  int dbStatus; // ConversationStatus index
  int dbContextType; // ConversationContextType index
  String? contextRefId; // e.g. UnifiedTransactionEntity.externalId

  ConversationEntity({
    this.id = 0,
    required this.subject,
    required this.participantIds,
    required this.lastMessageAt,
    this.dbStatus = 0, // ConversationStatus.active
    this.dbContextType = 0, // ConversationContextType.none
    this.contextRefId,
  });

  ConversationStatus get status => ConversationStatus.values[dbStatus];
  ConversationContextType get contextType =>
      ConversationContextType.values[dbContextType];
  bool get hasContext => contextType != ConversationContextType.none;
  bool get isArchived => status == ConversationStatus.archived;
}
