import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/daily_alert_counts.dart';

void main() {
  group('DailyAlertCounts', () {
    test('starts at zero for every category', () {
      final counts = DailyAlertCounts.empty('2026-08-14');
      expect(counts.countFor(NotificationCategory.marketing), 0);
    });

    test('incremented bumps only the targeted category', () {
      final counts = DailyAlertCounts.empty('2026-08-14')
          .incremented(NotificationCategory.marketing, '2026-08-14')
          .incremented(NotificationCategory.marketing, '2026-08-14');

      expect(counts.countFor(NotificationCategory.marketing), 2);
      expect(counts.countFor(NotificationCategory.finance), 0);
    });

    test('incrementing on a new day resets the count instead of accumulating', () {
      final yesterday = DailyAlertCounts.empty('2026-08-13')
          .incremented(NotificationCategory.marketing, '2026-08-13')
          .incremented(NotificationCategory.marketing, '2026-08-13');

      final today = yesterday.incremented(NotificationCategory.marketing, '2026-08-14');

      expect(today.date, '2026-08-14');
      expect(today.countFor(NotificationCategory.marketing), 1);
    });
  });
}
