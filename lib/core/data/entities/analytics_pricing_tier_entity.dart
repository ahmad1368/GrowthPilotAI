import 'package:objectbox/objectbox.dart';

/// A manually-logged custom advanced-analytics pricing tier assignment
/// for a merchant (Issue #336) — this app has no backend billing
/// service, so an admin records each tier assignment/change and its
/// settled invoice amount here, the same lightweight logging pattern
/// [PromotionalOfferEntity] uses.
@Entity()
class AnalyticsPricingTierEntity {
  @Id()
  int id = 0;

  String merchantName;

  String tierName;

  double monthlyFee;

  String previousTierName;

  double previousMonthlyFee;

  double invoicedAmount;

  @Index()
  @Property(type: PropertyType.date)
  DateTime effectiveAt;

  AnalyticsPricingTierEntity({
    this.id = 0,
    required this.merchantName,
    required this.tierName,
    required this.monthlyFee,
    this.previousTierName = '',
    this.previousMonthlyFee = 0,
    required this.invoicedAmount,
    required this.effectiveAt,
  });
}
