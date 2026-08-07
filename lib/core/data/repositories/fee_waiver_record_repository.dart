import '../../../../objectbox.g.dart';
import '../entities/fee_waiver_record_entity.dart';

/// Insert/lookup CRUD for fee-waiver records (Issue #420), mirroring
/// [RecommendationFeedbackRepository]'s upsert + lookup pattern.
class FeeWaiverRecordRepository {
  final Box<FeeWaiverRecordEntity> _box;

  FeeWaiverRecordRepository(this._box);

  int save(FeeWaiverRecordEntity record) => _box.put(record);

  List<FeeWaiverRecordEntity> getAll() => _box.getAll();

  List<FeeWaiverRecordEntity> forMerchant(String merchantName) =>
      getAll().where((r) => r.merchantName == merchantName).toList();

  bool hasWaiverFor(String merchantName) =>
      forMerchant(merchantName).any((r) => r.isWaived);
}
