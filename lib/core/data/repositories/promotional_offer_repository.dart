import '../../../../objectbox.g.dart';
import '../entities/promotional_offer_entity.dart';

/// Basic CRUD for logged promotional offer dispatches (Issue #335),
/// mirroring [TrafficSteeringDirectiveRepository]'s insert/getAll pattern.
class PromotionalOfferRepository {
  final Box<PromotionalOfferEntity> _box;

  PromotionalOfferRepository(this._box);

  int insert(PromotionalOfferEntity offer) => _box.put(offer);

  List<PromotionalOfferEntity> getAll() => _box.getAll();
}
