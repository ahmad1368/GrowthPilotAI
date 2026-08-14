import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';

/// Builds the PENDING ACTION_CARD message (Issue #74) that surfaces a
/// [TransactionAnomaly] in its conversation, so the user can review or
/// dismiss it via the "Ignore for this Merchant" action.
class BuildAnomalyActionCardMessage {
  static MessageEntity call(TransactionAnomaly anomaly, int conversationId) {
    return MessageEntity(
      conversationId: conversationId,
      senderId: 'system',
      body: 'Unusual \$${anomaly.amount.toStringAsFixed(2)} charge at '
          '${anomaly.merchantName} — please review.',
      dbContentType: MessageContentType.actionCard.index,
      dbActionCardType: ActionCardType.reviewAnomaly.index,
      dbActionCardStatus: ActionCardStatus.pending.index,
      actionCardAmount: anomaly.amount,
      actionCardTransactionRefId: anomaly.transactionRefId,
      actionCardMerchantName: anomaly.merchantName,
      dbAnomalyType: anomaly.type.index,
      createdAt: DateTime.now(),
    );
  }
}
