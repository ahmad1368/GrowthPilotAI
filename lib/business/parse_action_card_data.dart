import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';

/// Extracts the [ActionCardData] payload from a message (Issue #73) — null
/// unless the message is [MessageEntity.isActionCard].
class ParseActionCardData {
  static ActionCardData? call(MessageEntity message) {
    if (!message.isActionCard) return null;
    return ActionCardData(
      messageId: message.id,
      actionType: ActionCardType.values[message.dbActionCardType ?? 0],
      status: ActionCardStatus.values[message.dbActionCardStatus ?? 0],
      amount: message.actionCardAmount ?? 0,
      transactionRefId: message.actionCardTransactionRefId,
      merchantName: message.actionCardMerchantName,
      anomalyType: message.dbAnomalyType == null
          ? null
          : AnomalyType.values[message.dbAnomalyType!],
    );
  }
}
