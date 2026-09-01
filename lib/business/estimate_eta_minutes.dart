import 'package:growth_pilot_ai/business/compute_distance_km.dart';

/// "ETA Calculation Engine" (Issue #155) — no Google Distance Matrix API
/// key exists, so this estimates from great-circle distance (#346's
/// [ComputeDistanceKm]) at a flat average city-driving speed instead of
/// live Highway 1 traffic data.
class EstimateEtaMinutes {
  static const defaultAverageSpeedKmh = 30.0;

  static double call(double courierLat, double courierLng, double destLat, double destLng,
      {double averageSpeedKmh = defaultAverageSpeedKmh}) {
    final distanceKm = ComputeDistanceKm.call(courierLat, courierLng, destLat, destLng);
    return (distanceKm / averageSpeedKmh) * 60;
  }
}
