import '../../../../objectbox.g.dart';
import '../entities/payment_entity.dart';

/// Thin ObjectBox wrapper for marketplace payments (Issue #147).
class PaymentRepository {
  final Box<PaymentEntity> _box;

  PaymentRepository(this._box);

  List<PaymentEntity> getAll() => _box.getAll();

  List<PaymentEntity> getForBusiness(String businessId) => _box
      .getAll()
      .where((p) => p.buyerId == businessId || p.sellerId == businessId)
      .toList();

  int insert(PaymentEntity payment) => _box.put(payment);
}
