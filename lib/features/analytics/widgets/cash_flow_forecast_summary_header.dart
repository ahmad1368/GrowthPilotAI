import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/cash_flow_projection.dart';

/// Liquidity-warning banner shown above the row list when any projected
/// month in the forecast window is a deficit (Issue #368).
class CashFlowForecastSummaryHeader extends StatelessWidget {
  final List<CashFlowProjection> projections;

  const CashFlowForecastSummaryHeader({super.key, required this.projections});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasDeficit = projections.any((p) => p.isDeficit);
    if (!hasDeficit) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text('Next ${projections.length} Months',
            style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.7))),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, size: 16, color: scheme.error),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Projected cash shortfall ahead — review upcoming expenses',
              style: TextStyle(color: scheme.error, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
