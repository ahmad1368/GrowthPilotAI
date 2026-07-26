import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/regional_affordability_result.dart';

/// Big affordability-index readout with a tier label (Issue #397), mirroring
/// [FinancialHealthScoreBadge]'s layout.
class AffordabilityIndexBadge extends StatelessWidget {
  final RegionalAffordabilityResult result;

  const AffordabilityIndexBadge({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (result.tier) {
      AffordabilityTier.underpriced => scheme.primary,
      AffordabilityTier.aligned => scheme.primary,
      AffordabilityTier.overpriced => scheme.error,
    };
    final label = switch (result.tier) {
      AffordabilityTier.underpriced => 'Underpriced',
      AffordabilityTier.aligned => 'Well-aligned',
      AffordabilityTier.overpriced => 'Overpriced',
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('${result.affordabilityIndex.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('of regional median income',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
                Text(label,
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
