import 'package:growth_pilot_ai/business/build_asset_service_alert.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/asset_maintenance_input.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Scans assets for overdue maintenance and dispatches one "Service Alert"
/// per affected asset (Issue #157 scope item 3). Mirrors ScanLowStockAlerts'
/// (#440) pure-plus-optional-dispatch shape; [BuildAssetServiceAlert] holds
/// the pure overdue check.
class ScanAssetMaintenanceAlerts {
  static Future<OmniResponse<List<InboxNotificationEntity>>> call(
    List<AssetMaintenanceInput> assets,
    DateTime now, {
    NotificationChannel? channel,
  }) async {
    final notifications = <InboxNotificationEntity>[];

    for (final asset in assets) {
      final notification = BuildAssetServiceAlert.call(asset, now);
      if (notification == null) continue;
      notifications.add(notification);

      if (channel == null) continue;
      try {
        await channel.emitInApp(notification);
        await channel.sendPush(notification, notification.body);
      } catch (error, stackTrace) {
        OmniLogger.error(
          title: 'Service alert dispatch failed',
          widgetName: 'ScanAssetMaintenanceAlerts',
          message: error.toString(),
          stackTrace: stackTrace,
        );
      }
    }

    return OmniResponse.success(notifications);
  }
}
