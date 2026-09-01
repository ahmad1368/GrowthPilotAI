import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_geofence_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_validation_field.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_zone_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-feature zone rows, an add button, the access validation
/// tester, and a summary narrative (Issue #346). Purely presentational
/// — state is owned by [GeofenceBody].
class GeofenceView extends StatelessWidget {
  final List<GeofenceZoneEntity> zones;
  final VoidCallback onAddZone;
  final ValueChanged<GeofenceZoneEntity> onEditZone;
  final String? Function(String, double, double) onCheckAccess;

  const GeofenceView({
    super.key,
    required this.zones,
    required this.onAddZone,
    required this.onEditZone,
    required this.onCheckAccess,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddZone,
              child: Text('+ Add Zone', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final zone in zones)
          GeofenceZoneRow(zone: zone, onTap: () => onEditZone(zone)),
        const SizedBox(height: 12),
        GeofenceValidationField(onCheck: onCheckAccess),
        const SizedBox(height: 8),
        Text(BuildGeofenceNarrative.call(zones)),
      ],
    );
  }
}
