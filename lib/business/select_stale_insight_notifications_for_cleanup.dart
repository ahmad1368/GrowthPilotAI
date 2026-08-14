import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

/// "Storage" cleanup AC (Issue #108 scope item 4): read Market Insight
/// notifications older than 14 days are safe to delete — the cached
/// item itself lives on in #106's store; only its notification-history
/// entry is pruned, to prevent inbox bloat.
class SelectStaleInsightNotificationsForCleanup {
  static const retention = Duration(days: 14);

  static List<InboxNotificationEntity> call(List<InboxNotificationEntity> all, DateTime now) {
    return all
        .where((n) =>
            n.metadataRefType == 'IntelligenceItem' &&
            n.isRead &&
            now.difference(n.createdAt) >= retention)
        .toList();
  }
}
