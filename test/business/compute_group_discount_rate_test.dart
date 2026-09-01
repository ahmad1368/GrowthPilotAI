import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_group_discount_rate.dart';

void main() {
  test('below threshold gets no discount', () {
    expect(ComputeGroupDiscountRate.call(80, 100), 0);
  });

  test('at exactly the threshold gets the base tier discount', () {
    expect(ComputeGroupDiscountRate.call(100, 100), 0.10);
  });

  test('1.5x the threshold gets the mid tier discount', () {
    expect(ComputeGroupDiscountRate.call(150, 100), 0.15);
  });

  test('2x or more the threshold gets the top tier discount', () {
    expect(ComputeGroupDiscountRate.call(220, 100), 0.20);
  });

  test('a zero threshold never qualifies for a discount', () {
    expect(ComputeGroupDiscountRate.call(50, 0), 0);
  });
}
