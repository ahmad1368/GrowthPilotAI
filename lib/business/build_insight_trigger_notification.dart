import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

/// Sector-specific "Market Insight" alert (Issue #108 scope item 3) —
/// generalized to the sector name only, never an exact address or raw
/// price (AC: "Privacy Integrity"); [metadataRefId] links back to the
/// item so a future consumer can deep-link into the Radar Comparison
/// (#99), mirroring how a notification already links back to a
/// ChatRoom via the same field.
class BuildInsightTriggerNotification {
  static InboxNotificationEntity call(String itemId, String sectorId, DistilledContext context) {
    final reason = context.isHiddenGem ? 'a new Hidden Gem' : 'an item in the top 5% for value';
    return InboxNotificationEntity(
      title: 'Market Insight: $sectorId',
      body: 'We found $reason in your watched $sectorId listings.',
      dbType: InboxNotificationType.info.index,
      dbPriority: NotificationPriority.normal.index,
      metadataRefType: 'IntelligenceItem',
      metadataRefId: itemId,
      createdAt: DateTime.now(),
    );
  }
}
