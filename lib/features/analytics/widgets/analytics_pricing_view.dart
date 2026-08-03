import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_analytics_pricing_narrative.dart';
import 'package:growth_pilot_ai/core/models/analytics_pricing_upgrade_alert.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-merchant pricing tier rows, a quick-add button, and a
/// summary narrative naming the latest tariff upgrade (Issue #336).
/// Purely presentational — the tier list is owned by
/// [AnalyticsPricingBody].
class AnalyticsPricingView extends StatelessWidget {
  final List<AnalyticsPricingUpgradeAlert> results;
  final VoidCallback onAddTier;

  const AnalyticsPricingView(
      {super.key, required this.results, required this.onAddTier});

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
              onPressed: onAddTier,
              child: Text('+ Assign Tier', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) AnalyticsPricingRow(result: result),
        const SizedBox(height: 8),
        Text(BuildAnalyticsPricingNarrative.call(results)),
      ],
    );
  }
}
