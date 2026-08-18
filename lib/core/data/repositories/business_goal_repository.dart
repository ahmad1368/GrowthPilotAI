import '../../../../objectbox.g.dart';
import '../entities/business_goal_entity.dart';

/// Thin ObjectBox wrapper for [BusinessGoalEntity] rows (Issue #238).
class BusinessGoalRepository {
  final Box<BusinessGoalEntity> _box;

  BusinessGoalRepository(this._box);

  List<BusinessGoalEntity> getAll() => _box.getAll();

  int upsert(BusinessGoalEntity goal) => _box.put(goal);

  void delete(int id) => _box.remove(id);
}
