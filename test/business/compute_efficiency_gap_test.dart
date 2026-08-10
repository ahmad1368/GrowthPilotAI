import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_efficiency_gap.dart';

void main() {
  test('a top price rank and closest distance yield a perfect score', () {
    expect(ComputeEfficiencyGap.call(100, 0), 100);
  });

  test('a bottom price rank and farthest distance yield the worst score', () {
    expect(ComputeEfficiencyGap.call(0, 100), 0);
  });

  test('balances price rank against inverted distance rank', () {
    // Great price (90th percentile), but far away (80th percentile distance
    // means only 20% of peers are farther): (90 + (100-80)) / 2 = 55.
    expect(ComputeEfficiencyGap.call(90, 80), 55);
  });

  test('rounds to the nearest whole score', () {
    expect(ComputeEfficiencyGap.call(85, 50), 68); // (85 + 50) / 2 = 67.5 -> 68
  });
}
