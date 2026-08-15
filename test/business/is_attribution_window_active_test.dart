import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_attribution_window_active.dart';

void main() {
  group('IsAttributionWindowActive', () {
    final attributedAt = DateTime(2026, 1, 1, 12);

    test('true immediately after attribution', () {
      expect(IsAttributionWindowActive.call(attributedAt, attributedAt), isTrue);
    });

    test('true just under 24 hours later', () {
      final now = attributedAt.add(const Duration(hours: 23, minutes: 59));
      expect(IsAttributionWindowActive.call(attributedAt, now), isTrue);
    });

    test('false at exactly 24 hours and beyond', () {
      final now = attributedAt.add(const Duration(hours: 24));
      expect(IsAttributionWindowActive.call(attributedAt, now), isFalse);
      expect(IsAttributionWindowActive.call(attributedAt, now.add(const Duration(hours: 1))), isFalse);
    });
  });
}
