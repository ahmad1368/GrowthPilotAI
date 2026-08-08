import 'package:objectbox/objectbox.dart';

/// One message inside a [ChatRoomEntity] (Issue #122) — the local
/// equivalent of the MongoDB `messages` collection the original issue's
/// NestJS `ChatGateway.handleMessage` persists on every `sendMessage`
/// event. Named distinctly from the unrelated `ChatMessageEntity`
/// (Issue #430, on-device translation bridge) to avoid collision.
@Entity()
class ChatRoomMessageEntity {
  @Id()
  int id = 0;

  @Index()
  int roomId;

  String senderId;
  String body;

  @Property(type: PropertyType.date)
  DateTime sentAt;

  @Property(type: PropertyType.date)
  DateTime? readAt;

  ChatRoomMessageEntity({
    this.id = 0,
    required this.roomId,
    required this.senderId,
    required this.body,
    required this.sentAt,
    this.readAt,
  });

  bool get isRead => readAt != null;
}
