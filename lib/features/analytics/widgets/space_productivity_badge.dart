import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/space_productivity_result.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Big revenue-per-square-foot readout (Issue #398), mirroring
/// [FinancialHealthScoreBadge]'s layout.
class SpaceProductivityBadge extends StatelessWidget {
  final SpaceProductivityResult result;

  const SpaceProductivityBadge({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(CurrencyFormat.cad(result.revenuePerSquareFoot),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: scheme.primary)),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('revenue / sq ft',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
          ),
        ),
      ],
    );
  }
}
