import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_mape_outlier.dart';

void main() {
  group('IsMapeOutlier', () {
    test('false at exactly the 25% threshold', () {
      expect(IsMapeOutlier.call(25.0), isFalse);
    });

    test('true once the threshold is exceeded', () {
      expect(IsMapeOutlier.call(25.1), isTrue);
    });

    test('a critical (>20%) error is not necessarily an outlier (>25%)', () {
      expect(IsMapeOutlier.call(22.0), isFalse);
    });
  });
}
