import 'package:objectbox/objectbox.dart';

/// A manually-logged complementary-merchant partnership (Issue #393) —
/// this app has no automated customer-overlap matching feed, so a merchant
/// records their own cross-promotion estimate here, the same lightweight
/// logging pattern [NeighborhoodExpansionEntity] uses.
@Entity()
class MerchantPartnershipEntity {
  @Id()
  int id = 0;

  String partnerBusinessName;

  String partnerCategory;

  double customerOverlapScore;

  double jointCampaignRevenue;

  int referralCount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime partneredAt;

  MerchantPartnershipEntity({
    this.id = 0,
    required this.partnerBusinessName,
    required this.partnerCategory,
    required this.customerOverlapScore,
    required this.jointCampaignRevenue,
    required this.referralCount,
    required this.partneredAt,
  });
}
