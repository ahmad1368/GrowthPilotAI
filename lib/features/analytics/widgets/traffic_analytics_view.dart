import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_foot_traffic_narrative.dart';
import 'package:growth_pilot_ai/core/models/daily_traffic_analytics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_analytics_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-day traffic rows, a quick-add button, and a summary
/// narrative (Issue #381). Purely presentational — the traffic-count
/// list is owned by [TrafficAnalyticsBody].
class TrafficAnalyticsView extends StatelessWidget {
  final List<DailyTrafficAnalytics> results;
  final VoidCallback onAddCount;

  const TrafficAnalyticsView(
      {super.key, required this.results, required this.onAddCount});

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
              onPressed: onAddCount,
              child: Text('+ Log Traffic Count', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) TrafficAnalyticsRow(result: result),
        const SizedBox(height: 8),
        Text(BuildFootTrafficNarrative.call(results)),
      ],
    );
  }
}
