import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forecast_days_input.dart';

/// [Issue #810] Top row of ForecastSummaryCard: the live days input plus
/// the privacy-mask toggle. Split out of ForecastSummaryCard to keep
/// that file under this repo's ~50-line-per-file budget.
class ForecastSummaryHeader extends StatelessWidget {
  final int days;
  final ValueChanged<int> onDaysChanged;
  final bool isPrivate;
  final VoidCallback onTogglePrivate;

  const ForecastSummaryHeader({
    super.key,
    required this.days,
    required this.onDaysChanged,
    required this.isPrivate,
    required this.onTogglePrivate,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Row(children: [
      ForecastDaysInput(days: days, onChanged: onDaysChanged),
      const Spacer(),
      IconButton(
        icon: Icon(isPrivate ? Icons.visibility_off : Icons.visibility, color: fg),
        onPressed: () {
          HapticFeedback.selectionClick();
          onTogglePrivate();
        },
      ),
    ]);
  }
}
