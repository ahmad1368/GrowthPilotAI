import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';

/// One-sentence read summarizing how many features have an active
/// geofence zone defined (Issue #346).
class BuildGeofenceNarrative {
  static String call(List<GeofenceZoneEntity> zones) {
    if (zones.isEmpty) {
      return 'No geofence zones defined yet — add one to restrict a feature by location.';
    }
    final active = zones.where((z) => z.isEnabled).length;
    return '$active of ${zones.length} feature(s) have an active geofence zone.';
  }
}
