import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_exchange_rate_narrative.dart';
import 'package:growth_pilot_ai/core/models/exchange_rate_impact.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-observation landed-cost impact rows, a quick-add button,
/// and a summary narrative (Issue #371). Purely presentational — the
/// observation list is owned by [ExchangeRateBody].
class ExchangeRateView extends StatelessWidget {
  final List<ExchangeRateImpact> results;
  final VoidCallback onAddObservation;

  const ExchangeRateView(
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
              child: Text('+ Log Rate Check', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) ExchangeRateRow(result: result),
        const SizedBox(height: 8),
        Text(BuildExchangeRateNarrative.call(results)),
      ],
    );
  }
}
