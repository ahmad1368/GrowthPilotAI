import 'package:growth_pilot_ai/business/compute_distance_km.dart';

/// "Privacy Integrity" AC (Issue #126): obfuscates precise coordinates
/// to a named neighborhood via nearest-match against a fixed Lower
/// Mainland table — the same "honest local simulation, not fake
/// geocoding" precedent as [ResolvePostalCodeToCoordinates] (#213).
class ObfuscateLocationToNeighborhood {
  static const _neighborhoods = {
    'Whalley': (lat: 49.1913, lng: -122.8490),
    'Guildford': (lat: 49.1553, lng: -122.8010),
    'Coquitlam Centre': (lat: 49.2911, lng: -122.8069),
    'Maillardville': (lat: 49.2732, lng: -122.8817),
    'Metrotown': (lat: 49.2267, lng: -122.9899),
    'Downtown Vancouver': (lat: 49.2827, lng: -123.1207),
  };

  static String call(double lat, double lng) {
    var closestName = _neighborhoods.keys.first;
    var closestDistance = double.infinity;
    for (final entry in _neighborhoods.entries) {
      final distance = ComputeDistanceKm.call(lat, lng, entry.value.lat, entry.value.lng);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestName = entry.key;
      }
    }
    return closestName;
  }
}
