import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

/// One message within a [ConversationEntity] (Issue #70) — the Flutter-side
/// local model for the original issue's MongoDB `messages` collection.
@Entity()
class MessageEntity {
  @Id()
  int id = 0;

  @Index()
  int conversationId;
  String senderId;
  String body;
  int dbContentType; // MessageContentType index
  @Index()
  DateTime createdAt;
  bool isRead;
  String? attachmentUrl;

  MessageEntity({
    this.id = 0,
    required this.conversationId,
    required this.senderId,
    required this.body,
    this.dbContentType = 0, // MessageContentType.text
    required this.createdAt,
    this.isRead = false,
    this.attachmentUrl,
  });

  MessageContentType get contentType => MessageContentType.values[dbContentType];
  bool get hasAttachment => attachmentUrl != null;
}
