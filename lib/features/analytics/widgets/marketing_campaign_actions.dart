import 'package:growth_pilot_ai/business/simulate_campaign_engagement.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/marketing_campaign_repository.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';

/// Persistence actions for the campaign list (Issue #407) — split out
/// of [MarketingCampaignBody] to stay under the file line cap.
class MarketingCampaignActions {
  final MarketingCampaignRepository repo;

  MarketingCampaignActions(this.repo);

  MarketingCampaignEntity clone(MarketingCampaignEntity campaign) {
    final cloned = MarketingCampaignEntity(
      subject: '${campaign.subject} (copy)',
      bodyMarkup: campaign.bodyMarkup,
      segmentCategory: campaign.segmentCategory,
      segmentRegion: campaign.segmentRegion,
      minPaymentReliability: campaign.minPaymentReliability,
      dbRequiredTier: campaign.dbRequiredTier,
      scheduledAt: DateTime.now().add(const Duration(hours: 24)),
      createdAt: DateTime.now(),
    );
    repo.save(cloned);
    return cloned;
  }

  MarketingCampaignEntity? send(MarketingCampaignEntity campaign) {
    if (campaign.status == EmailCampaignStatus.sent) return null;
    final sent = SimulateCampaignEngagement.call(campaign);
    repo.save(sent);
    return sent;
  }

  List<MarketingCampaignEntity> replaceInList(
      List<MarketingCampaignEntity> campaigns, MarketingCampaignEntity updated) {
    return [
      for (final c in campaigns)
        if (c.id != updated.id) c,
      updated,
    ];
  }
}
