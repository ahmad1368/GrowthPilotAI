import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_send_insight_notification.dart';

void main() {
  group('ShouldSendInsightNotification', () {
    final now = DateTime(2026, 8, 13, 12);

    test('sends when no insight notification has ever been sent', () {
      expect(ShouldSendInsightNotification.call(null, now), isTrue);
    });

    test('is throttled before the 12-hour cooldown has elapsed', () {
      expect(ShouldSendInsightNotification.call(now.subtract(const Duration(hours: 11)), now), isFalse);
    });

    test('sends again once the 12-hour cooldown has elapsed', () {
      expect(ShouldSendInsightNotification.call(now.subtract(const Duration(hours: 12)), now), isTrue);
    });
  });
}
