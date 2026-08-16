import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/entities/ai_monitor_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ai_monitor_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/ai_monitor_event_type.dart';

/// Logs one `ai_performance_metric` event locally (Issue #210) — no
/// device-info plugin is integrated, so [deviceModel] is caller-
/// supplied and defaults to 'unknown' (same treatment #197 gave RAM).
class RecordAiPerformanceMetric {
  static void call({
    required int latencyMs,
    required bool isTimeout,
    String deviceModel = 'unknown',
  }) {
    GetIt.I<AiMonitorEventRepository>().add(AiMonitorEventEntity(
      dbEventType: AiMonitorEventType.performance.index,
      latencyMs: latencyMs,
      isTimeout: isTimeout,
      deviceModel: deviceModel,
      createdAt: DateTime.now(),
    ));
  }
}
