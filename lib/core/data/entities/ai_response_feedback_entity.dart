import 'package:objectbox/objectbox.dart';

/// One "ai_response_feedback" event, persisted locally (Issue #209's
/// "Local Buffer... sync once online" AC) — no chat text is stored,
/// only metadata (AC: "Anonymity... only metadata"). No Firebase
/// Analytics integration exists yet, so nothing syncs this to a cloud
/// service (see PR notes).
@Entity()
class AiResponseFeedbackEntity {
  @Id()
  int id = 0;

  String messageId;
  bool isHelpful;
  int? dbReason; // FeedbackReason index, only set on a "down" vote
  String queryType;
  int responseLength;
  int inferenceTimeMs;
  bool isOffline;
  DateTime createdAt;

  AiResponseFeedbackEntity({
    this.id = 0,
    required this.messageId,
    required this.isHelpful,
    this.dbReason,
    required this.queryType,
    required this.responseLength,
    required this.inferenceTimeMs,
    required this.isOffline,
    required this.createdAt,
  });
}
