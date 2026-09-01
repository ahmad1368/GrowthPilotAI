import '../../../../objectbox.g.dart';
import '../entities/waste_log_entity.dart';

/// Basic CRUD for waste-log entries (Issue #377), mirroring
/// [TransactionRepository]'s insert/getAll pattern.
class WasteLogRepository {
  final Box<WasteLogEntity> _box;

  WasteLogRepository(this._box);

  int insert(WasteLogEntity entry) => _box.put(entry);

  List<WasteLogEntity> getAll() => _box.getAll();
}
