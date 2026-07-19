import 'package:growth_pilot_ai/business/build_recommendation_action_card_message.dart';
import 'package:growth_pilot_ai/business/detect_subscription_audit_recommendation.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';

/// The demo thread's message (Issue #75): a pre-triggered Subscription
/// Audit tip rendered as a PENDING Smart Recommendation ACTION_CARD, so the
/// Inbox demonstrates the "Dismiss"/"Snooze" flow out of the box. Split out
/// to keep [SeedDemoMessages] within the 50-line file limit.
class SeedRecommendationThreadMessages {
  static List<MessageEntity> call(int conversationId) {
    final recommendation = DetectSubscriptionAuditRecommendation.call(
      subscriptionName: 'Adobe Creative Cloud',
      amount: 79.99,
      daysSinceLastUsed: 62,
      subscriptionRefId: 'sub-adobe-cc-001',
    );
    if (recommendation == null) return const [];
    return [
      BuildRecommendationActionCardMessage.call(recommendation, conversationId)
    ];
  }
}
