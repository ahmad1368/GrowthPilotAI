import 'package:growth_pilot_ai/core/data/entities/telemetry_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/telemetry_event_type.dart';

/// Builds one buffered feedback event (Issue #87). Pure — the caller
/// persists the result via [TelemetryEventRepository].
class RecordTelemetryEvent {
  static TelemetryEventEntity call({
    required TelemetryEventType eventType,
    required String sectorId,
    required String deltaChangeLabel,
    required String appVersion,
    required int packVersion,
    required DateTime now,
  }) {
    return TelemetryEventEntity(
      sectorId: sectorId,
      dbEventType: eventType.index,
      deltaChangeLabel: deltaChangeLabel,
      appVersion: appVersion,
      packVersion: packVersion,
      capturedAt: now,
    );
  }
}
