import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/decide_notification_delivery.dart';
import 'package:growth_pilot_ai/core/enum/notification_delivery_channel.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

void main() {
  test('online + normal priority delivers in-app only', () {
    final channels = DecideNotificationDelivery.call(
        isOnline: true, priority: NotificationPriority.normal);
    expect(channels, {NotificationDeliveryChannel.inApp});
  });

  test('offline + normal priority falls back to push', () {
    final channels = DecideNotificationDelivery.call(
        isOnline: false, priority: NotificationPriority.normal);
    expect(channels, {NotificationDeliveryChannel.push});
  });

  test('online + critical priority delivers both channels concurrently', () {
    final channels = DecideNotificationDelivery.call(
        isOnline: true, priority: NotificationPriority.critical);
    expect(channels,
        {NotificationDeliveryChannel.inApp, NotificationDeliveryChannel.push});
  });
}
