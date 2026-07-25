import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';

/// Vendor name with a price-trend icon and an optional "recommended" star
/// (Issue #369).
class SupplierScorecardLabel extends StatelessWidget {
  final String vendorName;
  final SpendingTrend priceTrend;
  final bool isRecommended;

  const SupplierScorecardLabel({
    super.key,
    required this.vendorName,
    required this.priceTrend,
    required this.isRecommended,
  });

  IconData get _trendIcon {
    switch (priceTrend) {
      case SpendingTrend.rising:
        return Icons.trending_up;
      case SpendingTrend.falling:
        return Icons.trending_down;
      case SpendingTrend.flat:
        return Icons.trending_flat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (isRecommended) ...[
          Icon(Icons.star_rounded, size: 14, color: scheme.primary),
          const SizedBox(width: 4),
        ],
        Flexible(child: Text(vendorName, overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 4),
        Icon(
          _trendIcon,
          size: 14,
          color: priceTrend == SpendingTrend.rising
              ? scheme.error
              : scheme.onSurface.withValues(alpha: 0.5),
        ),
      ],
    );
  }
}
