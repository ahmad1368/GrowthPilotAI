import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/telemetry_event_type.dart';

/// One buffered feedback event (Issue #87) — the "Edge-Scrubbed" AC is
/// satisfied by construction: there is no field here that could hold a
/// business name, user id, or exact currency amount, only a sector,
/// event type, and a pre-formatted delta label (e.g. "+15% Liquidity").
/// Buffered locally and batch-uploaded every 48h rather than sent
/// instantly, to prevent real-time behavior tracking.
@Entity()
class TelemetryEventEntity {
  @Id()
  int id = 0;

  String sectorId;
  int dbEventType;
  String deltaChangeLabel;
  String appVersion;
  int packVersion;

  @Index()
  @Property(type: PropertyType.date)
  DateTime capturedAt;

  @Index()
  bool uploaded;

  TelemetryEventEntity({
    this.id = 0,
    required this.sectorId,
    required this.dbEventType,
    required this.deltaChangeLabel,
    required this.appVersion,
    required this.packVersion,
    required this.capturedAt,
    this.uploaded = false,
  });

  TelemetryEventType get eventType => TelemetryEventType.values[dbEventType];
}
