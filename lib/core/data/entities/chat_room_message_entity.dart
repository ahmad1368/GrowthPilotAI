import 'dart:typed_data';
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

  // Reply/Forward threading (Issue #132). [replyPreviewText] denormalizes
  // the first 50 chars of the parent so the UI never needs a lookup to
  // render the "Mini-Preview", and survives the parent being deleted.
  int? replyToMessageId;
  String? replyPreviewText;
  bool isForwarded;
  String? forwardedFromSenderId;

  // Media & Document Sharing (Issue #133) — bytes are stored directly
  // (like [ImageVariantEntity]) since no S3/GCS bucket exists locally to
  // hold the payload behind a signed URL.
  Uint8List? attachmentBytes;
  String? attachmentFileName;
  int? attachmentFileSize;
  String? attachmentMimeType;

  ChatRoomMessageEntity({
    this.id = 0,
    required this.roomId,
    required this.senderId,
    required this.body,
    required this.sentAt,
    this.readAt,
    this.replyToMessageId,
    this.replyPreviewText,
    this.isForwarded = false,
    this.forwardedFromSenderId,
    this.attachmentBytes,
    this.attachmentFileName,
    this.attachmentFileSize,
    this.attachmentMimeType,
  });

  bool get isRead => readAt != null;
  bool get isReply => replyToMessageId != null;
  bool get hasAttachment => attachmentBytes != null;
}
