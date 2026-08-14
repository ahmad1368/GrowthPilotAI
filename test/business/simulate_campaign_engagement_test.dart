import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/simulate_campaign_engagement.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';

MarketingCampaignEntity _campaign({
  String subject = 'Weekend Sale',
  int minPaymentReliability = 50,
}) =>
    MarketingCampaignEntity(
      id: 1,
      subject: subject,
      bodyMarkup: 'Hello **friend**',
      segmentCategory: 'Grocery',
      segmentRegion: '',
      minPaymentReliability: minPaymentReliability,
      dbRequiredTier: 0,
      scheduledAt: DateTime(2026, 1, 1),
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('sending a draft marks it sent and derives non-zero engagement metrics', () {
    final result = SimulateCampaignEngagement.call(_campaign());

    expect(result.status, EmailCampaignStatus.sent);
    expect(result.openRate, greaterThan(0));
    expect(result.clickRate, greaterThan(0));
    expect(result.bounceRate, greaterThan(0));
  });

  test('click rate is always a fixed fraction of the open rate', () {
    final result = SimulateCampaignEngagement.call(_campaign());

    expect(result.clickRate, closeTo(result.openRate * 0.22, 0.0001));
  });

  test('a lower payment reliability yields a higher bounce rate', () {
    final reliable = SimulateCampaignEngagement.call(_campaign(minPaymentReliability: 90));
    final unreliable = SimulateCampaignEngagement.call(_campaign(minPaymentReliability: 10));

    expect(unreliable.bounceRate, greaterThan(reliable.bounceRate));
  });

  test('the campaign identity fields are preserved after sending', () {
    final result = SimulateCampaignEngagement.call(_campaign(subject: 'Flash Sale'));

    expect(result.id, 1);
    expect(result.subject, 'Flash Sale');
  });
}
