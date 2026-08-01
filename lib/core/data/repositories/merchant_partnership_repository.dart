import '../../../../objectbox.g.dart';
import '../entities/merchant_partnership_entity.dart';

/// Basic CRUD for logged merchant partnerships (Issue #393), mirroring
/// [NeighborhoodExpansionRepository]'s insert/getAll pattern.
class MerchantPartnershipRepository {
  final Box<MerchantPartnershipEntity> _box;

  MerchantPartnershipRepository(this._box);

  int insert(MerchantPartnershipEntity partnership) => _box.put(partnership);

  List<MerchantPartnershipEntity> getAll() => _box.getAll();
}
