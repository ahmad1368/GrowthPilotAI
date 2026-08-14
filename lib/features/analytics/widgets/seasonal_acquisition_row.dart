import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/seasonal_acquisition_impact.dart';

/// One holiday's new-customer acquisition and retention row (Issue #382).
class SeasonalAcquisitionRow extends StatelessWidget {
  final SeasonalAcquisitionImpact impact;

  const SeasonalAcquisitionRow({super.key, required this.impact});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(impact.holidayName, overflow: TextOverflow.ellipsis)),
          Text('${impact.newCustomersAcquired} new buyers',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${(impact.retentionRate * 100).toStringAsFixed(0)}% retained',
              style: TextStyle(color: scheme.primary)),
        ],
      ),
    );
  }
}
