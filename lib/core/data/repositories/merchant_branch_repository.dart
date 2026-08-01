import '../../../../objectbox.g.dart';
import '../entities/merchant_branch_entity.dart';

/// Basic CRUD for logged supervised-branch snapshots (Issue #400),
/// mirroring [NeighborhoodExpansionRepository]'s insert/getAll pattern.
class MerchantBranchRepository {
  final Box<MerchantBranchEntity> _box;

  MerchantBranchRepository(this._box);

  int insert(MerchantBranchEntity branch) => _box.put(branch);

  List<MerchantBranchEntity> getAll() => _box.getAll();
}
