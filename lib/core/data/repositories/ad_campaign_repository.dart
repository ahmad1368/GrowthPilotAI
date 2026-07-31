import '../../../../objectbox.g.dart';
import '../entities/ad_campaign_entity.dart';

/// Basic CRUD for logged ad campaigns (Issue #366), mirroring
/// [WasteLogRepository]'s insert/getAll pattern.
class AdCampaignRepository {
  final Box<AdCampaignEntity> _box;

  AdCampaignRepository(this._box);

  int insert(AdCampaignEntity campaign) => _box.put(campaign);

  List<AdCampaignEntity> getAll() => _box.getAll();
}
