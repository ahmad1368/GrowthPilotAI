import '../../../../objectbox.g.dart';
import '../entities/merchant_tag_entity.dart';

/// Basic CRUD for merchant tag assignments (Issue #342), mirroring
/// [PromotionalOfferRepository]'s insert/getAll pattern. `insertAll`
/// supports bulk-tagging multiple merchants at once (acceptance
/// criterion 3).
class MerchantTagRepository {
  final Box<MerchantTagEntity> _box;

  MerchantTagRepository(this._box);

  int insert(MerchantTagEntity tag) => _box.put(tag);

  List<int> insertAll(List<MerchantTagEntity> tags) => _box.putMany(tags);

  List<MerchantTagEntity> getAll() => _box.getAll();
}
