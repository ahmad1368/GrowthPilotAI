import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_critical_mape_error.dart';

void main() {
  group('IsCriticalMapeError', () {
    test('false at exactly the 20% threshold', () {
      expect(IsCriticalMapeError.call(20.0), isFalse);
    });

    test('true once the threshold is exceeded', () {
      expect(IsCriticalMapeError.call(20.1), isTrue);
    });

    test('false well under the threshold', () {
      expect(IsCriticalMapeError.call(5.0), isFalse);
    });
  });
}
