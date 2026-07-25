import 'package:flutter/material.dart';

/// Big 0-100 health-score readout with a two-tier risk label (Issue #385).
class FinancialHealthScoreBadge extends StatelessWidget {
  final int score;

  const FinancialHealthScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isHealthy = score >= 50;
    final color = isHealthy ? scheme.primary : scheme.error;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('$score',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('/ 100 Health Score',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
                Text(isHealthy ? 'Healthy' : 'At Risk',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
