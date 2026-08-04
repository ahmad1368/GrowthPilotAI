import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';

/// Whether a given lat/lng is within the permitted radius for a
/// feature's geofence zone (Issue #346, acceptance criteria 2-3) — a
/// feature with no defined or a disabled zone is allowed by default,
/// mirroring [CheckModuleRouteAccess]'s reusable-guard pattern.
class CheckGeofenceAccess {
  static bool call(
      List<GeofenceZoneEntity> zones, String featureName, double lat, double lng) {
    final zone = zones.where((z) => z.featureName == featureName && z.isEnabled);
    if (zone.isEmpty) return true;
    final distanceKm = ComputeDistanceKm.call(
        zone.first.centerLatitude, zone.first.centerLongitude, lat, lng);
    return distanceKm <= zone.first.radiusKm;
  }
}
