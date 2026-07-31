import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';

/// ROI read for one logged ad campaign (Issue #366).
class AdCampaignRoi {
  final String name;
  final AdChannel channel;
  final double cost;
  final double attributedRevenue;
  final int newCustomersAcquired;
  final double? costPerAcquisition;
  final double roi;
  final bool isPositiveRoi;

  const AdCampaignRoi({
    required this.name,
    required this.channel,
    required this.cost,
    required this.attributedRevenue,
    required this.newCustomersAcquired,
    required this.costPerAcquisition,
    required this.roi,
    required this.isPositiveRoi,
  });
}
