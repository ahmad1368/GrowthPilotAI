import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/ignore_anomaly_merchant.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

MessageEntity _anomalyCard(ActionCardStatus status) => MessageEntity(
      conversationId: 1,
      senderId: 'system',
      body: 'Unusual charge — please review.',
      dbActionCardStatus: status.index,
      actionCardMerchantName: 'Zenith Office Supplies',
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('a PENDING card is marked IGNORED and reports it applied', () {
    final message = _anomalyCard(ActionCardStatus.pending);

    final applied = IgnoreAnomalyMerchant.call(message);

    expect(applied, isTrue);
    expect(message.dbActionCardStatus, ActionCardStatus.ignored.index);
  });

  test('an already-IGNORED card is a no-op (idempotent double-tap guard)', () {
    final message = _anomalyCard(ActionCardStatus.ignored);

    final applied = IgnoreAnomalyMerchant.call(message);

    expect(applied, isFalse);
    expect(message.dbActionCardStatus, ActionCardStatus.ignored.index);
  });

  test('a COMPLETED card cannot be ignored', () {
    final message = _anomalyCard(ActionCardStatus.completed);

    expect(IgnoreAnomalyMerchant.call(message), isFalse);
  });
}
