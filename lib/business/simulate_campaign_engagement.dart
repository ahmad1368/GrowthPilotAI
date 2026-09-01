import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';

/// Simulates campaign engagement metrics on send (Issue #407,
/// acceptance criterion 5) — this app has no email-provider webhook
/// feed, so open/click/bounce rates are derived deterministically from
/// the subject length and audience segmentation instead of live data.
class SimulateCampaignEngagement {
  static MarketingCampaignEntity call(MarketingCampaignEntity campaign) {
    final openRate =
        (0.55 - campaign.subject.length / 500).clamp(0.15, 0.55);
    final clickRate = openRate * 0.22;
    final bounceRate =
        (0.02 + (100 - campaign.minPaymentReliability) / 1000).clamp(0.01, 0.12);

    return MarketingCampaignEntity(
      id: campaign.id,
      subject: campaign.subject,
      bodyMarkup: campaign.bodyMarkup,
      segmentCategory: campaign.segmentCategory,
      segmentRegion: campaign.segmentRegion,
      minPaymentReliability: campaign.minPaymentReliability,
      dbRequiredTier: campaign.dbRequiredTier,
      dbStatus: EmailCampaignStatus.sent.index,
      scheduledAt: campaign.scheduledAt,
      createdAt: campaign.createdAt,
      openRate: openRate,
      clickRate: clickRate,
      bounceRate: bounceRate,
    );
  }
}
