import '../../../../objectbox.g.dart';
import '../entities/merchant_dependency_evaluation_entity.dart';

/// Insert/lookup CRUD for dependency-evaluation ledger entries (Issue
/// #424), mirroring [FeeWaiverRecordRepository]'s save + lookup
/// pattern.
class MerchantDependencyEvaluationRepository {
  final Box<MerchantDependencyEvaluationEntity> _box;

  MerchantDependencyEvaluationRepository(this._box);

  int save(MerchantDependencyEvaluationEntity evaluation) => _box.put(evaluation);

  List<MerchantDependencyEvaluationEntity> getAll() => _box.getAll();

  List<MerchantDependencyEvaluationEntity> forMerchant(String merchantName) =>
      getAll().where((e) => e.merchantName == merchantName).toList();

  MerchantDependencyEvaluationEntity? latestForMerchant(String merchantName) {
    final all = forMerchant(merchantName);
    if (all.isEmpty) return null;
    return all.reduce((a, b) => a.evaluatedAt.isAfter(b.evaluatedAt) ? a : b);
  }
}
