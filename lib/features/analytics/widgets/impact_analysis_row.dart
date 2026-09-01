import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/adjustment_impact.dart';

/// One merchant's before/after commission adjustment row (Issue #349).
class ImpactAnalysisRow extends StatelessWidget {
  final AdjustmentImpact impact;

  const ImpactAnalysisRow({super.key, required this.impact});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = impact.impactPercent >= 0 ? scheme.primary : Colors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(impact.merchantName, overflow: TextOverflow.ellipsis)),
          Text('${impact.previousRatePercent}% → ${impact.newRatePercent}%',
              style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 8),
          Text('${impact.impactPercent >= 0 ? '+' : ''}${impact.impactPercent.toStringAsFixed(1)}%',
              style: TextStyle(fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
