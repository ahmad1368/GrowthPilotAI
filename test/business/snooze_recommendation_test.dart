import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/snooze_recommendation.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

MessageEntity _recommendationCard(ActionCardStatus status) => MessageEntity(
      conversationId: 1,
      senderId: 'system',
      body: 'Unused subscription?',
      dbActionCardStatus: status.index,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('a PENDING card is marked SNOOZED and reports it applied', () {
    final message = _recommendationCard(ActionCardStatus.pending);

    final applied = SnoozeRecommendation.call(message);

    expect(applied, isTrue);
    expect(message.dbActionCardStatus, ActionCardStatus.snoozed.index);
  });

  test('an already-snoozed card is a no-op', () {
    final message = _recommendationCard(ActionCardStatus.snoozed);

    expect(SnoozeRecommendation.call(message), isFalse);
  });
}
