import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_competitor_proximity_narrative.dart';
import 'package:growth_pilot_ai/core/models/competitor_proximity_impact.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-sighting proximity threat rows, a quick-add button, and a
/// summary narrative (Issue #374). Purely presentational — the sighting
/// list is owned by [CompetitorProximityBody].
class CompetitorProximityView extends StatelessWidget {
  final List<CompetitorProximityImpact> results;
  final VoidCallback onAddSighting;

  const CompetitorProximityView(
      {super.key, required this.results, required this.onAddSighting});

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
              onPressed: onAddSighting,
              child: Text('+ Log Sighting', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) CompetitorProximityRow(result: result),
        const SizedBox(height: 8),
        Text(BuildCompetitorProximityNarrative.call(results)),
      ],
    );
  }
}
