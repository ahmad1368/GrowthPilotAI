import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

/// Builds the Inbox notification for a daily cap breach (Issue #344,
/// acceptance criterion 2) — this app has no push/email backend, so the
/// breach is dispatched through the existing local Inbox system (Issue
/// #71), the same channel [DispatchPriceVolatilityAlerts] uses.
/// Returns null if not breached or already notified today.
class DispatchDailyCapBreachNotification {
  static InboxNotificationEntity? call(
      {required bool isBlocked,
      required double dailyTotal,
      required double capAmount,
      required DateTime day,
      required Set<String> alreadyDispatchedIds}) {
    if (!isBlocked) return null;
    final key = 'DailyCap|${day.year}-${day.month}-${day.day}';
    if (alreadyDispatchedIds.contains(key)) return null;

    return InboxNotificationEntity(
      title: 'Daily transaction cap exceeded',
      body: 'Today\'s transactions total \$${dailyTotal.toStringAsFixed(2)}, '
          'over the \$${capAmount.toStringAsFixed(2)} daily cap. New transactions are blocked.',
      dbType: InboxNotificationType.actionRequired.index,
      dbPriority: NotificationPriority.high.index,
      metadataRefType: 'DailyCap',
      metadataRefId: key,
      createdAt: day,
    );
  }
}
