import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_financing_fee.dart';

void main() {
  test('30-day terms charge the base 3% fee rate', () {
    expect(ComputeFinancingFee.call(1000, 30), closeTo(30, 0.001));
  });

  test('60-day terms charge the higher 5% fee rate', () {
    expect(ComputeFinancingFee.call(1000, 60), closeTo(50, 0.001));
  });
}
