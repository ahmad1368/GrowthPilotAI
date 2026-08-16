import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/ai_response_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ai_response_feedback_repository.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

/// Persists one "ai_response_feedback" event locally (Issue #209) — no
/// Firebase Analytics is integrated (see PR notes), so this is the
/// on-device buffer the issue's own "Local Buffer... sync once online"
/// AC describes; nothing syncs it to a cloud service yet.
class RecordAiFeedback {
  static void call({
    required String messageId,
    required bool isHelpful,
    FeedbackReason? reason,
    required String queryType,
    required int responseLength,
    required int inferenceTimeMs,
  }) {
    final repository = GetIt.I<AiResponseFeedbackRepository>();
    final isOffline = !Get.find<ConnectivityService>().isOnline.value;
    repository.add(AiResponseFeedbackEntity(
      messageId: messageId,
      isHelpful: isHelpful,
      dbReason: reason?.index,
      queryType: queryType,
      responseLength: responseLength,
      inferenceTimeMs: inferenceTimeMs,
      isOffline: isOffline,
      createdAt: DateTime.now(),
    ));
  }
}
