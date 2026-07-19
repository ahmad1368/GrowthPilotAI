import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_anomaly_action_card_message.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';

void main() {
  test('builds a PENDING reviewAnomaly ACTION_CARD for the conversation', () {
    const anomaly = TransactionAnomaly(
      type: AnomalyType.zScore,
      transactionRefId: 'plaid-zenith-9012',
      merchantName: 'Zenith Office Supplies',
      amount: 2400,
      zScoreValue: 4.8,
    );

    final message = BuildAnomalyActionCardMessage.call(anomaly, 3);

    expect(message.conversationId, 3);
    expect(message.contentType, MessageContentType.actionCard);
    expect(message.dbActionCardType, ActionCardType.reviewAnomaly.index);
    expect(message.dbActionCardStatus, ActionCardStatus.pending.index);
    expect(message.actionCardAmount, 2400);
    expect(message.actionCardTransactionRefId, 'plaid-zenith-9012');
    expect(message.actionCardMerchantName, 'Zenith Office Supplies');
    expect(message.dbAnomalyType, AnomalyType.zScore.index);
    expect(message.body, contains('Zenith Office Supplies'));
  });
}
