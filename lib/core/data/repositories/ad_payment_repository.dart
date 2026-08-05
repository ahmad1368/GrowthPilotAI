import '../../../../objectbox.g.dart';
import '../entities/ad_payment_entity.dart';

/// Insert-or-update CRUD for ad payments (Issue #410), mirroring
/// [AdCampaignConstraintRepository]'s upsert + lookup pattern.
class AdPaymentRepository {
  final Box<AdPaymentEntity> _box;

  AdPaymentRepository(this._box);

  int save(AdPaymentEntity payment) => _box.put(payment);

  List<AdPaymentEntity> getAll() => _box.getAll();

  AdPaymentEntity? forRequest(int advertisingRequestId) {
    final matches = getAll().where((p) => p.advertisingRequestId == advertisingRequestId);
    return matches.isEmpty ? null : matches.first;
  }
}
