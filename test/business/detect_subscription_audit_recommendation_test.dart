import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_subscription_audit_recommendation.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

void main() {
  test('flags a subscription stale for more than 30 days', () {
    final rec = DetectSubscriptionAuditRecommendation.call(
      subscriptionName: 'Adobe Creative Cloud',
      amount: 79.99,
      daysSinceLastUsed: 45,
      subscriptionRefId: 'sub-1',
    );

    expect(rec, isNotNull);
    expect(rec!.type, RecommendationType.subscriptionAudit);
    expect(rec.body, contains('Adobe Creative Cloud'));
    expect(rec.metadataRefId, 'sub-1');
  });

  test('does not flag a subscription used within the last 30 days', () {
    final rec = DetectSubscriptionAuditRecommendation.call(
      subscriptionName: 'Slack',
      amount: 12.50,
      daysSinceLastUsed: 10,
      subscriptionRefId: 'sub-2',
    );

    expect(rec, isNull);
  });
}
