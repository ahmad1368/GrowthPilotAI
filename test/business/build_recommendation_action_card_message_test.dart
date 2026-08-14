import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_recommendation_action_card_message.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

void main() {
  const recommendation = SmartRecommendation(
    type: RecommendationType.subscriptionAudit,
    title: 'Unused Subscription?',
    body: "You're paying \$79.99 for Adobe Creative Cloud.",
    actionLabel: 'Review Subscription',
    metadataRefId: 'sub-1',
  );

  test('builds a PENDING smartRecommendation action card', () {
    final message = BuildRecommendationActionCardMessage.call(recommendation, 7);

    expect(message.conversationId, 7);
    expect(message.dbContentType, MessageContentType.actionCard.index);
    expect(message.dbActionCardType, ActionCardType.smartRecommendation.index);
    expect(message.dbActionCardStatus, ActionCardStatus.pending.index);
    expect(message.dbRecommendationType, RecommendationType.subscriptionAudit.index);
    expect(message.actionCardActionLabel, 'Review Subscription');
    expect(message.actionCardTransactionRefId, 'sub-1');
  });

  test('appends the required non-advice disclaimer to the body', () {
    final message = BuildRecommendationActionCardMessage.call(recommendation, 7);

    expect(message.body, contains('Adobe Creative Cloud'));
    expect(message.body,
        contains('not certified financial advice'));
  });
}
