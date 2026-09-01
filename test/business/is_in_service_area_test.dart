import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_in_service_area.dart';

void main() {
  test('a Surrey-area coordinate is within the service area', () {
    expect(IsInServiceArea.call(49.19, -122.85), isTrue);
  });

  test('a coordinate far outside the Lower Mainland is rejected', () {
    expect(IsInServiceArea.call(0, 0), isFalse);
  });

  test('the bounding box edges are inclusive', () {
    expect(IsInServiceArea.call(49.00, -123.30), isTrue);
    expect(IsInServiceArea.call(49.35, -122.50), isTrue);
  });

  test('just outside the box on one axis is rejected', () {
    expect(IsInServiceArea.call(49.36, -122.85), isFalse);
  });
}
