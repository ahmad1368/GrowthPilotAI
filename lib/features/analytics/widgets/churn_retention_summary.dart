import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/churn_retention_snapshot.dart';

/// Retention-rate KPI line with a churn-risk badge (Issue #357).
class ChurnRetentionSummary extends StatelessWidget {
  final ChurnRetentionSnapshot snapshot;

  const ChurnRetentionSummary({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pct = (snapshot.retentionRate * 100).toStringAsFixed(0);

    return Row(
      children: [
        Text('$pct% retention',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Text(
          '${snapshot.currentPeriodCount} vs ${snapshot.previousPeriodCount} '
          'transactions',
          style: TextStyle(
              fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6)),
        ),
        const Spacer(),
        if (snapshot.isChurnRisk)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: scheme.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Churn risk',
                style: TextStyle(
                    fontSize: 11,
                    color: scheme.error,
                    fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }
}
