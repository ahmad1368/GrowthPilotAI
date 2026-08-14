import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

/// One dispatched alert (Issue #71) — e.g. a large-transaction warning or a
/// new Inbox message (Issue #70). [metadataRefId] links back to a
/// Transaction/Conversation for the "Notification History" the issue calls
/// for; the raw [body] may contain sensitive amounts and must be masked
/// before ever reaching a push preview (see SanitizePushPreview).
@Entity()
class InboxNotificationEntity {
  @Id()
  int id = 0;

  String title;
  String body;
  int dbType; // InboxNotificationType index
  int dbPriority; // NotificationPriority index
  String? metadataRefType; // 'Transaction' | 'Conversation'
  String? metadataRefId;
  @Index()
  DateTime createdAt;
  bool isRead;
  bool deliveredViaPush;

  InboxNotificationEntity({
    this.id = 0,
    required this.title,
    required this.body,
    this.dbType = 0, // InboxNotificationType.info
    this.dbPriority = 1, // NotificationPriority.normal
    this.metadataRefType,
    this.metadataRefId,
    required this.createdAt,
    this.isRead = false,
    this.deliveredViaPush = false,
  });

  InboxNotificationType get type => InboxNotificationType.values[dbType];
  NotificationPriority get priority => NotificationPriority.values[dbPriority];
  bool get isCritical =>
      priority == NotificationPriority.high ||
      priority == NotificationPriority.critical;
}
