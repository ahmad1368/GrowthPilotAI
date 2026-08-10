import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_outlier_bounds.dart';

void main() {
  test('computes IQR fences and flags a value outside them', () {
    final bounds =
        ComputeOutlierBounds.call([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((v) => v.toDouble()).toList());

    expect(bounds.lowerBound, -4.5);
    expect(bounds.upperBound, 15.5);
    expect(bounds.isOutlier(20), isTrue);
    expect(bounds.isOutlier(5), isFalse);
  });

  test('a \$5 item in a mostly-\$100 category is flagged as an outlier', () {
    final bounds = ComputeOutlierBounds.call(
        [95, 100, 98, 102, 99, 101, 97, 5].map((v) => v.toDouble()).toList());

    expect(bounds.isOutlier(5), isTrue);
  });

  test('falls back to permissive bounds when there are too few values to trust', () {
    final bounds = ComputeOutlierBounds.call([1, 2, 3].map((v) => v.toDouble()).toList());

    expect(bounds.isOutlier(100), isFalse);
    expect(bounds.isOutlier(-5), isTrue);
  });

  test('a custom multiplier tightens the fences', () {
    final loose = ComputeOutlierBounds.call(
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((v) => v.toDouble()).toList());
    final tight = ComputeOutlierBounds.call(
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((v) => v.toDouble()).toList(),
        iqrMultiplier: 0.5);

    expect(tight.upperBound, lessThan(loose.upperBound));
  });
}
