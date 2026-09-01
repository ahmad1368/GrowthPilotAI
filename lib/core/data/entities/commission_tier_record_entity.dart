import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// One settled order's tiered-commission outcome (Issue #425,
/// acceptance criteria 1-4) — an append-only ledger like
/// [FeeWaiverRecordEntity] (#420), so the tier/rate history behind
/// every commission charge stays auditable.
@Entity()
class CommissionTierRecordEntity {
  @Id()
  int id = 0;

  @Index()
  int orderId;

  @Index()
  String merchantName;

  int cumulativeTransactionCount;
  int dbTierBand;
  double commissionRate;
  double commissionAmount;
  bool isOverridden;
  bool dependencyVerified;

  @Index()
  @Property(type: PropertyType.date)
  DateTime recordedAt;

  CommissionTierRecordEntity({
    this.id = 0,
    required this.orderId,
    required this.merchantName,
    required this.cumulativeTransactionCount,
    this.dbTierBand = 0,
    required this.commissionRate,
    required this.commissionAmount,
    this.isOverridden = false,
    required this.dependencyVerified,
    required this.recordedAt,
  });

  CommissionTierBand get tierBand => CommissionTierBand.values[dbTierBand];
  set tierBand(CommissionTierBand value) => dbTierBand = value.index;
}
