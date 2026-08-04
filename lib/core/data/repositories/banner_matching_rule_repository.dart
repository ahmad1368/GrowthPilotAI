import '../../../../objectbox.g.dart';
import '../entities/banner_matching_rule_entity.dart';

/// Insert-or-update CRUD for banner matching rules (Issue #403),
/// mirroring [MerchantConfigRepository]'s upsert pattern.
class BannerMatchingRuleRepository {
  final Box<BannerMatchingRuleEntity> _box;

  BannerMatchingRuleRepository(this._box);

  int save(BannerMatchingRuleEntity rule) => _box.put(rule);

  List<BannerMatchingRuleEntity> getAll() => _box.getAll();
}
