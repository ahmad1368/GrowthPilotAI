import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_discount_campaign_impact_narrative.dart';
import 'package:growth_pilot_ai/core/models/discount_campaign_impact.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_impact_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-campaign impact rows, a quick-add button, and a summary
/// narrative (Issue #362). Purely presentational — the campaign list is
/// owned by [DiscountCampaignImpactBody].
class DiscountCampaignImpactView extends StatelessWidget {
  final List<DiscountCampaignImpact> results;
  final VoidCallback onAddCampaign;

  const DiscountCampaignImpactView(
      {super.key, required this.results, required this.onAddCampaign});

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
              onPressed: onAddCampaign,
              child: Text('+ Log Campaign', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) DiscountCampaignImpactRow(result: result),
        const SizedBox(height: 8),
        Text(BuildDiscountCampaignImpactNarrative.call(results)),
      ],
    );
  }
}
