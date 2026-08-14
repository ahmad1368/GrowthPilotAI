import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_trimmed_mean.dart';

void main() {
  test('averages a small sample without trimming (5% rounds down to 0)', () {
    expect(ComputeTrimmedMean.call([10, 20, 30]), 20);
  });

  test('excludes a high outlier ("whale") from a large enough sample', () {
    // 20 values: 19 clustered near 100, one whale at 100000. 5% of 20 = 1,
    // so exactly the top value is trimmed.
    final values = [for (var i = 0; i < 19; i++) 100.0, 100000.0];
    final withOutlier = values.reduce((a, b) => a + b) / values.length;
    final trimmed = ComputeTrimmedMean.call(values);

    expect(trimmed, 100); // whale excluded entirely
    expect(trimmed, lessThan(withOutlier));
  });

  test('returns 0 for an empty list', () {
    expect(ComputeTrimmedMean.call(const []), 0);
  });
}
