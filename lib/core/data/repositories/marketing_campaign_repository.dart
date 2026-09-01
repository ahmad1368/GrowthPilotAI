import '../../../../objectbox.g.dart';
import '../entities/marketing_campaign_entity.dart';

/// Insert-or-update CRUD for marketing campaigns (Issue #407),
/// mirroring [AdvertisingRequestRepository]'s upsert pattern.
class MarketingCampaignRepository {
  final Box<MarketingCampaignEntity> _box;

  MarketingCampaignRepository(this._box);

  int save(MarketingCampaignEntity campaign) => _box.put(campaign);

  List<MarketingCampaignEntity> getAll() => _box.getAll();
}
