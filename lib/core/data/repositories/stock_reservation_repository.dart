import '../../../../objectbox.g.dart';
import '../entities/stock_reservation_entity.dart';

/// CRUD for active online-checkout stock holds (Issue #445).
class StockReservationRepository {
  final Box<StockReservationEntity> _box;

  StockReservationRepository(this._box);

  List<StockReservationEntity> getAll() => _box.getAll();

  List<StockReservationEntity> getActiveForItem(int itemId) {
    final query = _box.query(StockReservationEntity_.itemId.equals(itemId)).build();
    final active = query.find();
    query.close();
    return active;
  }
}
