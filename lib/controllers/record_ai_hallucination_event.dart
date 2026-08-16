import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/classify_hallucination_error_type.dart';
import 'package:growth_pilot_ai/business/compute_confidence_score.dart';
import 'package:growth_pilot_ai/core/data/entities/ai_monitor_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ai_monitor_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/ai_monitor_event_type.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

/// Logs one `ai_hallucination_detected` event locally when #203's
/// Verification Engine flags a response (Issue #210) — a no-op when
/// [confidence] is [MatchConfidence.exact] (nothing to report).
/// [contextSize] approximates "tokens in RAG context" as the count of
/// context data points, since raw context text isn't available here.
class RecordAiHallucinationEvent {
  static void call({
    required MatchConfidence confidence,
    required int contextSize,
    int? availableRamMb,
  }) {
    final errorType = ClassifyHallucinationErrorType.call(confidence);
    if (errorType == null) return;

    GetIt.I<AiMonitorEventRepository>().add(AiMonitorEventEntity(
      dbEventType: AiMonitorEventType.hallucination.index,
      errorType: errorType,
      confidenceScore: ComputeConfidenceScore.call(confidence),
      contextSize: contextSize,
      availableRamMb: availableRamMb,
      createdAt: DateTime.now(),
    ));
  }
}
