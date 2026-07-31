import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_ad_campaign_roi_narrative.dart';
import 'package:growth_pilot_ai/core/models/ad_campaign_roi.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_roi_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-campaign ROI rows, a quick-add button, and a summary
/// narrative (Issue #366). Purely presentational — the campaign list is
/// owned by [AdCampaignRoiBody].
class AdCampaignRoiView extends StatelessWidget {
  final List<AdCampaignRoi> results;
  final VoidCallback onAddCampaign;

  const AdCampaignRoiView({super.key, required this.results, required this.onAddCampaign});

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
        for (final result in results) AdCampaignRoiRow(result: result),
        const SizedBox(height: 8),
        Text(BuildAdCampaignRoiNarrative.call(results)),
      ],
    );
  }
}
