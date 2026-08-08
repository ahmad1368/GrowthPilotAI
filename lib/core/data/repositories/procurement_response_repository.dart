import '../../../../objectbox.g.dart';
import '../entities/procurement_response_entity.dart';

/// Thin ObjectBox wrapper for procurement responses/quotes (Issue #126).
class ProcurementResponseRepository {
  final Box<ProcurementResponseEntity> _box;

  ProcurementResponseRepository(this._box);

  List<ProcurementResponseEntity> getForRequest(int requestId) =>
      _box.getAll().where((r) => r.requestId == requestId).toList();

  int insert(ProcurementResponseEntity response) => _box.put(response);
}
