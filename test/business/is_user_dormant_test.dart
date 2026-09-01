import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_user_dormant.dart';

void main() {
  group('IsUserDormant', () {
    test('false just under 14 days', () {
      final lastActive = DateTime(2026, 1, 1);
      final now = lastActive.add(const Duration(days: 13, hours: 23));

      expect(IsUserDormant.call(lastActive, now), isFalse);
    });

    test('true at exactly 14 days', () {
      final lastActive = DateTime(2026, 1, 1);
      final now = lastActive.add(const Duration(days: 14));

      expect(IsUserDormant.call(lastActive, now), isTrue);
    });

    test('true well past the threshold', () {
      final lastActive = DateTime(2026, 1, 1);
      final now = lastActive.add(const Duration(days: 30));

      expect(IsUserDormant.call(lastActive, now), isTrue);
    });
  });
}
