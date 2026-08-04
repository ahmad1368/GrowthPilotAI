import '../../../../objectbox.g.dart';
import '../entities/daily_transaction_cap_entity.dart';

/// Single-row CRUD for the daily transaction cap (Issue #344), mirroring
/// [StoreProfileRepository].
class DailyTransactionCapRepository {
  final Box<DailyTransactionCapEntity> _box;

  DailyTransactionCapRepository(this._box);

  DailyTransactionCapEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? DailyTransactionCapEntity() : rows.first;
  }

  int save(DailyTransactionCapEntity cap) => _box.put(cap);
}
