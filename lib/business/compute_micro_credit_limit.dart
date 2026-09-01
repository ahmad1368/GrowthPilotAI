import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// Instant credit-scoring heuristic for a merchant's micro-credit
/// limit (Issue #419, acceptance criterion 1) — this app has no
/// credit-bureau or real scoring-model backend, so the limit is 15%
/// of trailing revenue, halved per past default as a repayment-
/// reliability penalty, floored at zero.
class ComputeMicroCreditLimit {
  static const revenueShare = 0.15;

  static double call(double trailingRevenue, List<MicroCreditLoanEntity> pastLoans) {
    final defaults =
        pastLoans.where((l) => l.status == MicroCreditLoanStatus.defaulted).length;
    final baseLimit = trailingRevenue * revenueShare;
    final penaltyFactor = 1 / (1 << defaults); // halve per past default
    return (baseLimit * penaltyFactor).clamp(0, double.infinity);
  }
}
