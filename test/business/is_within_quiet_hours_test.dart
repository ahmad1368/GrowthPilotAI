import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_within_quiet_hours.dart';

void main() {
  group('IsWithinQuietHours', () {
    test('true inside a same-day window', () {
      expect(IsWithinQuietHours.call(13 * 60, 12 * 60, 14 * 60), isTrue);
    });

    test('false outside a same-day window', () {
      expect(IsWithinQuietHours.call(15 * 60, 12 * 60, 14 * 60), isFalse);
    });

    test('true inside a window spanning midnight', () {
      expect(IsWithinQuietHours.call(23 * 60, 22 * 60, 8 * 60), isTrue);
      expect(IsWithinQuietHours.call(2 * 60, 22 * 60, 8 * 60), isTrue);
    });

    test('false outside a window spanning midnight', () {
      expect(IsWithinQuietHours.call(12 * 60, 22 * 60, 8 * 60), isFalse);
    });

    test('a zero-width window (start == end) is treated as disabled', () {
      expect(IsWithinQuietHours.call(0, 10 * 60, 10 * 60), isFalse);
    });
  });
}
