import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

/// One run of the dependency-scoring engine for one merchant (Issue
/// #424, acceptance criteria 3-5) — an append-only ledger like
/// [FeeWaiverRecordEntity] (#420) and [AnalyticsPricingTierEntity]
/// (#405), so the tier-transition history stays auditable.
@Entity()
class MerchantDependencyEvaluationEntity {
  @Id()
  int id = 0;

  @Index()
  String merchantName;

  int orderVolume;
  double dailyVisitAverage;
  bool trialCompleted;
  double inventoryLiquidationPercent;
  int dependencyScore;
  int dbDependencyTier;
  bool triggeredTierUpgrade;

  @Index()
  @Property(type: PropertyType.date)
  DateTime evaluatedAt;

  MerchantDependencyEvaluationEntity({
    this.id = 0,
    required this.merchantName,
    required this.orderVolume,
    required this.dailyVisitAverage,
    required this.trialCompleted,
    required this.inventoryLiquidationPercent,
    required this.dependencyScore,
    this.dbDependencyTier = 0,
    this.triggeredTierUpgrade = false,
    required this.evaluatedAt,
  });

  MerchantDependencyTier get tier => MerchantDependencyTier.values[dbDependencyTier];
  set tier(MerchantDependencyTier value) => dbDependencyTier = value.index;
}
