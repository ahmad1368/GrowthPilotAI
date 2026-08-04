import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/check_geofence_access.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/geofence_zone_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/geofence_zone_dialog.dart';

/// Owns the geofence zone list (Issue #346), saving add/edit changes
/// immediately, and runs the manual access-validation check.
class GeofenceBody extends StatefulWidget {
  final List<GeofenceZoneEntity> initialZones;

  const GeofenceBody({super.key, required this.initialZones});

  @override
  State<GeofenceBody> createState() => _GeofenceBodyState();
}

class _GeofenceBodyState extends State<GeofenceBody> {
  late List<GeofenceZoneEntity> _zones = widget.initialZones;

  Future<void> _save({GeofenceZoneEntity? existing}) async {
    final zone = await showGeofenceZoneDialog(context, existing: existing);
    if (zone == null) return;
    final savedId = GeofenceZoneRepository(
            Get.find<ObjectBox>().store.box<GeofenceZoneEntity>())
        .save(zone);
    setState(() {
      _zones = [
        for (final z in _zones)
          if (z.id != savedId) z,
        GeofenceZoneEntity(
            id: savedId,
            featureName: zone.featureName,
            centerLatitude: zone.centerLatitude,
            centerLongitude: zone.centerLongitude,
            radiusKm: zone.radiusKm,
            isEnabled: zone.isEnabled,
            updatedAt: zone.updatedAt),
      ];
    });
  }

  String _checkAccess(String featureName, double lat, double lng) {
    final allowed = CheckGeofenceAccess.call(_zones, featureName, lat, lng);
    return allowed
        ? 'Allowed — within the permitted perimeter.'
        : 'Blocked — outside the designated perimeter for $featureName.';
  }

  @override
  Widget build(BuildContext context) {
    return GeofenceView(
      zones: _zones,
      onAddZone: () => _save(),
      onEditZone: (zone) => _save(existing: zone),
      onCheckAccess: _checkAccess,
    );
  }
}
