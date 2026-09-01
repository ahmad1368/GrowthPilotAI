import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';

/// One marketing channel's aggregated acquisition attribution read
/// (Issue #395): cost/revenue/new-buyer totals rolled up across every
/// logged campaign on that channel.
class ChannelAttributionSummary {
  final AdChannel channel;
  final int campaignCount;
  final double totalCost;
  final double totalAttributedRevenue;
  final int totalNewCustomers;
  final double? costPerAcquisition;
  final double roi;
  final bool isPositiveRoi;

  const ChannelAttributionSummary({
    required this.channel,
    required this.campaignCount,
    required this.totalCost,
    required this.totalAttributedRevenue,
    required this.totalNewCustomers,
    required this.costPerAcquisition,
    required this.roi,
    required this.isPositiveRoi,
  });
}
