import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/utils/forecast_narrative.dart';
import 'forecast_card_content.dart';
import 'forecast_empty_state.dart';
import 'forecast_summary_header.dart';

/// Flat "what-if" summary card: bold projected total with a live
/// days-window input, a privacy toggle that masks the amount, and a
/// cross-fade on updates. [days] is owned by the parent screen (Issue
/// #810) so the chart below shares the exact same forecast window
/// instead of the two drifting independently.
class ForecastSummaryCard extends StatefulWidget {
  final List<double> history;
  final List<double> forecast;
  final int days;
  final ValueChanged<int> onDaysChanged;

  const ForecastSummaryCard({
    super.key,
    required this.history,
    required this.forecast,
    required this.days,
    required this.onDaysChanged,
  });

  @override
  State<ForecastSummaryCard> createState() => _ForecastSummaryCardState();
}

class _ForecastSummaryCardState extends State<ForecastSummaryCard> {
  bool _private = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.colorScheme.onSurface;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: fg.withValues(alpha: 0.08)),
      ),
      child: ForecastNarrative.hasEnoughData(widget.history)
          ? _body(fg)
          : const ForecastEmptyState(),
    );
  }

  Widget _body(Color fg) {
    final slice = widget.forecast.take(widget.days).toList();
    final total = ForecastNarrative.windowTotal(slice);
    final pct = ForecastNarrative.comparisonPct(slice, widget.history);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ForecastSummaryHeader(
          days: widget.days,
          onDaysChanged: widget.onDaysChanged,
          isPrivate: _private,
          onTogglePrivate: () => setState(() => _private = !_private),
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: ForecastCardContent(
            key: ValueKey('${widget.days}-$_private-$total'),
            days: widget.days,
            total: total,
            comparisonPct: pct,
            isPrivate: _private,
          ),
        ),
      ],
    );
  }
}
