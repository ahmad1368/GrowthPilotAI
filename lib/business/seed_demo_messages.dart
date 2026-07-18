import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

/// Demo messages for [SeedDemoConversations]' two threads (Issue #70), keyed
/// by the seed's index (0 = Home Depot thread, 1 = BC Hydro thread). The
/// Home Depot thread's latest message is a PENDING ACTION_CARD (Issue #73)
/// so the Inbox demonstrates the "Confirm & Sync" flow out of the box.
class SeedDemoMessages {
  static List<MessageEntity> forConversation(int conversationId, int index) {
    final now = DateTime.now();
    if (index == 0) {
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
    return [
      MessageEntity(
        conversationId: conversationId,
        senderId: 'vendor-bc-hydro',
        body: 'Your account details have been updated.',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
    ];
  }
}
