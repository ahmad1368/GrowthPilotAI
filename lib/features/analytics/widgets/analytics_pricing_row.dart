import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/analytics_pricing_upgrade_alert.dart';

/// One logged merchant's pricing tier assignment row (Issue #336).
class AnalyticsPricingRow extends StatelessWidget {
  final AnalyticsPricingUpgradeAlert result;

  const AnalyticsPricingRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${result.merchantName} — ${result.tierName}',
                  overflow: TextOverflow.ellipsis)),
          Text('\$${result.monthlyFee.toStringAsFixed(2)}/mo',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          if (result.isUpgrade)
            Text('+${result.feeIncreasePercent.toStringAsFixed(1)}%',
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary))
          else
            Text('initial', style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
