import '../../../../objectbox.g.dart';
import '../entities/pulse_event_entity.dart';

/// ObjectBox wrapper for OmniPulse reports (Issue #267/#268).
class PulseEventRepository {
  final Box<PulseEventEntity> _box;

  PulseEventRepository(this._box);

  /// Newest first.
  List<PulseEventEntity> getAll() => _box.getAll()..sort((a, b) => b.reportedAt.compareTo(a.reportedAt));

  int append(PulseEventEntity event) => _box.put(event);

  void markHelpful(PulseEventEntity event) {
    event.helpfulCount += 1;
    _box.put(event);
  }
}
