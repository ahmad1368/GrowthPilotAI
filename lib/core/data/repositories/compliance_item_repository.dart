import '../../../../objectbox.g.dart';
import '../entities/compliance_item_entity.dart';

/// Basic CRUD for compliance/license items (Issue #392), mirroring
/// [WasteLogRepository]'s insert/getAll pattern.
class ComplianceItemRepository {
  final Box<ComplianceItemEntity> _box;

  ComplianceItemRepository(this._box);

  int insert(ComplianceItemEntity entry) => _box.put(entry);

  List<ComplianceItemEntity> getAll() => _box.getAll();
}
