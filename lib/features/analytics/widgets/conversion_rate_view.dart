import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_conversion_narrative.dart';
import 'package:growth_pilot_ai/core/models/conversion_rate.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/conversion_rate_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-day conversion rows, a quick-add button, and a summary
/// narrative (Issue #387). Purely presentational — the visitor-count
/// list is owned by [ConversionRateBody].
class ConversionRateView extends StatelessWidget {
  final List<ConversionRate> results;
  final VoidCallback onAddCount;

  const ConversionRateView(
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
              child: Text('+ Log Visitor Count', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) ConversionRateRow(result: result),
        const SizedBox(height: 8),
        Text(BuildConversionNarrative.call(results)),
      ],
    );
  }
}
