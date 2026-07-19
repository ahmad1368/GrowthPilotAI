import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/dismiss_recommendation.dart';
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
  test('a PENDING card is marked IGNORED and reports it applied', () {
    final message = _recommendationCard(ActionCardStatus.pending);

    final applied = DismissRecommendation.call(message);

    expect(applied, isTrue);
    expect(message.dbActionCardStatus, ActionCardStatus.ignored.index);
  });

  test('an already-dismissed card is a no-op', () {
    final message = _recommendationCard(ActionCardStatus.ignored);

    expect(DismissRecommendation.call(message), isFalse);
  });
}
