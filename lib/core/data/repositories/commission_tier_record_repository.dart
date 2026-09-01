import '../../../../objectbox.g.dart';
import '../entities/commission_tier_record_entity.dart';

/// Insert/lookup CRUD for commission-tier ledger entries (Issue #425),
/// mirroring [FeeWaiverRecordRepository]'s save + lookup pattern.
class CommissionTierRecordRepository {
  final Box<CommissionTierRecordEntity> _box;

  CommissionTierRecordRepository(this._box);

  int save(CommissionTierRecordEntity record) => _box.put(record);

  List<CommissionTierRecordEntity> getAll() => _box.getAll();

  List<CommissionTierRecordEntity> forMerchant(String merchantName) =>
      getAll().where((r) => r.merchantName == merchantName).toList();

  CommissionTierRecordEntity? forOrder(int orderId) =>
      getAll().where((r) => r.orderId == orderId).firstOrNull;
}
