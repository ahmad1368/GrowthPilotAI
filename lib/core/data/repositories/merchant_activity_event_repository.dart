import '../../../../objectbox.g.dart';
import '../entities/merchant_activity_event_entity.dart';

/// Append-only access to logged login/dashboard-visit events (Issue
/// #424), mirroring [AuditLogRepository]'s record-only pattern.
class MerchantActivityEventRepository {
  final Box<MerchantActivityEventEntity> _box;

  MerchantActivityEventRepository(this._box);

  int record(MerchantActivityEventEntity event) => _box.put(event);

  List<MerchantActivityEventEntity> getAll() => _box.getAll();

  List<MerchantActivityEventEntity> forMerchant(String merchantName) =>
      getAll().where((e) => e.merchantName == merchantName).toList();
}
