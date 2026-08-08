import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_low_stock.dart';

void main() {
  test('flags stock at or below the threshold as low', () {
    expect(IsLowStock.call(IsLowStock.threshold), isTrue);
    expect(IsLowStock.call(0), isTrue);
  });

  test('does not flag stock above the threshold', () {
    expect(IsLowStock.call(IsLowStock.threshold + 1), isFalse);
  });
}
