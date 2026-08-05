import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_body.dart';

/// Registers the Marketing Campaign Studio (Issue #407) as a pluggable
/// report widget under id `MARKETING_CAMPAIGN_STUDIO` (#111).
class MarketingCampaignReportWidget extends BaseReportWidget {
  const MarketingCampaignReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MarketingCampaignBody(
      initialCampaigns:
          data['campaigns'] as List<MarketingCampaignEntity>,
    );
  }
}
