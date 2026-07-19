import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

/// Builds the PENDING ACTION_CARD message (Issue #75) that surfaces a
/// [SmartRecommendation] in its conversation. Every message carries the
/// required "Data Analysis, not Certified Financial Advice" disclaimer.
class BuildRecommendationActionCardMessage {
  static const _disclaimer =
      'This is data analysis, not certified financial advice.';

  static MessageEntity call(
      SmartRecommendation recommendation, int conversationId) {
    return MessageEntity(
      conversationId: conversationId,
      senderId: 'system',
      body: '${recommendation.body}\n\n$_disclaimer',
      dbContentType: MessageContentType.actionCard.index,
      dbActionCardType: ActionCardType.smartRecommendation.index,
      dbActionCardStatus: ActionCardStatus.pending.index,
      actionCardTransactionRefId: recommendation.metadataRefId,
      actionCardActionLabel: recommendation.actionLabel,
      dbRecommendationType: recommendation.type.index,
      createdAt: DateTime.now(),
    );
  }
}
