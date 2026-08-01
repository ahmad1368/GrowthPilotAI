import '../../../../objectbox.g.dart';
import '../entities/traffic_steering_directive_entity.dart';

/// Basic CRUD for logged traffic-steering directives (Issue #334),
/// mirroring [MerchantBranchRepository]'s insert/getAll pattern.
class TrafficSteeringDirectiveRepository {
  final Box<TrafficSteeringDirectiveEntity> _box;

  TrafficSteeringDirectiveRepository(this._box);

  int insert(TrafficSteeringDirectiveEntity directive) => _box.put(directive);

  List<TrafficSteeringDirectiveEntity> getAll() => _box.getAll();
}
