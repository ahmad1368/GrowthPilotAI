import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_fair_price_index.dart';

void main() {
  test('a listing cheaper than the baseline scores above 1.0', () {
    expect(ComputeFairPriceIndex.call(80, 100), closeTo(1.25, 0.001));
  });

  test('a listing pricier than the baseline scores below 1.0', () {
    expect(ComputeFairPriceIndex.call(120, 100), closeTo(0.833, 0.001));
  });

  test('a listing at the baseline scores exactly 1.0', () {
    expect(ComputeFairPriceIndex.call(100, 100), 1.0);
  });

  test('a zero baseline (no telemetry) defaults to neutral 1.0', () {
    expect(ComputeFairPriceIndex.call(100, 0), 1.0);
  });
}
