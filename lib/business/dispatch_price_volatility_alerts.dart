import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';

/// Builds the Inbox notifications for newly-breached price alerts
/// (Issue #340, acceptance criterion 2) — this app has no push/email
/// backend, so a breach is dispatched through the existing local Inbox
/// system, the same "instant notification" channel used elsewhere
/// (Issue #71). [alreadyDispatchedIds] holds each already-notified
/// alert's [PriceVolatilityAlert.productName]+[observedAt] key so a
/// rebuild doesn't spam duplicate notifications for the same breach.
class DispatchPriceVolatilityAlerts {
  static List<InboxNotificationEntity> call(
      List<PriceVolatilityAlert> alerts, Set<String> alreadyDispatchedIds) {
    return alerts
        .where((a) => a.isBreached)
        .where((a) => !alreadyDispatchedIds.contains(_keyFor(a)))
        .map((a) => InboxNotificationEntity(
              title: 'Price volatility alert: ${a.productName}',
              body: '${a.productName} moved ${a.changePercent.abs().toStringAsFixed(1)}% '
                  '(\$${a.previousPrice.toStringAsFixed(2)} → \$${a.currentPrice.toStringAsFixed(2)}).',
              dbType: InboxNotificationType.warning.index,
              dbPriority: NotificationPriority.high.index,
              metadataRefType: 'PriceVolatility',
              metadataRefId: _keyFor(a),
              createdAt: a.observedAt,
            ))
        .toList();
  }

  static String _keyFor(PriceVolatilityAlert a) =>
      '${a.productName}|${a.observedAt.toIso8601String()}';
}
