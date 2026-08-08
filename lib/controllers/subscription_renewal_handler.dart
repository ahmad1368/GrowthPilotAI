import 'package:growth_pilot_ai/business/apply_grace_period.dart';
import 'package:growth_pilot_ai/business/compute_subscription_renewal_charge.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';
import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';

/// "Seamless recurring billing" (Issue #150) via #147's [PaymentGateway]
/// mock — free [SubscriptionTier.starter] renewals never touch the
/// gateway at all.
class SubscriptionRenewalHandler {
  final PaymentGateway gateway;
  final SubscriptionRepository subscriptions;

  SubscriptionRenewalHandler(this.gateway, this.subscriptions);

  Future<bool> renew(SubscriptionEntity subscription, {required bool applyPst}) async {
    final charge = ComputeSubscriptionRenewalCharge.call(subscription.tier, applyPst: applyPst);
    if (charge.total == 0) {
      subscription.status = SubscriptionStatus.active;
      subscription.currentPeriodEnd = subscription.currentPeriodEnd.add(const Duration(days: 30));
      subscriptions.upsert(subscription);
      return true;
    }

    final intent = await gateway.createPaymentIntent(amount: charge.total, currency: 'CAD');
    final confirmed = intent.success && intent.data != null
        ? await gateway.confirmPayment(intent.data!)
        : null;

    if (confirmed != null && confirmed.success && confirmed.data == true) {
      subscription.status = SubscriptionStatus.active;
      subscription.gracePeriodEndsAt = null;
      subscription.currentPeriodEnd = subscription.currentPeriodEnd.add(const Duration(days: 30));
    } else {
      ApplyGracePeriod.call(subscription, DateTime.now());
    }
    subscriptions.upsert(subscription);
    return subscription.status == SubscriptionStatus.active;
  }
}
