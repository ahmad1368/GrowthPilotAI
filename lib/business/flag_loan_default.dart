import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// Marks an overdue, unpaid loan as defaulted (Issue #419, acceptance
/// criterion 5) — the caller also suspends the credit account via
/// [SuspendCreditAccount].
class FlagLoanDefault {
  static MicroCreditLoanEntity call(MicroCreditLoanEntity loan) {
    return MicroCreditLoanEntity(
      id: loan.id,
      creditAccountId: loan.creditAccountId,
      escrowAccountId: loan.escrowAccountId,
      principal: loan.principal,
      feeAmount: loan.feeAmount,
      termDays: loan.termDays,
      dbStatus: MicroCreditLoanStatus.defaulted.index,
      disbursedAt: loan.disbursedAt,
      dueDate: loan.dueDate,
    );
  }
}
