import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_available_quantity.dart';

void main() {
  test('available quantity is on-hand minus active reservations', () {
    expect(ComputeAvailableQuantity.call(10, [2, 3]), 5);
  });

  test('with no active reservations, all stock is available', () {
    expect(ComputeAvailableQuantity.call(10, []), 10);
  });

  test('reservations can fully consume the on-hand quantity', () {
    expect(ComputeAvailableQuantity.call(5, [5]), 0);
  });
}
