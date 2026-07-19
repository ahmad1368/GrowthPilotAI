import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_context_type.dart';

/// Three demo inbox threads (Issue #70): one linked to the Home Depot
/// duplicate transaction from Issue #69 (contextual linking demo), one plain
/// vendor thread, one flagged by the Issue #74 anomaly detector. Stands in
/// for a real conversation list since no backend exists in this repo yet.
class SeedDemoConversations {
  static List<ConversationEntity> call() {
    final now = DateTime.now();
    return [
      ConversationEntity(
        subject: 'Home Depot — invoice question',
        participantIds: const ['me', 'vendor-home-depot'],
        lastMessageAt: now,
        dbContextType: ConversationContextType.transaction.index,
        contextRefId: 'plaid-hd-451',
      ),
      ConversationEntity(
        subject: 'BC Hydro — account update',
        participantIds: const ['me', 'vendor-bc-hydro'],
        lastMessageAt: now.subtract(const Duration(hours: 3)),
      ),
      ConversationEntity(
        subject: 'Zenith Office Supplies — unusual charge',
        participantIds: const ['me', 'system'],
        lastMessageAt: now.subtract(const Duration(minutes: 10)),
        dbContextType: ConversationContextType.transaction.index,
        contextRefId: 'plaid-zenith-9012',
      ),
    ];
  }
}
