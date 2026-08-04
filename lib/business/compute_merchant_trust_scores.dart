import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_trust_tier.dart';
import 'package:growth_pilot_ai/core/models/merchant_trust_score.dart';

/// Computes each merchant's 0-100 trust score (Issue #347, acceptance
/// criterion 1) from logged violations (account suspensions not
/// manually lifted as clean/false positives, and blocked service
/// restrictions — absence of violations) and activity frequency
/// (audited actions on record), reusing the merchant/violation data
/// already logged by #338/#341/#337/#343 rather than a new dataset.
class ComputeMerchantTrustScores {
  static const _violationPenalty = 15;
  static const _activityBonusPerEntry = 2;
  static const _activityBonusCap = 20;
  static const _goldDiscountPercent = 1.0;

  static List<MerchantTrustScore> call(
    List<MerchantConfigEntity> configs,
    List<AccountSuspensionEntity> suspensions,
    List<ServiceRestrictionEntity> restrictions,
    List<AuditLogEntity> auditLogs,
  ) {
    return configs.map((config) {
      final violationCount = suspensions
              .where((s) => s.merchantName == config.businessName && !s.isManuallyLifted)
              .length +
          restrictions
              .where((r) => r.merchantName == config.businessName && r.isBlocked)
              .length;
      final activityCount =
          auditLogs.where((l) => l.targetMerchant == config.businessName).length;

      final activityBonus =
          (activityCount * _activityBonusPerEntry).clamp(0, _activityBonusCap);
      final score = (100 - violationCount * _violationPenalty + activityBonus).clamp(0, 100);
      final tier = score >= 80
          ? MerchantTrustTier.gold
          : score >= 50
              ? MerchantTrustTier.standard
              : MerchantTrustTier.restricted;
      final discount = tier == MerchantTrustTier.gold ? _goldDiscountPercent : 0.0;

      return MerchantTrustScore(
        businessName: config.businessName,
        businessId: config.businessId,
        score: score,
        tier: tier,
        violationCount: violationCount,
        activityCount: activityCount,
        discountPercent: discount,
        effectiveCommissionRate: (config.commissionRatePercent - discount).clamp(0, 100),
      );
    }).toList();
  }
}
