import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_impact_body.dart';

/// Registers the Discount Campaign Impact Analyzer (Issue #362) as a
/// pluggable report widget under id `DISCOUNT_CAMPAIGN_IMPACT` (#111).
class DiscountCampaignImpactReportWidget extends BaseReportWidget {
  const DiscountCampaignImpactReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return DiscountCampaignImpactBody(
      initialCampaigns: data['campaigns'] as List<DiscountCampaignEntity>,
      transactions: data['transactions'] as List<TransactionEntity>,
    );
  }
}
