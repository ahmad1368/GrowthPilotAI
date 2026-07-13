import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Flat narrative body of the forecast card: a bold projected total, a trend
/// icon, and a comparison line. Values collapse to dots when [isPrivate].
class ForecastCardContent extends StatelessWidget {
  final int days;
  final double total;
  final double comparisonPct;
  final bool isPrivate;

  const ForecastCardContent({
    super.key,
    required this.days,
    required this.total,
    required this.comparisonPct,
    required this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.colorScheme.onSurface;
    final rising = comparisonPct >= 0;
    final amount = isPrivate ? '••••••' : CurrencyFormat.cad(total);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PROJECTED · NEXT $days DAYS',
            style: theme.textTheme.labelSmall
                ?.copyWith(letterSpacing: 1.2, color: fg.withValues(alpha: 0.6))),
        const SizedBox(height: 6),
        Row(children: [
          Text(amount,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w800, color: fg)),
          const Spacer(),
          Icon(rising ? Icons.trending_up : Icons.trending_down, color: fg),
        ]),
        const SizedBox(height: 4),
        Text(
          'Estimated · ${comparisonPct.abs().toStringAsFixed(0)}% '
          '${rising ? 'higher' : 'lower'} than your recent daily average',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: fg.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}
