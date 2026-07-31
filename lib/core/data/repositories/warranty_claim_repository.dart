import '../../../../objectbox.g.dart';
import '../entities/warranty_claim_entity.dart';

/// Basic CRUD for warranty claims (Issue #389), mirroring
/// [WasteLogRepository]'s insert/getAll pattern.
class WarrantyClaimRepository {
  final Box<WarrantyClaimEntity> _box;

  WarrantyClaimRepository(this._box);

  int insert(WarrantyClaimEntity claim) => _box.put(claim);

  List<WarrantyClaimEntity> getAll() => _box.getAll();
}
