import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_timeout_fallback_message.dart';
import 'package:growth_pilot_ai/business/is_inference_timeout.dart';
import 'package:growth_pilot_ai/business/verify_ai_response.dart';
import 'package:growth_pilot_ai/controllers/record_ai_hallucination_event.dart';
import 'package:growth_pilot_ai/controllers/record_ai_performance_metric.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Streams [reply] word-by-word (Issue #200), bails to Issue #210's
/// timeout fallback message if time-to-first-token exceeds 5s, then
/// runs Issue #203's Verification Engine against [contextAmounts] and
/// logs any resulting performance/hallucination event locally.
class ChatReplyStreamer {
  static Future<void> call(RxList<ChatMessage> messages, String messageId, String reply,
      [List<double> contextAmounts = const []]) async {
    final stopwatch = Stopwatch()..start();
    final words = reply.split(' ');
    var soFar = '';
    for (var i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      final index = messages.indexWhere((m) => m.id == messageId);
      if (i == 0 && IsInferenceTimeout.call(stopwatch.elapsedMilliseconds)) {
        if (index != -1) messages[index] = messages[index].copyWith(text: BuildTimeoutFallbackMessage.call());
        RecordAiPerformanceMetric.call(latencyMs: stopwatch.elapsedMilliseconds, isTimeout: true);
        return;
      }
      soFar = soFar.isEmpty ? words[i] : '$soFar ${words[i]}';
      if (index != -1) messages[index] = messages[index].copyWith(text: soFar);
      if (words[i].contains('\n\n') || i == words.length - 1) HapticFeedback.lightImpact();
    }
    stopwatch.stop();
    RecordAiPerformanceMetric.call(latencyMs: stopwatch.elapsedMilliseconds, isTimeout: false);

    final verification = VerifyAiResponse.call(soFar, contextAmounts);
    final finalIndex = messages.indexWhere((m) => m.id == messageId);
    if (finalIndex != -1) messages[finalIndex] = messages[finalIndex].copyWith(verification: verification);
    RecordAiHallucinationEvent.call(
        confidence: verification.overallConfidence, contextSize: contextAmounts.length);
  }
}
