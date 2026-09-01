import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_deliver_notification.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/quiet_hours_settings.dart';

void main() {
  group('ShouldDeliverNotification', () {
    const settings = QuietHoursSettings(
      enabled: true,
      quietStartMinutes: 22 * 60,
      quietEndMinutes: 8 * 60,
      maxDailyAlerts: 5,
    );

    test('orders always bypass Quiet Hours and the daily cap', () {
      final result = ShouldDeliverNotification.call(
        category: NotificationCategory.orders,
        nowMinutes: 23 * 60,
        settings: settings,
        countSoFarToday: 999,
      );
      expect(result, isTrue);
    });

    test('non-order categories are blocked during Quiet Hours', () {
      final result = ShouldDeliverNotification.call(
        category: NotificationCategory.marketing,
        nowMinutes: 23 * 60,
        settings: settings,
        countSoFarToday: 0,
      );
      expect(result, isFalse);
    });

    test('non-order categories are blocked once the daily cap is reached', () {
      final result = ShouldDeliverNotification.call(
        category: NotificationCategory.marketing,
        nowMinutes: 12 * 60,
        settings: settings,
        countSoFarToday: 5,
      );
      expect(result, isFalse);
    });

    test('non-order categories deliver outside Quiet Hours and under the cap', () {
      final result = ShouldDeliverNotification.call(
        category: NotificationCategory.finance,
        nowMinutes: 12 * 60,
        settings: settings,
        countSoFarToday: 2,
      );
      expect(result, isTrue);
    });

    test('a disabled Quiet Hours window only enforces the daily cap', () {
      final result = ShouldDeliverNotification.call(
        category: NotificationCategory.marketing,
        nowMinutes: 23 * 60,
        settings: settings.copyWith(enabled: false),
        countSoFarToday: 0,
      );
      expect(result, isTrue);
    });
  });
}
