import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_competitor_price_narrative.dart';
import 'package:growth_pilot_ai/core/models/competitor_price_gap.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-observation price gap rows, a quick-add button, and a
/// summary narrative (Issue #351). Purely presentational — the
/// observation list is owned by [CompetitorPriceBody].
class CompetitorPriceView extends StatelessWidget {
  final List<CompetitorPriceGap> results;
  final VoidCallback onAddObservation;

  const CompetitorPriceView(
      {super.key, required this.results, required this.onAddObservation});

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
              onPressed: onAddObservation,
              child: Text('+ Log Price Check', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) CompetitorPriceRow(result: result),
        const SizedBox(height: 8),
        Text(BuildCompetitorPriceNarrative.call(results)),
      ],
    );
  }
}
