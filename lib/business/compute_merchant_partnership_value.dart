import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_partnership_value.dart';

/// Derives each logged partnership's revenue-per-referral and
/// customer-overlap synergy tier (Issue #393) — this app has no automated
/// matching feed, so collaborative value is computed from a merchant's own
/// logged cross-promotion estimates instead.
class ComputeMerchantPartnershipValue {
  static List<MerchantPartnershipValue> call(
      List<MerchantPartnershipEntity> partnerships) {
    final results = partnerships.map((p) {
      final revenuePerReferral =
          p.referralCount > 0 ? p.jointCampaignRevenue / p.referralCount : 0.0;
      final synergyLevel = p.customerOverlapScore >= 70
          ? PartnershipSynergyLevel.high
          : p.customerOverlapScore >= 40
              ? PartnershipSynergyLevel.medium
              : PartnershipSynergyLevel.low;

      return MerchantPartnershipValue(
        partnerBusinessName: p.partnerBusinessName,
        partnerCategory: p.partnerCategory,
        customerOverlapScore: p.customerOverlapScore,
        jointCampaignRevenue: p.jointCampaignRevenue,
        referralCount: p.referralCount,
        revenuePerReferral: revenuePerReferral,
        synergyLevel: synergyLevel,
        partneredAt: p.partneredAt,
      );
    }).toList();

    results.sort((a, b) => b.jointCampaignRevenue.compareTo(a.jointCampaignRevenue));
    return results;
  }
}
