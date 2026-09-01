import '../../../../objectbox.g.dart';
import '../entities/neighborhood_expansion_entity.dart';

/// Basic CRUD for logged neighborhood expansion evaluations (Issue #372),
/// mirroring [CompetitorSightingRepository]'s insert/getAll pattern.
class NeighborhoodExpansionRepository {
  final Box<NeighborhoodExpansionEntity> _box;

  NeighborhoodExpansionRepository(this._box);

  int insert(NeighborhoodExpansionEntity evaluation) => _box.put(evaluation);

  List<NeighborhoodExpansionEntity> getAll() => _box.getAll();
}
