import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';

/// One feature's geofence zone row (Issue #346). Tapping opens its edit
/// dialog for direct radius/center editing.
class GeofenceZoneRow extends StatelessWidget {
  final GeofenceZoneEntity zone;
  final VoidCallback onTap;

  const GeofenceZoneRow({super.key, required this.zone, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text('${zone.featureName} — ${zone.radiusKm.toStringAsFixed(1)} km radius',
                    overflow: TextOverflow.ellipsis)),
            Text(zone.isEnabled ? 'Enabled' : 'Disabled',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: zone.isEnabled ? scheme.primary : scheme.onSurface.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}
