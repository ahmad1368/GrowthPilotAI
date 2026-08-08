import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/estimate_eta_minutes.dart';

void main() {
  test('estimates ETA from distance and the default average speed', () {
    // Same latitude, ~1 degree of longitude apart at the equator is
    // roughly 111km; at 30km/h that's ~222 minutes.
    final eta = EstimateEtaMinutes.call(0, 0, 0, 1);
    expect(eta, closeTo(222, 5));
  });

  test('a slower average speed increases the ETA', () {
    final fast = EstimateEtaMinutes.call(0, 0, 0, 1, averageSpeedKmh: 60);
    final slow = EstimateEtaMinutes.call(0, 0, 0, 1, averageSpeedKmh: 15);
    expect(slow, greaterThan(fast));
  });

  test('zero distance is zero ETA', () {
    expect(EstimateEtaMinutes.call(49.28, -123.12, 49.28, -123.12), 0);
  });
}
