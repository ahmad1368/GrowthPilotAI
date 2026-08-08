import 'package:growth_pilot_ai/business/submit_interac_reference.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_intent_status.dart';

/// "Requiring Admin Review before marking as Paid" (Issue #147) — this
/// app has no admin/moderator queue (same precedent as #124's report
/// handling), so a validated reference number auto-passes review
/// instead of waiting on a human.
class ProcessInteracPayment {
  static bool call(PaymentEntity payment, String referenceNumber, DateTime now) {
    if (!SubmitInteracReference.isValid(referenceNumber)) return false;
    payment.interacReferenceNumber = referenceNumber;
    payment.status = PaymentIntentStatus.succeeded;
    payment.completedAt = now;
    return true;
  }
}
