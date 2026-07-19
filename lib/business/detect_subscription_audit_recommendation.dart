import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

/// "Subscription Audit" trigger (Issue #75): flags an active recurring
/// charge with no related activity in over [_staleDays] days, asking
/// "Are you still using [Service Name]?"
class DetectSubscriptionAuditRecommendation {
  static const int _staleDays = 30;

  static SmartRecommendation? call({
    required String subscriptionName,
    required double amount,
    required int daysSinceLastUsed,
    required String subscriptionRefId,
  }) {
    if (daysSinceLastUsed <= _staleDays) return null;

    return SmartRecommendation(
      type: RecommendationType.subscriptionAudit,
      title: 'Unused Subscription?',
      body: "We noticed you're paying \$${amount.toStringAsFixed(2)} for "
          '$subscriptionName but haven\'t had related activity in '
          '$daysSinceLastUsed days.',
      actionLabel: 'Review Subscription',
      metadataRefId: subscriptionRefId,
    );
  }
}
