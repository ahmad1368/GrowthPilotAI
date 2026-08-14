import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/utils/forecast_narrative.dart';
import 'forecast_card_content.dart';
import 'forecast_empty_state.dart';
import 'window_selector_chips.dart';

/// Flat "what-if" summary card: bold projected total with window chips, a
/// privacy toggle that masks the amount, and a cross-fade on updates.
class ForecastSummaryCard extends StatefulWidget {
  final List<double> history;
  final List<double> forecast;

  const ForecastSummaryCard({
    super.key,
    required this.history,
    required this.forecast,
  });

  @override
  State<ForecastSummaryCard> createState() => _ForecastSummaryCardState();
}

class _ForecastSummaryCardState extends State<ForecastSummaryCard> {
  int _days = 7;
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
    final slice = widget.forecast.take(_days).toList();
    final total = ForecastNarrative.windowTotal(slice);
    final pct = ForecastNarrative.comparisonPct(slice, widget.history);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
            child: WindowSelectorChips(
              selected: _days,
              onChanged: (d) => setState(() => _days = d),
            ),
          ),
          IconButton(
            icon: Icon(_private ? Icons.visibility_off : Icons.visibility,
                color: fg),
            onPressed: () {
              HapticFeedback.selectionClick();
              setState(() => _private = !_private);
            },
          ),
        ]),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: ForecastCardContent(
            key: ValueKey('$_days-$_private-$total'),
            days: _days,
            total: total,
            comparisonPct: pct,
            isPrivate: _private,
          ),
        ),
      ],
    );
  }
}
