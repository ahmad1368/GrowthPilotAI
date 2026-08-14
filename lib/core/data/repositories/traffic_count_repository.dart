import '../../../../objectbox.g.dart';
import '../entities/traffic_count_entity.dart';

/// Basic CRUD for logged foot/vehicular traffic counts (Issue #381),
/// mirroring [VisitorCountRepository]'s insert/getAll pattern.
class TrafficCountRepository {
  final Box<TrafficCountEntity> _box;

  TrafficCountRepository(this._box);

  int insert(TrafficCountEntity count) => _box.put(count);

  List<TrafficCountEntity> getAll() => _box.getAll();
}
