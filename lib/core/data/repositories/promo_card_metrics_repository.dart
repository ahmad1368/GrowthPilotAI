import '../../../../objectbox.g.dart';
import '../entities/promo_card_metrics_entity.dart';

/// Insert-or-update CRUD for promo card telemetry (Issue #402),
/// mirroring [MerchantConfigRepository]'s upsert pattern.
class PromoCardMetricsRepository {
  final Box<PromoCardMetricsEntity> _box;

  PromoCardMetricsRepository(this._box);

  int save(PromoCardMetricsEntity metrics) => _box.put(metrics);

  List<PromoCardMetricsEntity> getAll() => _box.getAll();

  PromoCardMetricsEntity? forRequest(int advertisingRequestId) {
    final matches =
        getAll().where((m) => m.advertisingRequestId == advertisingRequestId);
    return matches.isEmpty ? null : matches.first;
  }
}
