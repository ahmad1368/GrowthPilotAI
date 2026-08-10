import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_dataset_too_small_for_dp.dart';

void main() {
  test('blocks a dataset below the default minimum of 5', () {
    expect(IsDatasetTooSmallForDp.call(4), isTrue);
    expect(IsDatasetTooSmallForDp.call(0), isTrue);
  });

  test('allows a dataset at or above the minimum', () {
    expect(IsDatasetTooSmallForDp.call(5), isFalse);
    expect(IsDatasetTooSmallForDp.call(100), isFalse);
  });

  test('respects a custom minimum size', () {
    expect(IsDatasetTooSmallForDp.call(8, minimumSize: 10), isTrue);
    expect(IsDatasetTooSmallForDp.call(10, minimumSize: 10), isFalse);
  });
}
