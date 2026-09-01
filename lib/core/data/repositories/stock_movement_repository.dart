import '../../../../objectbox.g.dart';
import '../entities/stock_movement_entity.dart';

/// Basic CRUD for stock-movement log entries (Issue #439), mirroring
/// [GoodsReceiptRepository]'s insert/getAll pattern.
class StockMovementRepository {
  final Box<StockMovementEntity> _box;

  StockMovementRepository(this._box);

  int insert(StockMovementEntity movement) => _box.put(movement);

  List<StockMovementEntity> getAll() => _box.getAll();
}
