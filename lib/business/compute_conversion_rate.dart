import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/notification_conversion_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversion_status.dart';

/// % of alerts in [category] that reached [ConversionStatus.dealClosed]
/// (Issue #161 AC: "Conversion Rate (%) per notification category").
/// Zero sent alerts is defined as 0%, not a division-by-zero crash.
class ComputeConversionRate {
  static double call({
    required List<InboxNotificationEntity> sentAlerts,
    required List<NotificationConversionEventEntity> events,
    required String category,
  }) {
    final sentIds =
        sentAlerts.where((a) => a.metadataRefType == category).map((a) => a.id).toSet();
    if (sentIds.isEmpty) return 0;

    final convertedIds = events
        .where((e) => e.category == category && e.status == ConversionStatus.dealClosed)
        .map((e) => e.alertId)
        .toSet()
        .intersection(sentIds);

    return convertedIds.length / sentIds.length * 100;
  }
}
