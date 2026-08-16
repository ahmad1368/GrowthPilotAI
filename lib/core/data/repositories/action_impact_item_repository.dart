import '../../../../objectbox.g.dart';
import '../entities/action_impact_item_entity.dart';

/// Thin ObjectBox wrapper for [ActionImpactItemEntity] rows (Issue #260).
class ActionImpactItemRepository {
  final Box<ActionImpactItemEntity> _box;

  ActionImpactItemRepository(this._box);

  List<ActionImpactItemEntity> getAll() => _box.getAll();

  void upsert(ActionImpactItemEntity item) => _box.put(item);
}
