import '../../../../objectbox.g.dart';
import '../entities/price_alert_threshold_entity.dart';

/// Single-row CRUD for the price alert threshold (Issue #340): reads the
/// one existing row if present, otherwise the default, mirroring
/// [StoreProfileRepository].
class PriceAlertThresholdRepository {
  final Box<PriceAlertThresholdEntity> _box;

  PriceAlertThresholdRepository(this._box);

  PriceAlertThresholdEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? PriceAlertThresholdEntity() : rows.first;
  }

  int save(PriceAlertThresholdEntity threshold) => _box.put(threshold);
}
