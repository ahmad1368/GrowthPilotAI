import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_traffic_steering_narrative.dart';
import 'package:growth_pilot_ai/core/models/traffic_steering_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-directive steering rows, a quick-add button, and a
/// summary narrative (Issue #334). Purely presentational — the directive
/// list is owned by [TrafficSteeringBody].
class TrafficSteeringView extends StatelessWidget {
  final List<TrafficSteeringSummary> results;
  final VoidCallback onAddDirective;

  const TrafficSteeringView(
      {super.key, required this.results, required this.onAddDirective});

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
              onPressed: onAddDirective,
              child: Text('+ Log Directive', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) TrafficSteeringRow(result: result),
        const SizedBox(height: 8),
        Text(BuildTrafficSteeringNarrative.call(results)),
      ],
    );
  }
}
