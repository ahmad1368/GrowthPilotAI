import '../../../../objectbox.g.dart';
import '../entities/competitor_sighting_entity.dart';

/// Basic CRUD for logged competitor sightings (Issue #374), mirroring
/// [CompetitorPriceObservationRepository]'s insert/getAll pattern.
class CompetitorSightingRepository {
  final Box<CompetitorSightingEntity> _box;

  CompetitorSightingRepository(this._box);

  int insert(CompetitorSightingEntity sighting) => _box.put(sighting);

  List<CompetitorSightingEntity> getAll() => _box.getAll();
}
