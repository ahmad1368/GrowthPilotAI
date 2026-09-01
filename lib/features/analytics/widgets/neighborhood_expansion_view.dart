import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_neighborhood_expansion_narrative.dart';
import 'package:growth_pilot_ai/core/models/neighborhood_expansion_potential.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-neighborhood expansion rows, a quick-add button, and a
/// summary narrative (Issue #372). Purely presentational — the
/// evaluation list is owned by [NeighborhoodExpansionBody].
class NeighborhoodExpansionView extends StatelessWidget {
  final List<NeighborhoodExpansionPotential> results;
  final VoidCallback onAddEvaluation;

  const NeighborhoodExpansionView(
      {super.key, required this.results, required this.onAddEvaluation});

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
              onPressed: onAddEvaluation,
              child: Text('+ Log Evaluation', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) NeighborhoodExpansionRow(result: result),
        const SizedBox(height: 8),
        Text(BuildNeighborhoodExpansionNarrative.call(results)),
      ],
    );
  }
}
