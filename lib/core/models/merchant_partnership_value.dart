/// Customer-overlap synergy tier for a logged merchant partnership
/// (Issue #393).
enum PartnershipSynergyLevel { low, medium, high }

/// One logged partnership's collaborative value read (Issue #393): revenue
/// per joint referral, and how strategically the two customer bases
/// overlap.
class MerchantPartnershipValue {
  final String partnerBusinessName;
  final String partnerCategory;
  final double customerOverlapScore;
  final double jointCampaignRevenue;
  final int referralCount;
  final double revenuePerReferral;
  final PartnershipSynergyLevel synergyLevel;
  final DateTime partneredAt;

  const MerchantPartnershipValue({
    required this.partnerBusinessName,
    required this.partnerCategory,
    required this.customerOverlapScore,
    required this.jointCampaignRevenue,
    required this.referralCount,
    required this.revenuePerReferral,
    required this.synergyLevel,
    required this.partneredAt,
  });

  bool get isHighValue => synergyLevel == PartnershipSynergyLevel.high;
}
