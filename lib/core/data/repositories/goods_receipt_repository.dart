import '../../../../objectbox.g.dart';
import '../entities/goods_receipt_entity.dart';

/// Basic CRUD for goods-receipt records (Issue #444), mirroring
/// [PurchaseOrderRepository]'s insert/getAll pattern.
class GoodsReceiptRepository {
  final Box<GoodsReceiptEntity> _box;

  GoodsReceiptRepository(this._box);

  int insert(GoodsReceiptEntity receipt) => _box.put(receipt);

  List<GoodsReceiptEntity> getAll() => _box.getAll();
}
