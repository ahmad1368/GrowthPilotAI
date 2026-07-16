import '../../../../objectbox.g.dart';
import '../entities/mapping_rule_entity.dart';

/// Thin ObjectBox wrapper for Issue #57's [MappingRuleEntity] table, used by
/// the Category Mapping screen's "Always map..." toggle (Issue #58).
class MappingRuleRepository {
  final Box<MappingRuleEntity> _box;

  MappingRuleRepository(this._box);

  List<MappingRuleEntity> getAll() => _box.getAll();

  int add(MappingRuleEntity rule) => _box.put(rule);
}
