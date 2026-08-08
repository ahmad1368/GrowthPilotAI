import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// One business's billing tier (Issue #150) — Stripe Billing itself is
/// infeasible here (no Stripe account), so [SubscriptionRenewalHandler]
/// simulates the renewal charge via the existing [PaymentGateway] mock
/// from #147 instead.
@Entity()
class SubscriptionEntity {
  @Id()
  int id = 0;

  @Unique()
  String businessId;

  int dbTier; // SubscriptionTier index
  int dbStatus; // SubscriptionStatus index

  @Property(type: PropertyType.date)
  DateTime currentPeriodEnd;

  @Property(type: PropertyType.date)
  DateTime? gracePeriodEndsAt;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  SubscriptionEntity({
    this.id = 0,
    required this.businessId,
    this.dbTier = 0, // SubscriptionTier.starter
    this.dbStatus = 0, // SubscriptionStatus.active
    required this.currentPeriodEnd,
    this.gracePeriodEndsAt,
    required this.createdAt,
  });

  SubscriptionTier get tier => SubscriptionTier.values[dbTier];
  set tier(SubscriptionTier value) => dbTier = value.index;
  SubscriptionStatus get status => SubscriptionStatus.values[dbStatus];
  set status(SubscriptionStatus value) => dbStatus = value.index;
}
