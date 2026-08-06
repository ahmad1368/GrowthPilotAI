import '../../../../objectbox.g.dart';
import '../entities/barter_proposal_entity.dart';

/// Insert-or-update CRUD for barter proposals (Issue #413), mirroring
/// [AssetBidRepository]'s upsert + lookup pattern.
class BarterProposalRepository {
  final Box<BarterProposalEntity> _box;

  BarterProposalRepository(this._box);

  int save(BarterProposalEntity proposal) => _box.put(proposal);

  List<BarterProposalEntity> getAll() => _box.getAll();

  List<BarterProposalEntity> forListing(int listingId) =>
      getAll().where((p) => p.listingId == listingId).toList();
}
