import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_hidden_gem.dart';

void main() {
  test('a well-below-market price nearby is a hidden gem', () {
    expect(DetectHiddenGem.call(-2.0, 3.0), isTrue);
  });

  test('a below-market price that is too far away is not a hidden gem', () {
    expect(DetectHiddenGem.call(-2.0, 10.0), isFalse);
  });

  test('a nearby price that is not well below market is not a hidden gem', () {
    expect(DetectHiddenGem.call(-0.5, 3.0), isFalse);
  });

  test('respects custom thresholds', () {
    expect(DetectHiddenGem.call(-2.0, 8.0, maxDistanceKm: 10.0), isTrue);
  });
}
