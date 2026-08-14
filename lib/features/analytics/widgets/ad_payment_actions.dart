import 'package:growth_pilot_ai/business/activate_campaign_from_payment.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/verify_ad_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_repos.dart';

/// Simulated webhook capture + verification + activation pipeline
/// (Issue #410) — split out of [AdPaymentBody].
class AdPaymentActions {
  final AdPaymentRepos repos;

  AdPaymentActions(this.repos);

  ({AdPaymentEntity payment, AdvertisingRequestEntity request}) processPayment(
      AdvertisingRequestEntity request, double amountPaid) {
    final now = DateTime.now();
    final status = VerifyAdPayment.call(request: request, amountPaid: amountPaid);
    final payment = AdPaymentEntity(
        advertisingRequestId: request.id,
        amountPaid: amountPaid,
        dbStatus: status.index,
        receivedAt: now);
    repos.payments.save(payment);
    if (status != PaymentVerificationStatus.verified) {
      return (payment: payment, request: request);
    }
    return (payment: payment, request: _activate(request, now));
  }

  AdvertisingRequestEntity _activate(AdvertisingRequestEntity request, DateTime now) {
    final result = ActivateCampaignFromPayment.call(
        request: request, existingConstraint: repos.constraints.forRequest(request.id), now: now);
    repos.requests.save(result.request);
    repos.constraints.save(result.constraint);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'auto-activated via verified payment',
      targetMerchant: request.merchantName,
      previousValue: 'pending',
      newValue: 'approved',
    ));
    return result.request;
  }
}
