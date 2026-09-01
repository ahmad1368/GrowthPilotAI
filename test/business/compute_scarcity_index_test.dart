import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_scarcity_index.dart';

void main() {
  test('a peer group of 1 is maximally scarce', () {
    expect(ComputeScarcityIndex.call(1), 1.0);
  });

  test('a peer group of 4 has a scarcity index of 0.25', () {
    expect(ComputeScarcityIndex.call(4), 0.25);
  });

  test('a peer group of 0 is treated as maximally scarce, not infinite', () {
    expect(ComputeScarcityIndex.call(0), 1.0);
  });
}
