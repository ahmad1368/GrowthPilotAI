import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

/// "Match Notification Gateway" (Issue #145 AC: alert both parties when
/// a Match Score exceeds 0.85) — generic body, no pricing/identity
/// details, matching the "Privacy Integrity" precedent from #126/#137.
class BuildMatchNotification {
  static InboxNotificationEntity call(int listingId, DateTime now) {
    return InboxNotificationEntity(
      title: 'New match found',
      body: 'A high-confidence match was found for your request.',
      metadataRefType: 'CatalogListing',
      metadataRefId: listingId.toString(),
      createdAt: now,
    );
  }
}
