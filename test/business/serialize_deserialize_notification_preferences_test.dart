import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deserialize_notification_preferences.dart';
import 'package:growth_pilot_ai/business/serialize_notification_preferences.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/enum/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/notification_preferences.dart';

void main() {
  group('SerializeNotificationPreferences / DeserializeNotificationPreferences', () {
    test('round-trips a toggled preference set', () {
      final original = NotificationPreferences.allEnabled()
          .toggled(NotificationCategory.marketing, NotificationChannel.push);

      final json = SerializeNotificationPreferences.call(original);
      final restored = DeserializeNotificationPreferences.call(json);

      expect(restored.isEnabled(NotificationCategory.marketing, NotificationChannel.push), isFalse);
      expect(restored.isEnabled(NotificationCategory.orders, NotificationChannel.push), isTrue);
    });

    test('null storage (no prior save) defaults to everything enabled', () {
      final restored = DeserializeNotificationPreferences.call(null);
      expect(restored.isEnabled(NotificationCategory.finance, NotificationChannel.email), isTrue);
    });

    test('corrupted storage falls back to everything enabled instead of crashing', () {
      final restored = DeserializeNotificationPreferences.call('not valid json');
      expect(restored.isEnabled(NotificationCategory.orders, NotificationChannel.sms), isTrue);
    });
  });
}
