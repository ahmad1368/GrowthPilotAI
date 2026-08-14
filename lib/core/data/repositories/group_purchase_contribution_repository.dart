import '../../../../objectbox.g.dart';
import '../entities/group_purchase_contribution_entity.dart';

/// Insert-or-update CRUD for group-purchase contributions (Issue
/// #414), mirroring [BarterProposalRepository]'s upsert + lookup
/// pattern.
class GroupPurchaseContributionRepository {
  final Box<GroupPurchaseContributionEntity> _box;

  GroupPurchaseContributionRepository(this._box);

  int save(GroupPurchaseContributionEntity contribution) => _box.put(contribution);

  List<GroupPurchaseContributionEntity> getAll() => _box.getAll();

  List<GroupPurchaseContributionEntity> forPurchase(int groupPurchaseId) =>
      getAll().where((c) => c.groupPurchaseId == groupPurchaseId).toList();
}
