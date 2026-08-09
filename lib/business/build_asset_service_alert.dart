import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/asset_maintenance_input.dart';

/// Pure: whether [asset] is overdue for service, and the notification to
/// raise if so (Issue #157 scope item 3). No overdue asset → null.
class BuildAssetServiceAlert {
  static InboxNotificationEntity? call(AssetMaintenanceInput asset, DateTime now) {
    final last = asset.lastServiceDate;
    final overdue =
        last == null || now.difference(last).inDays >= asset.serviceIntervalDays;
    if (!overdue) return null;

    return InboxNotificationEntity(
      title: 'Service alert: ${asset.itemName}',
      body: last == null
          ? '${asset.itemName} has no recorded service history.'
          : '${asset.itemName} is overdue for service (last serviced ${last.toIso8601String()}).',
      dbType: InboxNotificationType.warning.index,
      dbPriority: NotificationPriority.high.index,
      createdAt: now,
    );
  }
}
