import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_geo_proximity_score.dart';

void main() {
  test('scores 1.0 at zero distance', () {
    expect(ComputeGeoProximityScore.call(0), 1.0);
  });

  test('scores 0.0 at or beyond the max radius', () {
    expect(ComputeGeoProximityScore.call(25), 0.0);
    expect(ComputeGeoProximityScore.call(100), 0.0);
  });

  test('decays linearly within the radius', () {
    expect(ComputeGeoProximityScore.call(12.5), closeTo(0.5, 0.001));
  });
}
