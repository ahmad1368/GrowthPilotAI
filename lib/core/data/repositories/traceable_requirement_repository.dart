import '../../../../objectbox.g.dart';
import '../entities/traceable_requirement_entity.dart';

/// Thin ObjectBox wrapper for [TraceableRequirementEntity] rows (Issue
/// #238).
class TraceableRequirementRepository {
  final Box<TraceableRequirementEntity> _box;

  TraceableRequirementRepository(this._box);

  List<TraceableRequirementEntity> getAll() => _box.getAll();

  int upsert(TraceableRequirementEntity requirement) => _box.put(requirement);
}
