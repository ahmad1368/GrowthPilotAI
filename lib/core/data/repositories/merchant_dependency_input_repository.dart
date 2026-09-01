import '../../../../objectbox.g.dart';
import '../entities/merchant_dependency_input_entity.dart';

/// Insert-or-update CRUD for per-merchant dependency inputs (Issue
/// #424), mirroring [WholesaleOrderRepository]'s upsert pattern, plus
/// a get-or-create lookup since every merchant needs exactly one
/// record before the engine can evaluate them.
class MerchantDependencyInputRepository {
  final Box<MerchantDependencyInputEntity> _box;

  MerchantDependencyInputRepository(this._box);

  int save(MerchantDependencyInputEntity input) => _box.put(input);

  List<MerchantDependencyInputEntity> getAll() => _box.getAll();

  MerchantDependencyInputEntity? forMerchant(String merchantName) =>
      getAll().where((i) => i.merchantName == merchantName).firstOrNull;

  MerchantDependencyInputEntity getOrCreate(
    String merchantName,
    DateTime defaultTrialStart,
  ) {
    final existing = forMerchant(merchantName);
    if (existing != null) return existing;
    final created = MerchantDependencyInputEntity(
      merchantName: merchantName,
      trialStartedAt: defaultTrialStart,
      updatedAt: DateTime.now(),
    );
    created.id = save(created);
    return created;
  }
}
