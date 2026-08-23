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

  // Transactional Metadata Tagging (Issue #128) — "Smart Chip" labels
  // only (e.g. "#PriceNegotiation"); category/confidence stay in-memory
  // ([ExtractMessageTags]'s output), never persisted, since the chips
  // only need the label to render.
  List<String> metadataTags;

  /// Secret Chat self-destruct timer (Issue #317 feature #2) — null means
  /// the message never expires. See [IsMessageExpired].
  @Property(type: PropertyType.date)
  DateTime? selfDestructAt;

  /// "Unsending / Deleting for Everyone Without Trace" (Issue #317
  /// feature #19) — when true, [body]/attachment fields have already
  /// been wiped by [BuildDeletedMessage]; the row survives (rather than
  /// being removed outright) so [replyToMessageId] threads and
  /// [readAt]/[metadataTags] history stay consistent.
  bool isDeleted;

  /// "Message Editing (Post-sending with edit history)" (Issue #317
  /// feature #18) — null means never edited. Only the latest [body] is
  /// kept (no full history log); see [BuildEditedMessage] PR notes.
  @Property(type: PropertyType.date)
  DateTime? editedAt;

  /// "Pinned Messages in Chats" (Issue #317 feature #22) — surfaced
  /// at the top of the room; toggled by any participant, not just the
  /// sender, since pinning is room curation rather than an ownership
  /// action (unlike edit/delete). See [ToggleMessagePin].
  bool isPinned;

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
    this.metadataTags = const [],
    this.selfDestructAt,
    this.isDeleted = false,
    this.editedAt,
    this.isPinned = false,
  });

  bool get isRead => readAt != null;
  bool get isReply => replyToMessageId != null;
  bool get hasAttachment => attachmentBytes != null;
  bool get isEdited => editedAt != null;
}
