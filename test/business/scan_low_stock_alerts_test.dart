import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/scan_low_stock_alerts.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

class _FakeChannel implements NotificationChannel {
  int pushCalls = 0;
  int inAppCalls = 0;

  @override
  OmniResult<bool> isUserOnline() async => OmniResponse.success(true);

  @override
  OmniResult<void> emitInApp(InboxNotificationEntity notification) async {
    inAppCalls++;
    return OmniResponse.success(null);
  }

  @override
  OmniResult<void> sendPush(
      InboxNotificationEntity notification, String previewBody) async {
    pushCalls++;
    return OmniResponse.success(null);
  }
}

void main() {
  test('builds one notification per low-stock item and dispatches it',
      () async {
    final channel = _FakeChannel();
    final items = [
      InventoryItemEntity(
          name: 'Flour', quantityOnHand: 3, reorderThreshold: 5, unitCost: 2.0),
      InventoryItemEntity(
          name: 'Sugar',
          quantityOnHand: 20,
          reorderThreshold: 10,
          unitCost: 1.5),
    ];

    final response = await ScanLowStockAlerts.call(items, DateTime(2026, 7, 1),
        channel: channel);

    expect(response.success, isTrue);
    expect(response.data, hasLength(1));
    expect(response.data!.single.title, contains('Flour'));
    expect(channel.pushCalls, 1);
    expect(channel.inAppCalls, 1);
  });

  test('returns no notifications when every item is above threshold', () async {
    final response = await ScanLowStockAlerts.call(
      [
        InventoryItemEntity(
            name: 'Milk',
            quantityOnHand: 50,
            reorderThreshold: 10,
            unitCost: 3.0)
      ],
      DateTime(2026, 7, 1),
    );

    expect(response.success, isTrue);
    expect(response.data, isEmpty);
  });

  test('marks notifications with high priority and alert type', () async {
    final response = await ScanLowStockAlerts.call(
      [
        InventoryItemEntity(
            name: 'Bread',
            quantityOnHand: 2,
            reorderThreshold: 5,
            unitCost: 1.2)
      ],
      DateTime(2026, 7, 1),
    );

    final notification = response.data!.single;
    expect(notification.priority, NotificationPriority.high);
    expect(notification.type, InboxNotificationType.warning);
  });
}
