import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/models/ad_campaign_roi.dart';
import 'package:growth_pilot_ai/core/models/channel_attribution_summary.dart';

/// Rolls up per-campaign ROI reads into a per-channel attribution summary
/// (Issue #395) — first-touch/last-touch/multi-touch pathway modeling from
/// the issue text is scoped out, since this app has no ad-delivery
/// telemetry to source touchpoints from; attribution here is the existing
/// campaign-window revenue match [ComputeAdCampaignRoi] already computes.
class AggregateChannelAttribution {
  static List<ChannelAttributionSummary> call(List<AdCampaignRoi> campaignRois) {
    final results = AdChannel.values.map((channel) {
      final campaigns = campaignRois.where((c) => c.channel == channel).toList();
      final totalCost = campaigns.fold<double>(0, (sum, c) => sum + c.cost);
      final totalRevenue =
          campaigns.fold<double>(0, (sum, c) => sum + c.attributedRevenue);
      final totalNewCustomers =
          campaigns.fold<int>(0, (sum, c) => sum + c.newCustomersAcquired);
      final roi = totalCost <= 0 ? 0.0 : (totalRevenue - totalCost) / totalCost;

      return ChannelAttributionSummary(
        channel: channel,
        campaignCount: campaigns.length,
        totalCost: totalCost,
        totalAttributedRevenue: totalRevenue,
        totalNewCustomers: totalNewCustomers,
        costPerAcquisition:
            totalNewCustomers > 0 ? totalCost / totalNewCustomers : null,
        roi: roi,
        isPositiveRoi: roi >= 0,
      );
    }).where((s) => s.campaignCount > 0).toList();

    results.sort((a, b) => b.roi.compareTo(a.roi));
    return results;
  }
}
