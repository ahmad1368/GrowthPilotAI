import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/enum/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/notification_preferences.dart';

void main() {
  group('NotificationPreferences', () {
    test('everything is enabled by default', () {
      final prefs = NotificationPreferences.allEnabled();
      for (final category in NotificationCategory.values) {
        for (final channel in NotificationChannel.values) {
          expect(prefs.isEnabled(category, channel), isTrue);
        }
      }
    });

    test('toggled flips only the targeted category/channel pair', () {
      final prefs = NotificationPreferences.allEnabled()
          .toggled(NotificationCategory.marketing, NotificationChannel.push);

      expect(prefs.isEnabled(NotificationCategory.marketing, NotificationChannel.push), isFalse);
      expect(prefs.isEnabled(NotificationCategory.orders, NotificationChannel.push), isTrue);
      expect(prefs.isEnabled(NotificationCategory.marketing, NotificationChannel.email), isTrue);
    });

    test('toggling twice restores the original state', () {
      final prefs = NotificationPreferences.allEnabled()
          .toggled(NotificationCategory.finance, NotificationChannel.sms)
          .toggled(NotificationCategory.finance, NotificationChannel.sms);

      expect(prefs.isEnabled(NotificationCategory.finance, NotificationChannel.sms), isTrue);
    });

    test('a key missing from a restored map defaults to enabled', () {
      final prefs = NotificationPreferences.fromMap(const {'orders.push': false});

      expect(prefs.isEnabled(NotificationCategory.orders, NotificationChannel.push), isFalse);
      expect(prefs.isEnabled(NotificationCategory.finance, NotificationChannel.email), isTrue);
    });
  });
}
