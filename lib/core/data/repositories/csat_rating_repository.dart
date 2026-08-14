import '../../../../objectbox.g.dart';
import '../entities/csat_rating_entity.dart';

/// Basic CRUD for logged CSAT ratings (Issue #375), mirroring
/// [DiscountCampaignRepository]'s insert/getAll pattern.
class CsatRatingRepository {
  final Box<CsatRatingEntity> _box;

  CsatRatingRepository(this._box);

  int insert(CsatRatingEntity rating) => _box.put(rating);

  List<CsatRatingEntity> getAll() => _box.getAll();
}
