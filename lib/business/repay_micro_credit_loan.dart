import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// Records a loan as repaid (Issue #419, acceptance criterion 4) —
/// this app has no real settlement-deduction pipeline, so "automated
/// deductions from future sales settlements" is this manual
/// confirmation, the same simplification [ConfirmEscrowDelivery]
/// (#415) uses for its own manual confirmation step.
class RepayMicroCreditLoan {
  static MicroCreditLoanEntity call(MicroCreditLoanEntity loan) {
    return MicroCreditLoanEntity(
      id: loan.id,
      creditAccountId: loan.creditAccountId,
      escrowAccountId: loan.escrowAccountId,
      principal: loan.principal,
      feeAmount: loan.feeAmount,
      termDays: loan.termDays,
      dbStatus: MicroCreditLoanStatus.repaid.index,
      disbursedAt: loan.disbursedAt,
      dueDate: loan.dueDate,
    );
  }
}
