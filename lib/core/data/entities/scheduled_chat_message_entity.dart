import 'package:objectbox/objectbox.dart';

/// "Message Scheduling (Specific time or When Online)" (Issue #317
/// feature #20) — a message held here until [scheduledFor], then sent
/// through the normal [ChatRoomMessageRepository] pipeline by
/// [DispatchDueScheduledMessages] and removed. Separate from
/// [ChatRoomMessageEntity] since it isn't a sent message yet.
@Entity()
class ScheduledChatMessageEntity {
  @Id()
  int id = 0;

  @Index()
  int roomId;

  String senderId;
  String body;

  @Index()
  @Property(type: PropertyType.date)
  DateTime scheduledFor;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  ScheduledChatMessageEntity({
    this.id = 0,
    required this.roomId,
    required this.senderId,
    required this.body,
    required this.scheduledFor,
    required this.createdAt,
  });
}
