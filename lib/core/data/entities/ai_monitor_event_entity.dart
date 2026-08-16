import 'package:objectbox/objectbox.dart';

/// One `ai_performance_metric` or `ai_hallucination_detected` event,
/// persisted locally (Issue #210) — no Firebase Analytics is integrated
/// (see PR notes, same decision as #209). Zero user-input/chat text is
/// stored, only operational metadata (AC: "Zero-Cloud Privacy").
@Entity()
class AiMonitorEventEntity {
  @Id()
  int id = 0;

  int dbEventType; // AiMonitorEventType index
  int? latencyMs;
  bool? isTimeout;
  String? deviceModel;
  String? errorType;
  double? confidenceScore;
  int? contextSize;
  int? availableRamMb;
  DateTime createdAt;

  AiMonitorEventEntity({
    this.id = 0,
    required this.dbEventType,
    this.latencyMs,
    this.isTimeout,
    this.deviceModel,
    this.errorType,
    this.confidenceScore,
    this.contextSize,
    this.availableRamMb,
    required this.createdAt,
  });
}
