import '../../../../objectbox.g.dart';
import '../entities/ad_campaign_constraint_entity.dart';

/// Insert-or-update CRUD for ad campaign constraints (Issue #409),
/// mirroring [PromoCardMetricsRepository]'s upsert + lookup pattern.
class AdCampaignConstraintRepository {
  final Box<AdCampaignConstraintEntity> _box;

  AdCampaignConstraintRepository(this._box);

  int save(AdCampaignConstraintEntity constraint) => _box.put(constraint);

  List<AdCampaignConstraintEntity> getAll() => _box.getAll();

  AdCampaignConstraintEntity? forRequest(int advertisingRequestId) {
    final matches =
        getAll().where((c) => c.advertisingRequestId == advertisingRequestId);
    return matches.isEmpty ? null : matches.first;
  }
}
