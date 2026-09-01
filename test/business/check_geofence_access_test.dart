import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/check_geofence_access.dart';
import 'package:growth_pilot_ai/business/compute_distance_km.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';

GeofenceZoneEntity _zone({
  String featureName = 'Marketplace',
  double centerLatitude = 49.2827,
  double centerLongitude = -123.1207,
  double radiusKm = 5,
  bool isEnabled = true,
}) =>
    GeofenceZoneEntity(
      featureName: featureName,
      centerLatitude: centerLatitude,
      centerLongitude: centerLongitude,
      radiusKm: radiusKm,
      isEnabled: isEnabled,
      updatedAt: DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeDistanceKm', () {
    test('is zero for the same point', () {
      expect(ComputeDistanceKm.call(49.2827, -123.1207, 49.2827, -123.1207), closeTo(0, 1e-9));
    });

    test('computes a plausible distance between two known cities', () {
      // Vancouver to Burnaby, roughly 10-12km apart.
      final distance = ComputeDistanceKm.call(49.2827, -123.1207, 49.2488, -122.9805);
      expect(distance, greaterThan(5));
      expect(distance, lessThan(20));
    });
  });

  group('CheckGeofenceAccess', () {
    test('allows a feature with no defined zone', () {
      expect(CheckGeofenceAccess.call(const [], 'Marketplace', 49.28, -123.12), isTrue);
    });

    test('allows a feature whose zone is disabled', () {
      final zones = [_zone(isEnabled: false)];
      expect(CheckGeofenceAccess.call(zones, 'Marketplace', 60, 60), isTrue);
    });

    test('allows a point within the radius', () {
      final zones = [_zone(radiusKm: 5)];
      expect(CheckGeofenceAccess.call(zones, 'Marketplace', 49.2827, -123.1207), isTrue);
    });

    test('blocks a point far outside the radius', () {
      final zones = [_zone(radiusKm: 5)];
      expect(CheckGeofenceAccess.call(zones, 'Marketplace', 51.0, -114.0), isFalse);
    });
  });
}
