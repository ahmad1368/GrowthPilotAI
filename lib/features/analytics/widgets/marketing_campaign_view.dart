import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_campaign_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-campaign button, per-campaign rows, and a summary
/// narrative (Issue #407). Purely presentational.
class MarketingCampaignView extends StatelessWidget {
  final List<MarketingCampaignEntity> campaigns;
  final VoidCallback onCreate;
  final void Function(MarketingCampaignEntity) onClone;
  final void Function(MarketingCampaignEntity) onSend;

  const MarketingCampaignView({
    super.key,
    required this.campaigns,
    required this.onCreate,
    required this.onClone,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onCreate,
              child: Text('+ New Campaign', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final campaign in campaigns)
          MarketingCampaignRow(
            campaign: campaign,
            onClone: () => onClone(campaign),
            onSend: () => onSend(campaign),
          ),
        const SizedBox(height: 8),
        Text(BuildCampaignNarrative.call(campaigns)),
      ],
    );
  }
}
