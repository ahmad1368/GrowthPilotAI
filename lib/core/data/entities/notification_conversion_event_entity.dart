import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/conversion_status.dart';

/// One funnel-stage event for a dispatched alert (Issue #161) — the
/// local stand-in for the issue's `NotificationAnalytics` collection.
/// [alertId] is the originating `InboxNotificationEntity.id`; [category]
/// mirrors that notification's `metadataRefType` so rates can be grouped
/// the way the issue's "per category" AC asks for.
@Entity()
class NotificationConversionEventEntity {
  @Id()
  int id = 0;

  @Index()
  int alertId;
  String category;
  int dbStatus; // ConversionStatus index
  @Index()
  DateTime occurredAt;

  NotificationConversionEventEntity({
    this.id = 0,
    required this.alertId,
    required this.category,
    required this.dbStatus,
    required this.occurredAt,
  });

  ConversionStatus get status => ConversionStatus.values[dbStatus];
}
