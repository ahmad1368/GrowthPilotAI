import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// "Completion Rate" input for the Trust Score (#135) — the ratio of a
/// business's accepted procurement matches that actually reached a
/// succeeded payment (Issue #147), replacing #135's 0.5 neutral
/// placeholder now that real payment data exists.
class ComputeCompletionRate {
  static double call(
      List<ProcurementRequestEntity> businessRequests, List<PaymentEntity> payments) {
    final accepted =
        businessRequests.where((r) => r.status == ProcurementRequestStatus.accepted).toList();
    if (accepted.isEmpty) return 0.5;

    final succeededRequestIds =
        payments.where((p) => p.isSucceeded).map((p) => p.requestId).toSet();
    final completed = accepted.where((r) => succeededRequestIds.contains(r.id)).length;
    return completed / accepted.length;
  }
}
