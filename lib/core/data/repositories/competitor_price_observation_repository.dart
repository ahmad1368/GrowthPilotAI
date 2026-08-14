import '../../../../objectbox.g.dart';
import '../entities/competitor_price_observation_entity.dart';

/// Basic CRUD for logged competitor price observations (Issue #351),
/// mirroring [DiscountCampaignRepository]'s insert/getAll pattern.
class CompetitorPriceObservationRepository {
  final Box<CompetitorPriceObservationEntity> _box;

  CompetitorPriceObservationRepository(this._box);

  int insert(CompetitorPriceObservationEntity observation) =>
      _box.put(observation);

  List<CompetitorPriceObservationEntity> getAll() => _box.getAll();
}
