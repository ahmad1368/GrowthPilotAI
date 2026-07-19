import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

/// One message within a [ConversationEntity] (Issue #70) — the Flutter-side
/// local model for the original issue's MongoDB `messages` collection. The
/// `actionCard*` fields carry the Issue #73 ACTION_CARD payload (plus the
/// Issue #74 anomaly-review and Issue #75 recommendation fields); parsed by
/// [ParseActionCardData] rather than exposed as typed getters here.
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
  int? dbActionCardType; // ActionCardType index
  int? dbActionCardStatus; // ActionCardStatus index
  double? actionCardAmount;
  String? actionCardTransactionRefId;
  String? actionCardMerchantName;
  int? dbAnomalyType; // AnomalyType index (Issue #74)
  int? dbRecommendationType; // RecommendationType index (Issue #75)
  String? actionCardActionLabel; // Issue #75 CTA button text

  MessageEntity({
    this.id = 0,
    required this.conversationId,
    required this.senderId,
    required this.body,
    this.dbContentType = 0, // MessageContentType.text
    required this.createdAt,
    this.isRead = false,
    this.attachmentUrl,
    this.dbActionCardType,
    this.dbActionCardStatus,
    this.actionCardAmount,
    this.actionCardTransactionRefId,
    this.actionCardMerchantName,
    this.dbAnomalyType,
    this.dbRecommendationType,
    this.actionCardActionLabel,
  });

  MessageContentType get contentType => MessageContentType.values[dbContentType];
  bool get hasAttachment => attachmentUrl != null;
  bool get isActionCard => contentType == MessageContentType.actionCard;
}
