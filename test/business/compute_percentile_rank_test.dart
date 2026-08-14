import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_percentile_rank.dart';

void main() {
  const peerGroup = [10.0, 20.0, 30.0, 40.0, 50.0];

  test('a middle value ranks at the 50th percentile', () {
    expect(ComputePercentileRank.call(30, peerGroup), 50);
  });

  test('the highest value accounts for ties rather than hitting 100', () {
    expect(ComputePercentileRank.call(50, peerGroup), 90);
  });

  test('a value below every peer ranks at the 0th percentile', () {
    expect(ComputePercentileRank.call(5, peerGroup), 0);
  });

  // Issue #96 "Privacy Buffer" AC: below the minimum sample size, no
  // percentile is computed at all.
  test('returns null when the peer group is smaller than the minimum', () {
    expect(ComputePercentileRank.call(30, [10, 20, 30, 40], minimumSampleSize: 5), isNull);
  });

  test('a custom minimum sample size is respected', () {
    expect(ComputePercentileRank.call(30, peerGroup, minimumSampleSize: 5), isNotNull);
    expect(ComputePercentileRank.call(30, peerGroup, minimumSampleSize: 10), isNull);
  });
}
