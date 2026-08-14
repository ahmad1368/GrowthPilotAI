import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_data_reduction_percent.dart';

void main() {
  test('computes the percentage reduction', () {
    expect(ComputeDataReductionPercent.call(1000, 400), 60.0);
  });

  test('returns 0 when the optimized size is not smaller', () {
    expect(ComputeDataReductionPercent.call(1000, 1200), 0);
  });

  test('returns 0 for a non-positive original size', () {
    expect(ComputeDataReductionPercent.call(0, 100), 0);
  });
}
