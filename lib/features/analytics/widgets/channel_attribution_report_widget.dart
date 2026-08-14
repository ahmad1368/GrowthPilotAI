import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/aggregate_channel_attribution.dart';
import 'package:growth_pilot_ai/business/compute_ad_campaign_roi.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_attribution_view.dart';

/// Registers the Multi-Channel Marketing Acquisition Attribution Report
/// (Issue #395) as a pluggable report widget under id
/// `CHANNEL_ATTRIBUTION` (#111).
class ChannelAttributionReportWidget extends BaseReportWidget {
  const ChannelAttributionReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final campaigns = data['campaigns'] as List<AdCampaignEntity>;
    final transactions = data['transactions'] as List<TransactionEntity>;
    final campaignRois = ComputeAdCampaignRoi.call(campaigns, transactions);
    final results = AggregateChannelAttribution.call(campaignRois);
    return ChannelAttributionView(results: results);
  }
}
