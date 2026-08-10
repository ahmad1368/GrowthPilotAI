import '../../../../objectbox.g.dart';
import '../entities/telemetry_event_entity.dart';

/// The local buffer of unuploaded feedback events (Issue #87 scope
/// item 1).
class TelemetryEventRepository {
  final Box<TelemetryEventEntity> _box;

  TelemetryEventRepository(this._box);

  int save(TelemetryEventEntity event) => _box.put(event);

  List<TelemetryEventEntity> getPendingBatch() =>
      _box.query(TelemetryEventEntity_.uploaded.equals(false)).build().find();

  void markBatchUploaded(List<TelemetryEventEntity> batch) {
    for (final event in batch) {
      event.uploaded = true;
    }
    _box.putMany(batch);
  }
}
