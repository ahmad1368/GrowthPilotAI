import '../../../../objectbox.g.dart';
import '../entities/analytics_pricing_tier_entity.dart';

/// Basic CRUD for logged advanced-analytics pricing tier assignments
/// (Issue #336), mirroring [PromotionalOfferRepository]'s insert/getAll
/// pattern.
class AnalyticsPricingTierRepository {
  final Box<AnalyticsPricingTierEntity> _box;

  AnalyticsPricingTierRepository(this._box);

  int insert(AnalyticsPricingTierEntity tier) => _box.put(tier);

  List<AnalyticsPricingTierEntity> getAll() => _box.getAll();
}
