import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_sliding_scale_discount.dart';

void main() {
  test('small quantities get no discount', () {
    expect(ComputeSlidingScaleDiscount.call(5), 0.0);
  });

  test('10+ units unlocks the mid tier', () {
    expect(ComputeSlidingScaleDiscount.call(10), 0.10);
    expect(ComputeSlidingScaleDiscount.call(49), 0.10);
  });

  test('50+ units unlocks the top tier', () {
    expect(ComputeSlidingScaleDiscount.call(50), 0.20);
    expect(ComputeSlidingScaleDiscount.call(200), 0.20);
  });
}
