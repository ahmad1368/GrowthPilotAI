import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';

/// One-sentence read summarizing campaign dispatch progress and
/// average engagement (Issue #407), mirroring
/// [BuildAdRequestNarrative]'s summary pattern.
class BuildCampaignNarrative {
  static String call(List<MarketingCampaignEntity> campaigns) {
    if (campaigns.isEmpty) {
      return 'No marketing campaigns drafted yet.';
    }
    final sent =
        campaigns.where((c) => c.status == EmailCampaignStatus.sent).toList();
    if (sent.isEmpty) {
      return '${campaigns.length} campaign(s) drafted, none sent yet.';
    }
    final avgOpenRate =
        sent.map((c) => c.openRate).reduce((a, b) => a + b) / sent.length;
    return '${sent.length} of ${campaigns.length} campaign(s) sent, averaging '
        '${(avgOpenRate * 100).toStringAsFixed(1)}% open rate.';
  }
}
