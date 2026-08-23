import 'package:objectbox/objectbox.dart';

/// One business's claimed Founding Member spot (Issue #191) — grants
/// 6 months of the Pro subscription tier via
/// [ApplyFoundingMemberPremium] at claim time.
@Entity()
class FoundingMemberEntity {
  @Id()
  int id = 0;

  @Unique()
  String businessId;

  int spotNumber;

  @Property(type: PropertyType.date)
  DateTime claimedAt;

  // Issue #192: which marketing channel/campaign drove this signup.
  String? acquisitionSource;
  String? acquisitionCampaign;

  FoundingMemberEntity({
    this.id = 0,
    required this.businessId,
    required this.spotNumber,
    required this.claimedAt,
    this.acquisitionSource,
    this.acquisitionCampaign,
  });
}
