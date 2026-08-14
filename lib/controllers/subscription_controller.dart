import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/check_feature_gate.dart';
import 'package:growth_pilot_ai/business/find_or_create_subscription.dart';
import 'package:growth_pilot_ai/business/is_grace_period_expired.dart';
import 'package:growth_pilot_ai/business/is_renewal_notification_due.dart';
import 'package:growth_pilot_ai/business/is_within_broadcast_limit.dart';
import 'package:growth_pilot_ai/controllers/subscription_renewal_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';
import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';

/// "Three tiers via Stripe Billing" (Issue #150): feature gating,
/// procurement-broadcast quotas, and simulated renewal billing.
class SubscriptionController extends GetxController {
  late SubscriptionRepository _subscriptions;
  late SubscriptionRenewalHandler _renewalHandler;

  @override
  void onInit() {
    super.onInit();
    _subscriptions = SubscriptionRepository(Get.find<ObjectBox>().store.box());
    _renewalHandler =
        SubscriptionRenewalHandler(DependencyInjection.get<PaymentGateway>(), _subscriptions);
  }

  SubscriptionEntity subscriptionFor(String businessId) {
    final subscription =
        FindOrCreateSubscription.call(_subscriptions.getForBusiness(businessId), businessId, DateTime.now());
    if (subscription.id == 0) subscription.id = _subscriptions.upsert(subscription);
    return subscription;
  }

  bool canAccessFeature(SubscriptionEntity subscription, SubscriptionTier requiredTier) =>
      CheckFeatureGate.call(currentTier: subscription.tier, requiredTier: requiredTier);

  bool canOpenBroadcast(SubscriptionEntity subscription, int currentMonthCount) =>
      IsWithinBroadcastLimit.call(tier: subscription.tier, currentMonthCount: currentMonthCount);

  bool isRenewalNoticeDue(SubscriptionEntity subscription) =>
      IsRenewalNotificationDue.call(subscription.currentPeriodEnd, DateTime.now());

  bool isGraceExpired(SubscriptionEntity subscription) =>
      IsGracePeriodExpired.call(subscription, DateTime.now());

  Future<bool> renew(SubscriptionEntity subscription, {required bool applyPst}) =>
      _renewalHandler.renew(subscription, applyPst: applyPst);

  void cancel(SubscriptionEntity subscription) {
    subscription.status = SubscriptionStatus.canceled;
    _subscriptions.upsert(subscription);
  }
}
