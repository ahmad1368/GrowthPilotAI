import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/promotional_offer_performance.dart';

/// One logged promotional offer's engagement row (Issue #335).
class PromotionalOfferRow extends StatelessWidget {
  final PromotionalOfferPerformance result;

  const PromotionalOfferRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${result.offerText} (${result.targetFilter})',
                  overflow: TextOverflow.ellipsis)),
          Text('${result.openRatePercent.toStringAsFixed(1)}% opened',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${result.usageRatePercent.toStringAsFixed(1)}% used',
              style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
        ],
      ),
    );
  }
}
