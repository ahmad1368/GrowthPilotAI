import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// An admin-set commission-tier override for one merchant (Issue #425,
/// acceptance criterion 5) — edited in place like
/// [MerchantConfigEntity] (#338), one record per merchant, forcing the
/// tiered engine to a specific band regardless of computed cumulative
/// volume until cleared.
@Entity()
class MerchantTierOverrideEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantName;

  int dbTierBand;

  String reason;

  @Property(type: PropertyType.date)
  DateTime setAt;

  MerchantTierOverrideEntity({
    this.id = 0,
    required this.merchantName,
    this.dbTierBand = 0,
    this.reason = '',
    required this.setAt,
  });

  CommissionTierBand get tierBand => CommissionTierBand.values[dbTierBand];
  set tierBand(CommissionTierBand value) => dbTierBand = value.index;
}
