import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/dismiss_recommendation.dart';
import 'package:growth_pilot_ai/business/snooze_recommendation.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/recommendation_log_repository.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

/// Extracted from [InboxController] (Issue #75) to keep that file within
/// the 50-line limit: tracks in-flight Dismiss/Snooze/Act taps on a Smart
/// Recommendation card — mirrors [AnomalyIgnoreHandler].
class SmartRecommendationHandler {
  final MessageRepository _messages;
  final RecommendationLogRepository _log;
  final _processingConversationIds = <int>{}.obs;

  SmartRecommendationHandler(this._messages, this._log);

  bool isProcessing(int conversationId) =>
      _processingConversationIds.contains(conversationId);

  Future<void> dismiss(int conversationId, int messageId) =>
      _apply(conversationId, messageId, DismissRecommendation.call);

  Future<void> snooze(int conversationId, int messageId) =>
      _apply(conversationId, messageId, SnoozeRecommendation.call);

  /// The user tapped the card's primary CTA — record the conversion, but
  /// leave the card PENDING (viewing a report isn't a resolution).
  Future<void> act(RecommendationType type) async {
    _log.markMostRecentActedOn(type);
  }

  Future<void> _apply(
    int conversationId,
    int messageId,
    bool Function(MessageEntity) mutate,
  ) async {
    if (_processingConversationIds.contains(conversationId)) return;
    _processingConversationIds.add(conversationId);
    await Future.delayed(const Duration(milliseconds: 500));
    final message = _messages
        .getForConversation(conversationId)
        .firstWhere((m) => m.id == messageId);
    if (mutate(message)) {
      _messages.upsert(message);
    }
    _processingConversationIds.remove(conversationId);
  }
}
