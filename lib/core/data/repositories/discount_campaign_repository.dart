import '../../../../objectbox.g.dart';
import '../entities/discount_campaign_entity.dart';

/// Basic CRUD for logged discount campaigns (Issue #362), mirroring
/// [AdCampaignRepository]'s insert/getAll pattern.
class DiscountCampaignRepository {
  final Box<DiscountCampaignEntity> _box;

  DiscountCampaignRepository(this._box);

  int insert(DiscountCampaignEntity campaign) => _box.put(campaign);

  List<DiscountCampaignEntity> getAll() => _box.getAll();
}
