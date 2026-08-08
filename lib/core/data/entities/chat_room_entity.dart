import 'package:objectbox/objectbox.dart';

/// A private two-participant chat room (Issue #122, "Room-based
/// Architecture") — this app has no Socket.io/Redis gateway, so
/// messages save straight to ObjectBox; [isOtherOnline]/
/// [isOtherTyping] are user-toggled simulations standing in for real
/// presence broadcasts.
@Entity()
class ChatRoomEntity {
  @Id()
  int id = 0;

  @Index()
  String participantAId;
  @Index()
  String participantBId;
  bool isOtherOnline;
  bool isOtherTyping;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  ChatRoomEntity({
    this.id = 0,
    required this.participantAId,
    required this.participantBId,
    this.isOtherOnline = false,
    this.isOtherTyping = false,
    required this.createdAt,
  });
}
