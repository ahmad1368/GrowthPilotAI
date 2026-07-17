import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/notification_rate_limiter.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

InboxNotificationEntity _notification(DateTime createdAt) =>
    InboxNotificationEntity(title: 't', body: 'b', createdAt: createdAt);

void main() {
  final now = DateTime(2026, 1, 1, 12);

  test('allows a 6th non-critical alert only after the hourly cap', () {
    final history =
        List.generate(5, (i) => _notification(now.subtract(const Duration(minutes: 10))));
    expect(NotificationRateLimiter.allows(history, NotificationPriority.normal, now),
        isFalse);
  });

  test('allows non-critical alerts below the cap', () {
    final history =
        List.generate(4, (i) => _notification(now.subtract(const Duration(minutes: 10))));
    expect(NotificationRateLimiter.allows(history, NotificationPriority.normal, now),
        isTrue);
  });

  test('ignores alerts older than an hour when counting', () {
    final history =
        List.generate(5, (i) => _notification(now.subtract(const Duration(hours: 2))));
    expect(NotificationRateLimiter.allows(history, NotificationPriority.normal, now),
        isTrue);
  });

  test('never throttles a critical alert regardless of recent volume', () {
    final history =
        List.generate(10, (i) => _notification(now.subtract(const Duration(minutes: 1))));
    expect(NotificationRateLimiter.allows(history, NotificationPriority.critical, now),
        isTrue);
  });
}
