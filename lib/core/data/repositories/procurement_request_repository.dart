import '../../../../objectbox.g.dart';
import '../entities/procurement_request_entity.dart';

/// Thin ObjectBox wrapper for procurement request broadcasts (Issue #126).
class ProcurementRequestRepository {
  final Box<ProcurementRequestEntity> _box;

  ProcurementRequestRepository(this._box);

  List<ProcurementRequestEntity> getAll() => _box.getAll();

  ProcurementRequestEntity? getById(int id) => _box.get(id);

  int insert(ProcurementRequestEntity request) => _box.put(request);

  void upsertAll(List<ProcurementRequestEntity> requests) => _box.putMany(requests);
}
