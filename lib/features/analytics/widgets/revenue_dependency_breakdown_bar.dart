import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/revenue_dependency_snapshot.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Two-segment percentage bar: repeat-buyer revenue vs one-time-buyer
/// revenue (Issue #376).
class RevenueDependencyBreakdownBar extends StatelessWidget {
  final RevenueDependencySnapshot snapshot;

  const RevenueDependencyBreakdownBar({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final repeatShare = snapshot.repeatRevenueShare.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 10,
            child: Row(
              children: [
                Expanded(
                    flex: (repeatShare * 100).round().clamp(0, 100),
                    child: Container(color: scheme.primary)),
                Expanded(
                    flex: 100 - (repeatShare * 100).round().clamp(0, 100),
                    child: Container(color: scheme.onSurface.withValues(alpha: 0.15))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${CurrencyFormat.cad(snapshot.repeatRevenue)} repeat buyers · '
          '${CurrencyFormat.cad(snapshot.oneTimeRevenue)} one-time buyers',
          style: TextStyle(
              fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}
