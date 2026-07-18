import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/approve_action_card.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

MessageEntity _actionCardMessage(ActionCardStatus status) => MessageEntity(
      conversationId: 1,
      senderId: 'system',
      body: 'Approve the charge',
      dbActionCardStatus: status.index,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('a PENDING card is marked COMPLETED and reports it applied', () {
    final message = _actionCardMessage(ActionCardStatus.pending);

    final applied = ApproveActionCard.call(message);

    expect(applied, isTrue);
    expect(message.dbActionCardStatus, ActionCardStatus.completed.index);
  });

  test('an already-COMPLETED card is a no-op (idempotent double-tap guard)', () {
    final message = _actionCardMessage(ActionCardStatus.completed);

    final applied = ApproveActionCard.call(message);

    expect(applied, isFalse);
    expect(message.dbActionCardStatus, ActionCardStatus.completed.index);
  });

  test('an EXPIRED card cannot be approved', () {
    final message = _actionCardMessage(ActionCardStatus.expired);

    expect(ApproveActionCard.call(message), isFalse);
  });
}
