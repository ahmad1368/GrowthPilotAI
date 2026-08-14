import '../../../../objectbox.g.dart';
import '../entities/pro_card_event_entity.dart';

/// Log of shown "Like the Pros" cards (Issue #85) — backs both the
/// weekly rate limit and the engagement feedback loop.
class ProCardEventRepository {
  final Box<ProCardEventEntity> _box;

  ProCardEventRepository(this._box);

  int save(ProCardEventEntity event) => _box.put(event);

  ProCardEventEntity? getMostRecent() {
    final all = _box.getAll();
    if (all.isEmpty) return null;
    return all.reduce((a, b) => a.shownAt.isAfter(b.shownAt) ? a : b);
  }
}
