import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/estimate_token_count.dart';
import 'package:growth_pilot_ai/business/parse_query_intent.dart';
import 'package:growth_pilot_ai/controllers/record_ai_feedback.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Updates the in-memory message state and persists the feedback event
/// (Issue #209) — split out to keep AiChatController focused on
/// message/session state. [queryType] is derived from #199's
/// ParseQueryIntent category over the reply text itself, since the
/// originating user question isn't threaded through here.
class ChatFeedbackRecorder {
  static void call(RxList<ChatMessage> messages, String messageId, bool isHelpful,
      {FeedbackReason? reason}) {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    final message = messages[index];
    messages[index] = message.copyWith(isHelpful: isHelpful, feedbackReason: reason);

    final intent = ParseQueryIntent.call(message.text, DateTime.now());
    RecordAiFeedback.call(
      messageId: messageId,
      isHelpful: isHelpful,
      reason: reason,
      queryType: intent.category ?? 'general',
      responseLength: EstimateTokenCount.call(message.text),
      inferenceTimeMs: DateTime.now().difference(message.createdAt).inMilliseconds,
    );
  }
}
