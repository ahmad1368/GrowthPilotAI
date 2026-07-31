import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/competitor_proximity_impact.dart';

/// One logged competitor sighting's proximity threat row (Issue #374).
class CompetitorProximityRow extends StatelessWidget {
  final CompetitorProximityImpact result;

  const CompetitorProximityRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child:
                  Text(result.competitorName, overflow: TextOverflow.ellipsis)),
          Text(result.category,
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${result.distanceKm.toStringAsFixed(1)}km',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            result.scale.name,
            style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
