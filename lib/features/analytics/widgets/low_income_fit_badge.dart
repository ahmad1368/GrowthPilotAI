import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/consumer_behavior_insight.dart';

/// Big budget-friendly-share readout with a fit-tier label (Issue #353),
/// mirroring [AffordabilityIndexBadge]'s layout.
class LowIncomeFitBadge extends StatelessWidget {
  final ConsumerBehaviorInsight insight;

  const LowIncomeFitBadge({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (insight.fitTier) {
      LowIncomeFitTier.strong => scheme.primary,
      LowIncomeFitTier.moderate => scheme.primary,
      LowIncomeFitTier.weak => scheme.error,
    };
    final label = switch (insight.fitTier) {
      LowIncomeFitTier.strong => 'Strong fit',
      LowIncomeFitTier.moderate => 'Moderate fit',
      LowIncomeFitTier.weak => 'Weak fit',
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('${insight.budgetFriendlyShare.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('budget-friendly baskets',
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
