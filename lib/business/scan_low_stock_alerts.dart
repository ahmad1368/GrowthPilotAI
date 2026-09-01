import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Scans inventory items for low-stock conditions and dispatches a single
/// alert per affected item. Keeps the implementation pure except for the
/// optional notification channel dispatch call (Issue #440).
class ScanLowStockAlerts {
  static Future<OmniResponse<List<InboxNotificationEntity>>> call(
    List<InventoryItemEntity> items,
    DateTime now, {
    NotificationChannel? channel,
  }) async {
    final notifications = <InboxNotificationEntity>[];

    for (final item in items) {
      if (item.quantityOnHand > item.reorderThreshold) {
        continue;
      }

      final notification = InboxNotificationEntity(
        title: 'Low stock alert: ${item.name}',
        body:
            '${item.name} is at ${item.quantityOnHand} units on hand; reorder threshold is ${item.reorderThreshold}.',
        dbType: InboxNotificationType.warning.index,
        dbPriority: NotificationPriority.high.index,
        createdAt: now,
      );
      notifications.add(notification);

      if (channel == null) {
        continue;
      }

      try {
        await channel.emitInApp(notification);
        await channel.sendPush(notification, notification.body);
      } catch (error, stackTrace) {
        OmniLogger.error(
          title: 'Low-stock alert dispatch failed',
          widgetName: 'ScanLowStockAlerts',
          message: error.toString(),
          stackTrace: stackTrace,
        );
      }
    }

    return OmniResponse.success(notifications);
  }
}
