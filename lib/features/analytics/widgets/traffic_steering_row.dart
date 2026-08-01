import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/traffic_steering_summary.dart';

/// One logged traffic-steering directive's row (Issue #334).
class TrafficSteeringRow extends StatelessWidget {
  final TrafficSteeringSummary result;

  const TrafficSteeringRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${result.targetName} -> ${result.destinationLabel}',
                  overflow: TextOverflow.ellipsis)),
          Text('${result.redirectCount} redirects',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${result.deviationSharePercent.toStringAsFixed(1)}%',
              style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
        ],
      ),
    );
  }
}
