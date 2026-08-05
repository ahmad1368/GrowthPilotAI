import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/email_campaign_status.dart';

/// A merchant-marketing email campaign (Issue #407) — composed and
/// dispatched locally since this app has no SMTP backend.
@Entity()
class MarketingCampaignEntity {
  @Id()
  int id = 0;

  String subject;
  String bodyMarkup;
  String segmentCategory;
  String segmentRegion;
  int minPaymentReliability;
  int dbRequiredTier; // AdPackageType index
  int dbStatus; // EmailCampaignStatus index
  double openRate;
  double clickRate;
  double bounceRate;

  @Index()
  @Property(type: PropertyType.date)
  DateTime scheduledAt;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  MarketingCampaignEntity({
    this.id = 0,
    required this.subject,
    required this.bodyMarkup,
    required this.segmentCategory,
    required this.segmentRegion,
    required this.minPaymentReliability,
    required this.dbRequiredTier,
    this.dbStatus = 0, // EmailCampaignStatus.draft
    this.openRate = 0,
    this.clickRate = 0,
    this.bounceRate = 0,
    required this.scheduledAt,
    required this.createdAt,
  });

  AdPackageType get requiredTier => AdPackageType.values[dbRequiredTier];
  set requiredTier(AdPackageType value) => dbRequiredTier = value.index;
  EmailCampaignStatus get status => EmailCampaignStatus.values[dbStatus];
  set status(EmailCampaignStatus value) => dbStatus = value.index;
}
