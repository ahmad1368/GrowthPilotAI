import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_roi_body.dart';

/// Registers the Historical Advertising Campaign ROI Evaluator
/// (Issue #366) as a pluggable report widget under id `AD_CAMPAIGN_ROI`
/// (#111).
class AdCampaignRoiReportWidget extends BaseReportWidget {
  const AdCampaignRoiReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AdCampaignRoiBody(
      initialCampaigns: data['campaigns'] as List<AdCampaignEntity>,
      transactions: data['transactions'] as List<TransactionEntity>,
    );
  }
}
