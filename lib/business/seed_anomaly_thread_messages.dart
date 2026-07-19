import 'package:growth_pilot_ai/business/build_anomaly_action_card_message.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';

/// The Zenith demo thread's message (Issue #74): a pre-flagged
/// [TransactionAnomaly] rendered as a PENDING anomaly-review ACTION_CARD, so
/// the Inbox demonstrates the "Ignore for this Merchant" flow out of the
/// box. Split out of [SeedDemoMessages] to keep that file within the
/// 50-line file limit.
class SeedAnomalyThreadMessages {
  static List<MessageEntity> call(int conversationId) {
    const anomaly = TransactionAnomaly(
      type: AnomalyType.zScore,
      transactionRefId: 'plaid-zenith-9012',
      merchantName: 'Zenith Office Supplies',
      amount: 2400.00,
      zScoreValue: 4.8,
    );
    return [BuildAnomalyActionCardMessage.call(anomaly, conversationId)];
  }
}
