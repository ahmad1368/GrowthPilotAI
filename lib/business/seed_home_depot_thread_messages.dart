import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

/// The Home Depot demo thread's messages (Issue #70): a question followed
/// by a PENDING approval ACTION_CARD (Issue #73), split out of
/// [SeedDemoMessages] to keep that file within the 50-line file limit.
class SeedHomeDepotThreadMessages {
  static List<MessageEntity> call(int conversationId, DateTime now) {
    return [
      MessageEntity(
        conversationId: conversationId,
        senderId: 'vendor-home-depot',
        body: 'Can you confirm the \$450 charge on invoice #451?',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      MessageEntity(
        conversationId: conversationId,
        senderId: 'system',
        body: 'Approve the \$450 Home Depot charge to sync it to QuickBooks.',
        dbContentType: MessageContentType.actionCard.index,
        dbActionCardType: ActionCardType.approveTransaction.index,
        dbActionCardStatus: ActionCardStatus.pending.index,
        actionCardAmount: 450.00,
        actionCardTransactionRefId: 'plaid-hd-451',
        createdAt: now,
      ),
    ];
  }
}
