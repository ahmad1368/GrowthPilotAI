import 'package:growth_pilot_ai/core/enum/merchant_trust_tier.dart';

/// A merchant's computed trust score (Issue #347, acceptance criteria
/// 1-3): 0-100, derived from logged violations and activity, with the
/// discount privilege `gold`-tier merchants automatically receive
/// already applied to [effectiveCommissionRate].
class MerchantTrustScore {
  final String businessName;
  final String businessId;
  final int score;
  final MerchantTrustTier tier;
  final int violationCount;
  final int activityCount;
  final double discountPercent;
  final double effectiveCommissionRate;

  const MerchantTrustScore({
    required this.businessName,
    required this.businessId,
    required this.score,
    required this.tier,
    required this.violationCount,
    required this.activityCount,
    required this.discountPercent,
    required this.effectiveCommissionRate,
  });
}
